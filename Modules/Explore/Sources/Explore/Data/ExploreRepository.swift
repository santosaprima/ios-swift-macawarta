//
//  ExploreRepository.swift
//  
//
//  Created by Prima Santosa on 10/01/21.
//

import Foundation
import Combine
import Core

public struct ExploreRepository<
  ExploreLocalDataSource: LocalDataSource,
  ExploreRemoteDataSource: RemoteDataSource,
  Transformer: Mapper>: Repository
where
  ExploreLocalDataSource.Response == NewsEntity,
  ExploreLocalDataSource.Request == (country: String, category: String),
  ExploreRemoteDataSource.Response == NewsResponse,
  ExploreRemoteDataSource.Request == (category: String, country: String, page: Int),
  Transformer.Request == (category: String, country: String),
  Transformer.Response == NewsResponse,
  Transformer.Entity == NewsEntity,
  Transformer.Model == NewsModel {

  public typealias Request = (category: String, country: String, page: Int, isConnected: Bool)
  public typealias Response = (articles: [ArticleModel], canLoadMore: Bool)

  private let localDataSource: ExploreLocalDataSource
  private let remoteDataSource: ExploreRemoteDataSource
  private let _mapper: Transformer

  public init(
    localDataSource: ExploreLocalDataSource,
    remoteDataSource: ExploreRemoteDataSource,
    mapper: Transformer
  ) {
    self.localDataSource = localDataSource
    self.remoteDataSource = remoteDataSource
    _mapper = mapper
  }

  public func execute(
    request: (category: String, country: String, page: Int, isConnected: Bool)?
  ) -> AnyPublisher<(articles: [ArticleModel], canLoadMore: Bool), Error> {
    guard let request = request else { fatalError("Request cannot be empty") }

    if request.isConnected {
      return self.remoteDataSource.execute(
        request: (request.category, request.country, request.page))
        .map {
          _mapper.transformResponseToEntity(
            request: (category: "", country: request.country),
            response: $0
          )
        }
        .flatMap {
          self.localDataSource.add(entity: $0, page: request.page)
        }
        .flatMap {_ in
          self.localDataSource.list(
            request: (country: request.country, category: "")
          )
          .map {
            let model = _mapper.transformEntityToModel(entity: $0)
            if model.articles.count < model.totalResults {
              return (articles: model.articles, canLoadMore: true)
            } else {
              return (articles: model.articles, canLoadMore: false)
            }
          }
        }.eraseToAnyPublisher()
    } else {
      return self.localDataSource.list(
        request: (country: request.country, category: "")
      )
      .map {
        let model = _mapper.transformEntityToModel(entity: $0)
        if model.articles.count < model.totalResults {
          return (articles: model.articles, canLoadMore: true)
        } else {
          return (articles: model.articles, canLoadMore: false)
        }
      }.eraseToAnyPublisher()
    }
  }

  public func localExecute(request: (category: String, country: String, page: Int, isConnected: Bool)?) {
    fatalError()
  }
}
