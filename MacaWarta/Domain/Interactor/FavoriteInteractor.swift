//
//  FavoriteInteractor.swift
//  MacaWarta
//
//  Created by Prima Santosa on 11/11/20.
//

import Foundation
import Combine

protocol FavoriteUseCase {
  func getFavoriteArticles() -> AnyPublisher<[ArticleModel], Error>
}

class FavoriteInteractor: FavoriteUseCase {
  private var repository: WartaRepository

  init(repository: WartaRepository) {
    self.repository = repository
  }

  func getFavoriteArticles() -> AnyPublisher<[ArticleModel], Error> {
    return repository.getFavoriteArticles()
  }
}
