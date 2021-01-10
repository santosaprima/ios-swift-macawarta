//
//  SearchRepository.swift
//  
//
//  Created by Prima Santosa on 10/01/21.
//

import Foundation
import Combine
import Core

public struct SearchRepository<
  SearchRemoteDataSource: RemoteDataSource,
  Transformer: Mapper>: Repository
where
  SearchRemoteDataSource.Response == (response: [ArticleResponse], total: Int),
  SearchRemoteDataSource.Request == (keyword: String, page: Int),
  Transformer.Response == [ArticleResponse],
  Transformer.Model == [ArticleModel],
  Transformer.Entity == Any,
  Transformer.Request == Any {

  public typealias Request = (keyword: String, page: Int)
  public typealias Response = (articles: [ArticleModel], total: Int)

  private let _remoteDataSource: SearchRemoteDataSource
  private let _mapper: Transformer

  public init(
    remoteDataSource: SearchRemoteDataSource,
    mapper: Transformer
  ) {
    _remoteDataSource = remoteDataSource
    _mapper = mapper
  }

  public func execute(
    request: (keyword: String, page: Int)?
  ) -> AnyPublisher<(articles: [ArticleModel], total: Int), Error> {
    guard let request = request else { fatalError("Request cannot be empty") }

    // When searching for an article, the results sometimes contain duplicate articles with same ID.
    // This will result in app crash because List tries to render same identifiable elements.
    // Using Set to remove those duplicates.
    var articlesSet: Set<ArticleModel> = []

    return self._remoteDataSource.execute(request: (keyword: request.keyword, page: request.page))
      .map { results in
        print(results.response)
        let articleModel = _mapper.transformResponseToModel(response: results.response)
        articleModel.forEach { article in
          articlesSet.insert(article)
        }

        let total = results.total
        let articles = Array(articlesSet)
        return (articles: articles, total: total)
      }
      .eraseToAnyPublisher()
  }

  public func localExecute(request: (keyword: String, page: Int)?) {
    fatalError()
  }
}
