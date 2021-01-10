//
//  HeadlinesPresenter.swift
//  MacaWarta
//
//  Created by Prima Santosa on 08/11/20.
//

import Foundation
import Combine
import Core

public class HeadlinesPresenter<HeadlinesUseCase: UseCase>: ObservableObject
where
  HeadlinesUseCase.Request == (country: String, page: Int, isConnected: Bool),
  HeadlinesUseCase.Response == (articles: [ArticleModel], canLoadMore: Bool) {

  private var cancellables: Set<AnyCancellable> = []
  private let useCase: HeadlinesUseCase
  private let networkMonitor = NetworkMonitor.shared
  private var page = 1
  private var country = ""

  @Published public var headlines: [ArticleModel] = []
  @Published public var errorMessage = ""
  @Published public var isLoading = false
  @Published public var canLoadNext = true

  public init(useCase: HeadlinesUseCase) {
    self.useCase = useCase
    networkMonitor.start()
  }

  deinit {
    networkMonitor.stop()
  }

  public func getHeadlines(in country: String) {
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
      useCase.execute(request: (
        country: country,
        page: page,
        isConnected: networkMonitor.status()
      ))
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
