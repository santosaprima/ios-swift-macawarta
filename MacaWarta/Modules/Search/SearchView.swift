//
//  SearchView.swift
//  MacaWarta
//
//  Created by Prima Santosa on 08/11/20.
//

import SwiftUI
import Search
import Core
import Favorite

struct SearchView: View {
  @StateObject var presenter: SearchPresenter<
    Interactor<
      (keyword: String, page: Int),
      (articles: [ArticleModel], total: Int),
      SearchRepository<
        SearchRemoteDataSource,
        SearchTransformer
      >
    >
  >
  @State private var keyword = ""
  @State private var loadInit = true

  var body: some View {
    NavigationView {
      VStack {
        TextField(
          "Search for an article",
          text: self.$keyword,
          onCommit: {
            searchArticle()
          }
        )
        .padding(10)
        .padding(.horizontal, 10)
        .background(Color(.systemGray6))
        .cornerRadius(8)
        .padding()

        if loadInit {
          Spacer()
          Image(systemName: "magnifyingglass")
            .font(.system(size: 104))
            .foregroundColor(.gray)
            .padding(.bottom, 16)
          Text("Start by typing a keyword")
            .font(.headline)
            .foregroundColor(.gray)
          Spacer()
        }

        if presenter.isLoading {
          Spacer()
          ProgressView()
          Spacer()
        }

        if !presenter.errorMessage.isEmpty {
          Spacer()
          Text("Error while loading data.")
            .font(.headline)
          Button(action: {
            self.searchArticle()
          }, label: {
            Text("Retry")
          })
          Spacer()
        }

        if presenter.total == 0 {
          Spacer()
          Image(systemName: "book")
            .font(.system(size: 104))
            .padding(.bottom, 16)
            .foregroundColor(.gray)
          Text("No article found")
            .font(.headline)
            .foregroundColor(.gray)
          Spacer()
        }

        if !presenter.results.isEmpty {
          ScrollView {
            LazyVStack {
              ForEach(presenter.results) { article in
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
                    ArticlesRowClassicView(article: article)
                  }
                ).buttonStyle(PlainButtonStyle())
                .onAppear {
                  if self.presenter.results.last == article
                      && self.presenter.canLoadNext {
                    self.loadNextPage()
                  }
                }
              }
            }
          }
        }
      }
      .navigationBarTitle("Search")
    }
  }

  func searchArticle() {
    if keyword == "" {
      return
    }

    if loadInit {
      loadInit.toggle()
    }

    let filteredKeyword = keyword.replacingOccurrences(of: " ", with: "-")
    self.presenter.clearResults()
    self.presenter.searchNews(withKeyword: filteredKeyword)
  }

  func loadNextPage() {
    self.presenter.searchNews(withKeyword: keyword)
  }

  struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
      let presenter = SearchPresenter(
        useCase: Interactor(
          repository: SearchRepository(
            remoteDataSource: SearchRemoteDataSource(),
            mapper: SearchTransformer()
          )
        )
      )
      SearchView(presenter: presenter)
    }
  }
}
