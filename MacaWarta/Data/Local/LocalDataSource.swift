//
//  LocalDataSource.swift
//  MacaWarta
//
//  Created by Prima Santosa on 08/11/20.
//

import Foundation
import Combine
import RealmSwift

protocol LocalDataSourceProtocol: class {
  func getNews(
    in country: String,
    from category: String
  ) -> AnyPublisher<NewsEntity, Error>

  func addNews(
    from entity: NewsEntity,
    page: Int
  ) -> AnyPublisher<Bool, Error>

  func getFavoriteArticles() -> AnyPublisher<[ArticleEntity], Error>

  func addFavoriteArticle(entity: ArticleEntity)

  func removeFavoriteArticle(withTitle title: String)
}

final class LocalDataSource: LocalDataSourceProtocol {
  private let realm: Realm?

  init(realm: Realm?) {
    self.realm = realm
  }

  static let shared = LocalDataSource(realm: try? Realm())

  func getNews(
    in country: String,
    from category: String
  ) -> AnyPublisher<NewsEntity, Error> {
    return Future<NewsEntity, Error> { completion in
      if let realm = self.realm {
        let currentEntityResults: Results<NewsEntity> = {
          realm.objects(NewsEntity.self)
            .filter("country = '\(country)' AND category = '\(category)'")
        }()

        let newsEntity = NewsEntity()
        currentEntityResults.forEach { currentEntity in
          currentEntity.articles.forEach { article in
            newsEntity.articles.append(article)
          }
          newsEntity.category = currentEntity.category
          newsEntity.country = currentEntity.country
          newsEntity.totalResults = currentEntity.totalResults
        }

        completion(.success(newsEntity))
      } else {
        print("Can't init realm. Schema change?")
      }
    }.eraseToAnyPublisher()
  }

  func addNews(
    from entity: NewsEntity,
    page: Int
  ) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      if let realm = self.realm {
        let currentEntityResults: Results<NewsEntity> = {
          realm.objects(NewsEntity.self)
            .filter("id = '\(entity.id)'")
        }()

        let favoriteArticleResults: Results<ArticleEntity> = {
          realm.objects(ArticleEntity.self)
            .filter("isFavorite = true")
        }()

        let favoriteArticles = Array(favoriteArticleResults)

        try? realm.write {
          if page == 1 {
            realm.delete(currentEntityResults)
          }

          let newsEntity = NewsEntity()
          currentEntityResults.forEach { currentEntity in
            currentEntity.articles.forEach { currentArticle in
              newsEntity.articles.append(currentArticle)
            }
            newsEntity.id = currentEntity.id
            newsEntity.category = currentEntity.category
            newsEntity.country = currentEntity.country
            newsEntity.totalResults = currentEntity.totalResults
          }

          if entity.id == newsEntity.id {
            newsEntity.articles.append(objectsIn: entity.articles)
            realm.delete(currentEntityResults)
            realm.add(newsEntity, update: .modified)
          } else {
            realm.add(entity, update: .modified)
          }

          favoriteArticles.forEach { article in
            article.isFavorite = true
            realm.add(article, update: .modified)
          }

          completion(.success(true))
        }
      } else {
        print("Can't init realm. Schema change?")
      }
    }.eraseToAnyPublisher()
  }

  func getFavoriteArticles() -> AnyPublisher<[ArticleEntity], Error> {
    return Future<[ArticleEntity], Error> { completion in
      if let realm = self.realm {
        let favoriteArticleResults: Results<ArticleEntity> = {
          realm.objects(ArticleEntity.self)
            .filter("isFavorite = true")
        }()
        completion(.success(Array(favoriteArticleResults)))
      } else {
        print("Can't init realm. Schema change?")
      }
    }.eraseToAnyPublisher()
  }

  func addFavoriteArticle(entity: ArticleEntity) {
    if let realm = self.realm {
      try? realm.write {
        realm.add(entity, update: .modified)
      }
    } else {
      print("Can't init realm. Schema change?")
    }
  }

  func removeFavoriteArticle(withTitle title: String) {
    if let realm = self.realm {
      let articleToDeleteResults: Results<ArticleEntity> = {
        realm.objects(ArticleEntity.self)
          .filter("title = \"\(title)\"")
      }()
      try? realm.write {
        realm.delete(articleToDeleteResults)
      }
    } else {
      print("Can't init realm. Schema change?")
    }
  }
}
