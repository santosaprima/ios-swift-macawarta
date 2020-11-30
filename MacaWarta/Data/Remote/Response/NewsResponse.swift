//
//  NewsResponse.swift
//  MacaWarta
//
//  Created by Prima Santosa on 08/11/20.
//

import Foundation

struct NewsResponse: Codable {
  let totalResults: Int
  let articles: [ArticleResponse]
}

struct ArticleResponse: Codable {
  enum CodingKeys: String, CodingKey {
    case source = "source"
    case author = "author"
    case title = "title"
    case description = "description"
    case url = "url"
    case image = "urlToImage"
    case date = "publishedAt"
  }

  let source: ArticleSource?
  let author: String?
  let title: String?
  let description: String?
  let url: String?
  let image: String?
  let date: String?
}

struct ArticleSource: Codable {
  let name: String?
}
