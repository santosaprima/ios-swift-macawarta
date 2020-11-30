//
//  CategoryDetailInteractor.swift
//  MacaWarta
//
//  Created by Prima Santosa on 09/11/20.
//

import Foundation
import Combine

protocol CategoryDetailUseCase {
  func getNews(
    from category: String,
    in country: String,
    page: Int,
    isConnected: Bool
  ) -> AnyPublisher<(articles: [ArticleModel], canLoadMore: Bool), Error>
}

class CategoryDetailInteractor: CategoryDetailUseCase {
  private var repository: WartaRepository

  init(repository: WartaRepository) {
    self.repository = repository
  }

  func getNews(
    from category: String,
    in country: String,
    page: Int,
    isConnected: Bool
  ) -> AnyPublisher<(articles: [ArticleModel], canLoadMore: Bool), Error> {
    return repository.getNews(
      from: category,
      in: country,
      page: page,
      isConnected: isConnected
    )
  }
}
