//
//  FavoritePresenter.swift
//  MacaWarta
//
//  Created by Prima Santosa on 11/11/20.
//

import Foundation
import Combine

class FavoritePresenter: ObservableObject {
  private var cancellables: Set<AnyCancellable> = []
  private let useCase: FavoriteUseCase

  @Published var favoriteArticles: [ArticleModel] = []
  @Published var errorMessage = ""
  @Published var isLoading = false

  init(useCase: FavoriteUseCase) {
    self.useCase = useCase
  }

  func getFavoriteArticles() {
    self.errorMessage = ""
    isLoading = true

    useCase.getFavoriteArticles()
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure:
          self.errorMessage = String(describing: completion)
        case .finished:
          self.isLoading = false
        }
      }, receiveValue: { results in
        self.favoriteArticles = results
      })
      .store(in: &cancellables)
  }
}
