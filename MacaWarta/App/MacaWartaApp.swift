//
//  MacaWartaApp.swift
//  MacaWarta
//
//  Created by Prima Santosa on 08/11/20.
//

import SwiftUI

@main
struct MacaWartaApp: App {
  let headlinesPresenter = HeadlinesPresenter(
    useCase: HeadlinesInteractor(
      repository: WartaRepository.shared
    )
  )
  let searchPresenter = SearchPresenter(
    useCase: SearchInteractor(
      repository: WartaRepository.shared
    )
  )
  let favoritePresenter = FavoritePresenter(
    useCase: FavoriteInteractor(
      repository: WartaRepository.shared
    )
  )

  var body: some Scene {
    WindowGroup {
      ContentView(
        headlinesPresenter: headlinesPresenter,
        searchPresenter: searchPresenter,
        favoritePresenter: favoritePresenter
      )
    }
  }
}
