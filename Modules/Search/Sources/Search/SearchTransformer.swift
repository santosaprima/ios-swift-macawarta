//
//  SearchTransformer.swift
//  
//
//  Created by Prima Santosa on 10/01/21.
//

import Foundation
import Core

public struct SearchTransformer: Mapper {
  public typealias Model = [ArticleModel]
  public typealias Response = [ArticleResponse]
  public typealias Request = Any
  public typealias Entity = Any

  public init() {}

  public func transformResponseToModel(response: [ArticleResponse]) -> [ArticleModel] {
    return response.map { article in
      return ArticleModel(
        id: String(describing: article.url),
        source: article.source?.name ?? "No source",
        title: article.title ?? "No title",
        description: article.description ?? "No description",
        author: article.author ?? "No author",
        url: article.url ?? "No url",
        image: article.image ?? "",
        date: article.date?.formatDate() ?? "No date"
      )
    }
  }

  public func transformResponseToEntity(request: Any, response: [ArticleResponse]) -> Any {
    fatalError()
  }

  public func transformEntityToModel(entity: Any) -> [ArticleModel] {
    fatalError()
  }

  public func transformModelToEntity(model: [ArticleModel]) -> Any {
    fatalError()
  }
}
