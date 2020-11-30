//
//  FavoriteView.swift
//  MacaWarta
//
//  Created by Prima Santosa on 08/11/20.
//

import SwiftUI

struct FavoriteView: View {
  @StateObject var presenter: FavoritePresenter

  var body: some View {
    NavigationView {
      VStack {
        if presenter.isLoading {
          ProgressView()
        }

        if !presenter.errorMessage.isEmpty {
          Text("Error while loading data")
          Button(action: {
            presenter.getFavoriteArticles()
          }, label: {
            Text("Try Again")
          })
        }

        if presenter.favoriteArticles.isEmpty {
          if !presenter.isLoading && presenter.errorMessage.isEmpty {
            Image(systemName: "bookmark")
              .font(.system(size: 104))
              .padding(.bottom, 16)
              .foregroundColor(.gray)
            Text("No favorite yet")
              .font(.headline)
              .foregroundColor(.gray)
          }
        } else {
            ScrollView {
              LazyVStack {
                ForEach(presenter.favoriteArticles) { article in
                  NavigationLink(
                    destination: ArticleDetailView(
                      article: article,
                      presenter: ArticleDetailPresenter(
                        useCase: ArticleDetailInteractor(
                          repository: WartaRepository.shared
                        )
                      )
                    ), label: {
                      ArticlesRowClassicView(article: article)
                    }
                  ).buttonStyle(PlainButtonStyle())
                }
              }
            }
        }
      }
      .navigationBarTitle("Favorite")
      .onAppear {
        presenter.getFavoriteArticles()
      }
    }
  }

  struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
      let presenter = FavoritePresenter(
        useCase: FavoriteInteractor(
          repository: WartaRepository.shared
        )
      )
      FavoriteView(presenter: presenter)
    }
  }
}
