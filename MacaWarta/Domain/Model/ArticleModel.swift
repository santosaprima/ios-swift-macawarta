//
//  ArticleModel.swift
//  MacaWarta
//
//  Created by Prima Santosa on 08/11/20.
//

import Foundation

struct NewsModel {
  let country: String
  let category: String
  let totalResults: Int
  let articles: [ArticleModel]
}

struct ArticleModel: Identifiable, Equatable, Hashable {
  let id: String
  let source: String
  let title: String
  let description: String
  let author: String
  let url: String
  let image: String
  let date: String
}
