//
//  SearchInteractor.swift
//  MacaWarta
//
//  Created by Prima Santosa on 09/11/20.
//

import Foundation
import Combine

protocol SearchUseCase {
  func searchNews(
    withKeyword keyword: String,
    page: Int
  ) -> AnyPublisher<(articles: [ArticleModel], total: Int), Error>
}

class SearchInteractor: SearchUseCase {
  private var repository: WartaRepository

  init(repository: WartaRepository) {
    self.repository = repository
  }

  func searchNews(
    withKeyword keyword: String,
    page: Int
  ) -> AnyPublisher<(articles: [ArticleModel], total: Int), Error> {
    return repository.searchNews(withKeyword: keyword, page: page)
  }
}
