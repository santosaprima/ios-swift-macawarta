//
//  CategoryDetailPresenter.swift
//  MacaWarta
//
//  Created by Prima Santosa on 09/11/20.
//

import Foundation
import Combine

class CategoryDetailPresenter: ObservableObject {
  private var cancellables: Set<AnyCancellable> = []
  private let useCase: CategoryDetailUseCase
  private let networkMonitor = NetworkMonitor.shared
  private var page = 1
  private var category = ""

  @Published var articles: [ArticleModel] = []
  @Published var errorMessage = ""
  @Published var isLoading = false
  @Published var canLoadNext = true

  init(useCase: CategoryDetailUseCase) {
    self.useCase = useCase
    networkMonitor.start()
  }

  deinit {
    networkMonitor.stop()
  }

  func getNews(from category: String, in country: String) {
    self.errorMessage = ""

    if articles.isEmpty {
      isLoading = true
    }

    if category != self.category {
      self.category = category
      page = 1
      articles.removeAll()
      isLoading = true
    }

    // Developer accounts are limited to a max of 100 results.
    // 25 articles per page * 4 pages = 100 results
    if page < 5 {
      useCase.getNews(
        from: category,
        in: country,
        page: page,
        isConnected: networkMonitor.status()
      )
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
        self.articles = results.articles
        self.page += 1
        self.canLoadNext = results.canLoadMore
      })
      .store(in: &cancellables)
    }
  }
}
