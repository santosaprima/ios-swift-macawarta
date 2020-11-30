//
//  ArticleDetailPresenter.swift
//  MacaWarta
//
//  Created by Prima Santosa on 11/11/20.
//

import Foundation
import Combine

class ArticleDetailPresenter: ObservableObject {
  private var cancellables: Set<AnyCancellable> = []
  private let useCase: ArticleDetailUseCase

  @Published var favoriteArticles: [ArticleModel] = []

  init(useCase: ArticleDetailUseCase) {
    self.useCase = useCase
  }

  func addFavoriteArticle(article: ArticleModel) {
    self.useCase.addFavoriteArticle(article: article)
  }

  func removeFavoriteArticle(withTitle title: String) {
    self.useCase.removeFavoriteArticle(withTitle: title)
  }

  func getFavoriteArticles() {
    useCase.getFavoriteArticles()
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { _ in
      }, receiveValue: { results in
        self.favoriteArticles = results
      })
      .store(in: &cancellables)
  }
}
