//
//  HeadlinesInteractor.swift
//  MacaWarta
//
//  Created by Prima Santosa on 08/11/20.
//

import Foundation
import Combine

protocol HeadlinesUseCase {
  func getHeadlines(
    in country: String,
    page: Int,
    isConnected: Bool
  ) -> AnyPublisher<(articles: [ArticleModel], canLoadMore: Bool), Error>
}

class HeadlinesInteractor: HeadlinesUseCase {
  private var repository: WartaRepository

  init(repository: WartaRepository) {
    self.repository = repository
  }

  func getHeadlines(
    in country: String,
    page: Int,
    isConnected: Bool
  ) -> AnyPublisher<(articles: [ArticleModel], canLoadMore: Bool), Error> {
    return repository.getHeadlines(in: country, page: page, isConnected: isConnected)
  }
}
