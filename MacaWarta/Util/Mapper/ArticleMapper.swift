//
//  NewsMapper.swift
//  MacaWarta
//
//  Created by Prima Santosa on 08/11/20.
//

import Foundation

final class NewsMapper {
  static func mapNewsResponseToModel(
    from newsResponse: [NewsResponse]
  ) -> [NewsModel] {
    return newsResponse.map { news in
      return NewsModel(
        title: news.title ?? "",
        description: news.description ?? "",
        author: news.author ?? "",
        url: news.url ?? "",
        image: news.image ?? "",
        date: news.date ?? ""
      )
    }
  }
}
