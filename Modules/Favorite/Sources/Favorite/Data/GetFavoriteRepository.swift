//
//  FavoriteRepository.swift
//  
//
//  Created by Prima Santosa on 10/01/21.
//

import Foundation
import Combine
import Core

public struct GetFavoriteRepository<
  FavoriteLocalDataSource: LocalDataSource,
  Transformer: Mapper>: Repository
where
  FavoriteLocalDataSource.Response == ArticleEntity,
  FavoriteLocalDataSource.Request == Any,
  Transformer.Request == Any,
  Transformer.Response == Any,
  Transformer.Entity == [ArticleEntity],
  Transformer.Model == [ArticleModel] {

  public typealias Request = Any
  public typealias Response = [ArticleModel]

  private let localDataSource: FavoriteLocalDataSource
  private let mapper: Transformer

  public init(
    localDataSource: FavoriteLocalDataSource,
    mapper: Transformer
  ) {
    self.localDataSource = localDataSource
    self.mapper = mapper
  }

  public func execute(request: Any?) -> AnyPublisher<[ArticleModel], Error> {
    return self.localDataSource.get(request: nil)
      .map {
        self.mapper.transformEntityToModel(entity: $0)
      }
      .eraseToAnyPublisher()
  }

  public func localExecute(request: Any?) {
    fatalError()
  }
}
