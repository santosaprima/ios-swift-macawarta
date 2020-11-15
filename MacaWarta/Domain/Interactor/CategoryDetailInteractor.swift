//
//  ExploreDetailInteractor.swift
//  MacaWarta
//
//  Created by Prima Santosa on 09/11/20.
//

import Foundation
import Combine

protocol ExploreDetailInteractorProtocol {
  func getNews(
    from category: String,
    in country: String,
    page: Int
  ) -> AnyPublisher<(articles: [ArticleModel], total: Int), Error>
}

class ExploreDetailInteractor: ExploreDetailInteractorProtocol {
  private var repository: WartaRepository
  
  init(repository: WartaRepository) {
    self.repository = repository
  }
  
  func getNews(from category: String, in country: String, page: Int) -> AnyPublisher<(articles: [ArticleModel], total: Int), Error> {
    return repository.getNews(from: category, in: country, page: page)
  }
}
