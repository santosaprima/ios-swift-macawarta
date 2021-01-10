//
//  AddFavoriteRepository.swift
//  
//
//  Created by Prima Santosa on 10/01/21.
//

import Foundation
import Combine
import Core

public struct AddFavoriteRepository<
  FavoriteLocalDataSource: LocalDataSource,
  Transformer: Mapper>: Repository
where
  FavoriteLocalDataSource.Response == ArticleEntity,
  FavoriteLocalDataSource.Request == Any,
  Transformer.Request == Any,
  Transformer.Response == Any,
  Transformer.Entity == ArticleEntity,
  Transformer.Model == ArticleModel {

  public typealias Request = ArticleModel
  public typealias Response = Any

  private let localDataSource: FavoriteLocalDataSource
  private let mapper: Transformer

  public init(
    localDataSource: FavoriteLocalDataSource,
    mapper: Transformer
  ) {
    self.localDataSource = localDataSource
    self.mapper = mapper
  }

  public func localExecute(request: ArticleModel?) {
    guard let request = request else { fatalError("Request cannot be empty") }

    let articleEntity = self.mapper.transformModelToEntity(model: request)
    self.localDataSource.insert(entity: articleEntity)
  }

  public func execute(request: ArticleModel?) -> AnyPublisher<Any, Error> {
    fatalError()
  }
}
