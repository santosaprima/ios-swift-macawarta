//
//  ArticleDetailPresenter.swift
//  MacaWarta
//
//  Created by Prima Santosa on 11/11/20.
//

import Foundation
import Combine
import Core

public class ArticleDetailPresenter<
  GetFavoriteUseCase: UseCase,
  AddFavoriteUseCase: UseCase,
  RemoveFavoriteUseCase: UseCase
>: ObservableObject
where
  GetFavoriteUseCase.Request == Any,
  GetFavoriteUseCase.Response == [ArticleModel],
  AddFavoriteUseCase.Request == ArticleModel,
  AddFavoriteUseCase.Response == Any,
  RemoveFavoriteUseCase.Request == String,
  RemoveFavoriteUseCase.Response == Any {

  private var cancellables: Set<AnyCancellable> = []
  private let getFavoriteUseCase: GetFavoriteUseCase
  private let addFavoriteUseCase: AddFavoriteUseCase
  private let removeFavoriteUseCase: RemoveFavoriteUseCase

  @Published public var favoriteArticles: [ArticleModel] = []

  public init(
    getFavoriteUseCase: GetFavoriteUseCase,
    addFavoriteUseCase: AddFavoriteUseCase,
    removeFavoriteUseCase: RemoveFavoriteUseCase
  ) {
    self.getFavoriteUseCase = getFavoriteUseCase
    self.addFavoriteUseCase = addFavoriteUseCase
    self.removeFavoriteUseCase = removeFavoriteUseCase
  }

  public func addFavoriteArticle(article: ArticleModel) {
    self.addFavoriteUseCase.localExecute(request: article)
  }

  public func removeFavoriteArticle(withTitle title: String) {
    self.removeFavoriteUseCase.localExecute(request: title)
  }

  public func getFavoriteArticles() {
    getFavoriteUseCase.execute(request: nil)
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { _ in
      }, receiveValue: { results in
        self.favoriteArticles = results
      })
      .store(in: &cancellables)
  }
}
