//
//  WartaRepository.swift
//  MacaWarta
//
//  Created by Prima Santosa on 08/11/20.
//

import Foundation
import Combine

protocol WartaRepositoryProtocol {
  func getHeadlines(
    in country: String,
    page: Int,
    isConnected: Bool
  ) -> AnyPublisher<(articles: [ArticleModel], canLoadMore: Bool), Error>

  func getNews(
    from category: String,
    in country: String,
    page: Int,
    isConnected: Bool
  ) -> AnyPublisher<(articles: [ArticleModel], canLoadMore: Bool), Error>

  func searchNews(
    withKeyword keyword: String,
    page: Int
  ) -> AnyPublisher<(articles: [ArticleModel], total: Int), Error>

  func getFavoriteArticles() -> AnyPublisher<[ArticleModel], Error>

  func addFavoriteArticle(article: ArticleModel)

  func removeFavoriteArticle(withTitle title: String)
}

final class WartaRepository: WartaRepositoryProtocol {
  fileprivate var remoteDS: RemoteDataSource
  fileprivate var localDS: LocalDataSource

  init(remoteDS: RemoteDataSource, localDS: LocalDataSource) {
    self.remoteDS = remoteDS
    self.localDS = localDS
  }

  static let shared = WartaRepository(
    remoteDS: RemoteDataSource.shared,
    localDS: LocalDataSource.shared
  )
  // MARK: - Headlines
  func getHeadlines(
    in country: String,
    page: Int,
    isConnected: Bool
  ) -> AnyPublisher<(articles: [ArticleModel], canLoadMore: Bool), Error> {
    if isConnected {
      return self.remoteDS.getHeadlines(in: country, page: page)
        .map {
          ArticleMapper.mapNewsResponseToNewsEntity(
            from: $0,
            fromCategory: "",
            in: country
          )
        }
        .flatMap { self.localDS.addNews(from: $0, page: page)}
        .flatMap { _ in self.localDS.getNews(in: country, from: "")
          .map {
            let articleModel = ArticleMapper.mapNewsEntityToModel(from: $0)
            if articleModel.articles.count < articleModel.totalResults {
              return (articles: articleModel.articles, canLoadMore: true)
            } else {
              return (articles: articleModel.articles, canLoadMore: false)
            }
          }
        }.eraseToAnyPublisher()
    } else {
      return self.localDS.getNews(in: country, from: "")
        .map {
          let articleModel = ArticleMapper.mapNewsEntityToModel(from: $0)
          if articleModel.articles.count < articleModel.totalResults {
            return (articles: articleModel.articles, canLoadMore: true)
          } else {
            return (articles: articleModel.articles, canLoadMore: false)
          }
        }
        .eraseToAnyPublisher()
    }
  }

  // MARK: - Explore
  func getNews(
    from category: String,
    in country: String,
    page: Int,
    isConnected: Bool
  ) -> AnyPublisher<(articles: [ArticleModel], canLoadMore: Bool), Error> {
    if isConnected {
      return self.remoteDS.getNews(from: category, in: country, page: page)
        .map {
          ArticleMapper.mapNewsResponseToNewsEntity(
            from: $0,
            fromCategory: category,
            in: country
          )
        }
        .flatMap { self.localDS.addNews(from: $0, page: page) }
        .flatMap { _ in self.localDS.getNews(in: country, from: category)
          .map {
            let articleModel = ArticleMapper.mapNewsEntityToModel(from: $0)
            if articleModel.articles.count < articleModel.totalResults {
              return (articles: articleModel.articles, canLoadMore: true)
            } else {
              return (articles: articleModel.articles, canLoadMore: false)
            }
          }
        }.eraseToAnyPublisher()
    } else {
      return self.localDS.getNews(in: country, from: category)
        .map {
          let articleModel = ArticleMapper.mapNewsEntityToModel(from: $0)
          if articleModel.articles.count < articleModel.totalResults {
            return (articles: articleModel.articles, canLoadMore: true)
          } else {
            return (articles: articleModel.articles, canLoadMore: false)
          }
        }
        .eraseToAnyPublisher()
    }
  }

  // MARK: - Search
  func searchNews(
    withKeyword keyword: String,
    page: Int
  ) -> AnyPublisher<(articles: [ArticleModel], total: Int), Error> {
    // When searching for an article, the results sometimes contain duplicate articles with same ID.
    // This will result in app crash because List tries to render same identifiable elements.
    // Using Set to remove those duplicates.
    var articlesSet: Set<ArticleModel> = []

    return self.remoteDS.searchNews(withKeyword: keyword, page: page)
      .map { results in
        let articleModel = ArticleMapper.mapArticleResponseToModel(from: results.response)
        articleModel.forEach { article in
          articlesSet.insert(article)
        }

        let total = results.total
        let articles = Array(articlesSet)
        return (articles: articles, total: total)
      }
      .eraseToAnyPublisher()
  }

  // MARK: - Favorite
  func getFavoriteArticles() -> AnyPublisher<[ArticleModel], Error> {
    return self.localDS.getFavoriteArticles()
      .map {
        ArticleMapper.mapArticleEntityToModel(from: Array($0))
      }
      .eraseToAnyPublisher()
  }

  func addFavoriteArticle(article: ArticleModel) {
    let articleEntity = ArticleMapper.mapArticleModelToEntity(from: article)
    self.localDS.addFavoriteArticle(entity: articleEntity)
  }

  func removeFavoriteArticle(withTitle title: String) {
    self.localDS.removeFavoriteArticle(withTitle: title)
  }

}
