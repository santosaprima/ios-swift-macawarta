//
//  Service.swift
//  MacaWarta
//
//  Created by Prima Santosa on 08/11/20.
//

import Foundation

private extension URL {
  private static let baseUrl = "https://newsapi.org/v2/"
  private static let perPageSize = 25

  static func makeEndpoint(_ endpoint: String) -> URL {
    URL(string: "\(baseUrl)\(endpoint)")!
  }
}

extension URL {
  private static var apiKey: String {
    guard let filePath = Bundle.main.path(forResource: "News-Info", ofType: "plist") else {
      fatalError("Couldn't find file 'News-Info.plist'.")
    }
    let plist = NSDictionary(contentsOfFile: filePath)
    guard let value = plist?.object(forKey: "API_KEY") as? String else {
      fatalError("Couldn't find key 'API_KEY' in 'News-Info.plist'.")
    }
    return value
  }

  static let bearer = apiKey

  // MARK: - Headlines
  static func headlines(in country: String = "us", page: Int) -> URL {
    makeEndpoint(
      "top-headlines?country=\(country)&page=\(page)&pageSize=\(perPageSize)"
    )
  }

  // MARK: - Explore
  static func news(from category: String, in country: String = "us", page: Int) -> URL {
    makeEndpoint(
      "top-headlines?category=\(category)&country=\(country)&page=\(page)&pageSize=\(perPageSize)"
    )
  }

  // MARK: - Search
  static func news(withKeyword keyword: String, page: Int, sortBy: String = "publishedAt") -> URL {
    makeEndpoint(
      "everything?q=\(keyword)&page=\(page)&pageSize=\(perPageSize)&sortBy=\(sortBy)"
    )
  }
}
