//
//  ArticleDetailInteractor.swift
//  MacaWarta
//
//  Created by Prima Santosa on 11/11/20.
//

import Foundation
import Combine

protocol ArticleDetailUseCase {
  func addFavoriteArticle(article: ArticleModel)
  func getFavoriteArticles() -> AnyPublisher<[ArticleModel], Error>
  func removeFavoriteArticle(withTitle title: String)
}

class ArticleDetailInteractor: ArticleDetailUseCase {
  private var repository: WartaRepository

  init(repository: WartaRepository) {
    self.repository = repository
  }

  func addFavoriteArticle(article: ArticleModel) {
    repository.addFavoriteArticle(article: article)
  }

  func getFavoriteArticles() -> AnyPublisher<[ArticleModel], Error> {
    return repository.getFavoriteArticles()
  }

  func removeFavoriteArticle(withTitle title: String) {
    repository.removeFavoriteArticle(withTitle: title)
  }
}
