//
//  ArticleMapper.swift
//  MacaWarta
//
//  Created by Prima Santosa on 08/11/20.
//

import Foundation

final class ArticleMapper {
  static func mapNewsResponseToNewsEntity(
    from response: NewsResponse,
    fromCategory category: String,
    in country: String
  ) -> NewsEntity {
    let news = NewsEntity()
    news.id = "\(country)\(category)"
    news.country = country
    news.category = category
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

  static func mapNewsEntityToModel(
    from entity: NewsEntity
  ) -> NewsModel {
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

  static func mapArticleEntityToModel(
    from articleEntity: [ArticleEntity]
  ) -> [ArticleModel] {
    return articleEntity.map { entity in
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

  static func mapArticleModelToEntity(
    from model: ArticleModel
  ) -> ArticleEntity {
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

  static func mapArticleResponseToModel(
    from response: [ArticleResponse]
  ) -> [ArticleModel] {
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
}
