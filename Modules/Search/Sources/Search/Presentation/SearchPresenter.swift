//
//  SearchPresenter.swift
//  MacaWarta
//
//  Created by Prima Santosa on 09/11/20.
//

import Foundation
import Combine
import Core

public class SearchPresenter<SearchUseCase: UseCase>: ObservableObject
where
  SearchUseCase.Request == (keyword: String, page: Int),
  SearchUseCase.Response == (articles: [ArticleModel], total: Int) {

  private var cancellables: Set<AnyCancellable> = []
  private let useCase: SearchUseCase
  private var page = 1
  private var keyword = ""

  @Published public var results: [ArticleModel] = []
  @Published public var total = 1
  @Published public var errorMessage = ""
  @Published public var isLoading = false
  @Published public var canLoadNext = true

  public init(useCase: SearchUseCase) {
    self.useCase = useCase
  }

  public func searchNews(withKeyword keyword: String) {
    self.errorMessage = ""

    if results.isEmpty {
      isLoading = true
    }

    if keyword != self.keyword {
      self.keyword = keyword
      page = 1
      results.removeAll()
      isLoading = true
    }

    // Developer accounts are limited to a max of 100 results.
    // 25 articles per page * 4 pages = 100 results
    if page < 5 {
      useCase.execute(request: (keyword: keyword, page: page))
        .receive(on: RunLoop.main)
        .sink(receiveCompletion: { completion in
          switch completion {
          case .failure:
            self.errorMessage = String(describing: completion)
          case .finished:
            self.isLoading = false
          }
        }, receiveValue: { results in
          if results.articles.isEmpty {
            self.canLoadNext = false
          }
          self.total = results.total
          self.results += results.articles
          self.page += 1
        })
        .store(in: &cancellables)
    }
  }

  public func clearResults() {
    results = []
    total = 1
  }
}
