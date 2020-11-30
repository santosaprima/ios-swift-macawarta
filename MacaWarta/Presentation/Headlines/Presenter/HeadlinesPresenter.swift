//
//  HeadlinesPresenter.swift
//  MacaWarta
//
//  Created by Prima Santosa on 08/11/20.
//

import Foundation
import Combine

class HeadlinesPresenter: ObservableObject {
  private var cancellables: Set<AnyCancellable> = []
  private let useCase: HeadlinesUseCase
  private let networkMonitor = NetworkMonitor.shared
  private var page = 1
  private var country = ""

  @Published var headlines: [ArticleModel] = []
  @Published var errorMessage = ""
  @Published var isLoading = false
  @Published var canLoadNext = true

  init(useCase: HeadlinesUseCase) {
    self.useCase = useCase
    networkMonitor.start()
  }

  deinit {
    networkMonitor.stop()
  }

  func getHeadlines(in country: String) {
    self.errorMessage = ""

    if headlines.isEmpty {
      isLoading = true
    }

    if country != self.country {
      self.country = country
      page = 1
      headlines.removeAll()
      isLoading = true
    }

    // Developer accounts are limited to a max of 100 results.
    // 25 articles per page * 4 pages = 100 results
    if page < 5 {
      useCase.getHeadlines(
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
        self.headlines = results.articles
        self.page += 1
        self.canLoadNext = results.canLoadMore
      })
      .store(in: &cancellables)
    }
  }
}
