//
//  HeadlinesTransformer.swift
//  
//
//  Created by Prima Santosa on 05/01/21.
//

import Foundation
import Core

public struct HeadlinesTransformer: Mapper {
  public typealias Request = (category: String, country: String)
  public typealias Response = NewsResponse
  public typealias Entity = NewsEntity
  public typealias Model = NewsModel

  public init() {}

  public func transformResponseToEntity(
    request: (category: String, country: String),
    response: NewsResponse
  ) -> NewsEntity {
    let news = NewsEntity()
    news.id = "\(request.country)\(request.category)"
    news.country = request.country
    news.category = request.category
    news.totalResults = response.totalResults

    response.articles.forEach { article in
      let articleEntity = ArticleEntity()
      articleEntity.id = String(describing: article.url)
      articleEntity.title = article.title ?? "No title"
      articleEntity.source = article.source?.name ?? "No source"
      articleEntity.author = article.author ?? "No author"
      articleEntity.desc = article.description ?? "No description"
      articleEntity.date = article.date?.formatDate() ?? "No date"
      articleEntity.image = article.image ?? ""
      articleEntity.url = article.url ?? ""
      news.articles.append(articleEntity)
    }

    return news
  }

  public func transformEntityToModel(entity: NewsEntity) -> NewsModel {
    var articles: [ArticleModel] = []
    entity.articles.forEach {
      articles.append(ArticleModel(
        id: $0.title,
        source: $0.source,
        title: $0.title,
        description: $0.desc,
        author: $0.author,
        url: $0.url,
        image: $0.image,
        date: $0.date
      ))
    }

    let news = NewsModel(
      country: entity.country,
      category: entity.category,
      totalResults: entity.totalResults,
      articles: articles
    )
    return news
  }

  public func transformResponseToModel(response: NewsResponse) -> NewsModel {
    fatalError()
  }

  public func transformModelToEntity(model: NewsModel) -> NewsEntity {
    fatalError()
  }
}
