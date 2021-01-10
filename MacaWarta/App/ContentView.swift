//
//  ContentView.swift
//  MacaWarta
//
//  Created by Prima Santosa on 08/11/20.
//

import SwiftUI
import Core
import Headlines
import Search
import Favorite
import RealmSwift

struct ContentView: View {
  let headlinesPresenter: HeadlinesPresenter<
    Interactor<
      (country: String, page: Int, isConnected: Bool),
      (articles: [ArticleModel], canLoadMore: Bool),
      HeadlinesRepository<
        HeadlinesLocalDataSource,
        HeadlinesRemoteDataSource,
        HeadlinesTransformer
      >
    >
  >
  let searchPresenter: SearchPresenter<
    Interactor<
      (keyword: String, page: Int),
      (articles: [ArticleModel], total: Int),
      SearchRepository<
        SearchRemoteDataSource,
        SearchTransformer
      >
    >
  >
  let favoritePresenter: FavoritePresenter<
    Interactor<
      Any,
      [ArticleModel],
      GetFavoriteRepository<
        FavoriteLocalDataSource,
        GetFavoriteTransformer
      >
    >
  >

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
      useCase: Interactor(
        repository: HeadlinesRepository(
          localDataSource: HeadlinesLocalDataSource(realm: Init.realm),
          remoteDataSource: HeadlinesRemoteDataSource(),
          mapper: HeadlinesTransformer())
      )
    )
    let searchPresenter = SearchPresenter(
      useCase: Interactor(
        repository: SearchRepository(
          remoteDataSource: SearchRemoteDataSource(),
          mapper: SearchTransformer()
        )
      )
    )
    let favoritePresenter = FavoritePresenter(
      useCase: Interactor(
        repository: GetFavoriteRepository(
          localDataSource: FavoriteLocalDataSource(realm: Init.realm),
          mapper: GetFavoriteTransformer()
        )
      )
    )

    ContentView(
      headlinesPresenter: headlinesPresenter,
      searchPresenter: searchPresenter,
      favoritePresenter: favoritePresenter
    )
  }
}
