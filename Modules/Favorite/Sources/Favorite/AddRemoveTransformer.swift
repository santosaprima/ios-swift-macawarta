//
//  AddRemoveTransformer.swift
//  
//
//  Created by Prima Santosa on 10/01/21.
//

import Foundation
import Core

public struct AddRemoveFavoriteTransformer: Mapper {
  public typealias Request = Any
  public typealias Response = Any
  public typealias Entity = ArticleEntity
  public typealias Model = ArticleModel

  public init() {}

  public func transformModelToEntity(model: ArticleModel) -> ArticleEntity {
    let entity = ArticleEntity()
    entity.id = model.id
    entity.author = model.author
    entity.date = model.date
    entity.desc = model.description
    entity.image = model.image
    entity.source = model.source
    entity.title = model.title
    entity.url = model.url
    entity.isFavorite = true

    return entity
  }

  public func transformResponseToEntity(request: Any, response: Any) -> ArticleEntity {
    fatalError()
  }

  public func transformEntityToModel(entity: ArticleEntity) -> ArticleModel {
    fatalError()
  }

  public func transformResponseToModel(response: Any) -> ArticleModel {
    fatalError()
  }
}
