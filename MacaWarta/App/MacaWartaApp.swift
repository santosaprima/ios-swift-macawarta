//
//  MacaWartaApp.swift
//  MacaWarta
//
//  Created by Prima Santosa on 08/11/20.
//

import SwiftUI
import Core
import Headlines
import Favorite
import Search
import RealmSwift

@main
struct MacaWartaApp: App {
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
