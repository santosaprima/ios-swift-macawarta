//
//  ContentView.swift
//  MacaWarta
//
//  Created by Prima Santosa on 08/11/20.
//

import SwiftUI

struct ContentView: View {
  let headlinesPresenter: HeadlinesPresenter
  let searchPresenter: SearchPresenter
  let favoritePresenter: FavoritePresenter

  var body: some View {
    TabView {
      HeadlinesView(presenter: headlinesPresenter)
        .tabItem {
          Image(systemName: "livephoto")
          Text("Headlines")
        }
      ExploreView()
        .tabItem {
          Image(systemName: "safari")
          Text("Explore")
        }
      FavoriteView(presenter: favoritePresenter)
        .tabItem {
          Image(systemName: "bookmark")
          Text("Favorite")
        }
      SearchView(presenter: searchPresenter)
        .tabItem {
          Image(systemName: "magnifyingglass")
          Text("Search")
        }
      SettingsView()
        .tabItem {
          Image(systemName: "gearshape")
          Text("Settings")
        }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
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

    ContentView(
      headlinesPresenter: headlinesPresenter,
      searchPresenter: searchPresenter,
      favoritePresenter: favoritePresenter
    )
  }
}
