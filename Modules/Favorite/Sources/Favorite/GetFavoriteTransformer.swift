//
//  GetFavoriteTransformer.swift
//  
//
//  Created by Prima Santosa on 10/01/21.
//

import Foundation
import Core

public struct GetFavoriteTransformer: Mapper {
  public typealias Request = Any
  public typealias Response = Any
  public typealias Entity = [ArticleEntity]
  public typealias Model = [ArticleModel]

  public init() {}

  public func transformEntityToModel(entity: [ArticleEntity]) -> [ArticleModel] {
    return entity.map { entity in
      return ArticleModel(
        id: entity.id,
        source: entity.source,
        title: entity.title,
        description: entity.desc,
        author: entity.author,
        url: entity.url,
        image: entity.image,
        date: entity.date
      )
    }
  }

  public func transformResponseToModel(response: Any) -> [ArticleModel] {
    fatalError()
  }

  public func transformModelToEntity(model: [ArticleModel]) -> [ArticleEntity] {
    fatalError()
  }

  public func transformResponseToEntity(request: Any, response: Any) -> [ArticleEntity] {
    fatalError()
  }
}
