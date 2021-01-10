//
//  RemoveFavoriteRepository.swift
//  
//
//  Created by Prima Santosa on 10/01/21.
//

import Foundation
import Combine
import Core

public struct RemoveFavoriteRepository<
  FavoriteLocalDataSource: LocalDataSource
>: Repository
where
  FavoriteLocalDataSource.Response == ArticleEntity,
  FavoriteLocalDataSource.Request == Any {

  public typealias Request = String
  public typealias Response = Any

  private let localDataSource: FavoriteLocalDataSource

  public init(localDataSource: FavoriteLocalDataSource) {
    self.localDataSource = localDataSource
  }

  public func localExecute(request: String?) {
    guard let request = request else { fatalError("Request cannot be empty") }

    self.localDataSource.remove(title: request)
  }

  public func execute(request: String?) -> AnyPublisher<Any, Error> {
    fatalError()
  }
}
