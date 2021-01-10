//
//  FavoritePresenter.swift
//  MacaWarta
//
//  Created by Prima Santosa on 11/11/20.
//

import Foundation
import Combine
import Core

public class FavoritePresenter<
  GetFavoriteUseCase: UseCase
>: ObservableObject
where
  GetFavoriteUseCase.Request == Any,
  GetFavoriteUseCase.Response == [ArticleModel] {

  private var cancellables: Set<AnyCancellable> = []
  private let useCase: GetFavoriteUseCase

  @Published public var favoriteArticles: [ArticleModel] = []
  @Published public var errorMessage = ""
  @Published public var isLoading = false

  public init(useCase: GetFavoriteUseCase) {
    self.useCase = useCase
  }

  public func getFavoriteArticles() {
    self.errorMessage = ""
    isLoading = true

    useCase.execute(request: nil)
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
