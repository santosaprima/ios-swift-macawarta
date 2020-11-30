//
//  CategoryDetailView.swift
//  MacaWarta
//
//  Created by Prima Santosa on 09/11/20.
//

import SwiftUI

struct CategoryDetailView: View {
  @StateObject var presenter: CategoryDetailPresenter
  @AppStorage("country") var country = "United States"
  @AppStorage("articleStyle") var articleStyle = "Card"

  private let category: String

  init(category: String, presenter: CategoryDetailPresenter) {
    self.category = category
    _presenter = StateObject(
      wrappedValue: presenter
    )
  }

  var body: some View {
    VStack {
      if presenter.isLoading {
        ProgressView()
      }

      if !presenter.errorMessage.isEmpty {
        Text("Error while loading data")
        Button(action: {
          let countryID = Selection.countries[country] ?? "us"
          presenter.getNews(from: category, in: countryID)
        }, label: {
          Text("Try Again")
        })
      }

      if presenter.articles.isEmpty {
        if !presenter.isLoading && presenter.errorMessage.isEmpty {
          Image(systemName: "book")
            .font(.system(size: 104))
            .padding(.bottom, 16)
            .foregroundColor(.gray)
          Text("No article")
            .font(.headline)
            .foregroundColor(.gray)
        }
      } else {
        ScrollView {
          LazyVStack {
            ForEach(presenter.articles) { article in
              NavigationLink(
                destination: ArticleDetailView(
                  article: article,
                  presenter: ArticleDetailPresenter(
                    useCase: ArticleDetailInteractor(
                      repository: WartaRepository.shared
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
                if self.presenter.articles.last == article
                    && self.presenter.canLoadNext {
                  let countryID = Selection.countries[country] ?? "us"
                  presenter.getNews(from: category, in: countryID)
                }
              }
            }
          }
        }
      }
    }
    .navigationBarTitle(category, displayMode: .inline)
    .onAppear {
      if presenter.articles.isEmpty {
        let countryID = Selection.countries[country] ?? "us"
        presenter.getNews(from: category, in: countryID)
      }
    }
  }
}

struct CategoryDetailView_Previews: PreviewProvider {
  static var previews: some View {
    let category = "Technology"
    let presenter = CategoryDetailPresenter(
      useCase: CategoryDetailInteractor(
        repository: WartaRepository.shared
      )
    )
    CategoryDetailView(category: category, presenter: presenter)
  }
}
