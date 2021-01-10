//
//  NewsResponse.swift
//  
//
//  Created by Prima Santosa on 10/01/21.
//

import Foundation

public struct NewsResponse: Codable {
  public let totalResults: Int
  public let articles: [ArticleResponse]
}

public struct ArticleResponse: Codable {
  enum CodingKeys: String, CodingKey {
    case source = "source"
    case author = "author"
    case title = "title"
    case description = "description"
    case url = "url"
    case image = "urlToImage"
    case date = "publishedAt"
  }

  public let source: ArticleSource?
  public let author: String?
  public let title: String?
  public let description: String?
  public let url: String?
  public let image: String?
  public let date: String?
}

public struct ArticleSource: Codable {
  public let name: String?
}
