//
//  HeadlinesView.swift
//  MacaWarta
//
//  Created by Prima Santosa on 08/11/20.
//

import SwiftUI
import Core
import Headlines
import Favorite

struct HeadlinesView: View {
  @StateObject var presenter: HeadlinesPresenter<
      Interactor<
        (country: String, page: Int, isConnected: Bool),
        (articles: [ArticleModel], canLoadMore: Bool),
        HeadlinesRepository<
          HeadlinesLocalDataSource,
          HeadlinesRemoteDataSource,
          HeadlinesTransformer>
      >
    >
  @AppStorage("country") var country = "United States"
  @AppStorage("articleStyle") var articleStyle = "Card"
  @State private var currentSelectedCountry = ""

  var body: some View {
    NavigationView {
      VStack {
        if presenter.isLoading {
          ProgressView()
        }

        if !presenter.errorMessage.isEmpty {
          Text("Error while loading data")
          Button(action: {
            let countryID = Selection.countries[country] ?? "us"
            presenter.getHeadlines(in: countryID)
          }, label: {
            Text("Try Again")
          })
        }

        if presenter.headlines.isEmpty {
          if !presenter.isLoading && presenter.errorMessage.isEmpty {
            Image(systemName: "livephoto")
              .font(.system(size: 104))
              .padding(.bottom, 16)
              .foregroundColor(.gray)
            Text("No headline news")
              .font(.headline)
              .foregroundColor(.gray)
          }
        } else {
          ScrollView {
            LazyVStack {
              ForEach(presenter.headlines) { article in
                NavigationLink(
                  destination: ArticleDetailView(
                    article: article,
                    presenter: ArticleDetailPresenter(
                      getFavoriteUseCase: Interactor(
                        repository: GetFavoriteRepository(
                          localDataSource: FavoriteLocalDataSource(realm: Init.realm),
                          mapper: GetFavoriteTransformer())
                      ),
                      addFavoriteUseCase: Interactor(
                        repository: AddFavoriteRepository(
                          localDataSource: FavoriteLocalDataSource(realm: Init.realm),
                          mapper: AddRemoveFavoriteTransformer())),
                      removeFavoriteUseCase: Interactor(
                        repository: RemoveFavoriteRepository(
                          localDataSource: FavoriteLocalDataSource(realm: Init.realm)
                        )
                      )
                    )
                  ),
                  label: {
                    if articleStyle == "Card" {
                      ArticlesRowCardView(article: article)
                    } else {
                      ArticlesRowClassicView(article: article)
                    }
                  }
                ).buttonStyle(PlainButtonStyle())
                .onAppear {
                  if self.presenter.headlines.last == article
                      && self.presenter.canLoadNext {
                    let countryID = Selection.countries[country] ?? "us"
                    presenter.getHeadlines(in: countryID)
                  }
                }
              }
            }
          }
        }
      }
      .navigationBarTitle("Headlines")
      .onAppear {
        if presenter.headlines.isEmpty || Selection.countries[country] != currentSelectedCountry {
          currentSelectedCountry = Selection.countries[country] ?? "us"
          let countryID = currentSelectedCountry
          presenter.getHeadlines(in: countryID)
        }
      }
    }
  }
}

 struct HeadlinesView_Previews: PreviewProvider {
  static var previews: some View {
    let presenter = HeadlinesPresenter(
      useCase: Interactor(
        repository: HeadlinesRepository(
          localDataSource: HeadlinesLocalDataSource(realm: Init.realm),
          remoteDataSource: HeadlinesRemoteDataSource(),
          mapper: HeadlinesTransformer()
        )
      )
    )
    HeadlinesView(presenter: presenter)
  }
 }
