//
//  ArticleModel.swift
//  
//
//  Created by Prima Santosa on 10/01/21.
//

import Foundation

public struct NewsModel {
  public let country: String
  public let category: String
  public let totalResults: Int
  public let articles: [ArticleModel]

  public init(
    country: String,
    category: String,
    totalResults: Int,
    articles: [ArticleModel]
  ) {
    self.country = country
    self.category = category
    self.totalResults = totalResults
    self.articles = articles
  }
}

public struct ArticleModel: Identifiable, Equatable, Hashable {
  public let id: String
  public let source: String
  public let title: String
  public let description: String
  public let author: String
  public let url: String
  public let image: String
  public let date: String

  public init(
    id: String,
    source: String,
    title: String,
    description: String,
    author: String,
    url: String,
    image: String,
    date: String
  ) {
    self.id = id
    self.source = source
    self.title = title
    self.description = description
    self.author = author
    self.url = url
    self.image = image
    self.date = date
  }
}
