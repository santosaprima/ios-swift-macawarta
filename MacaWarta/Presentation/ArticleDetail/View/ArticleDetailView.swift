//
//  ArticleDetailView.swift
//  MacaWarta
//
//  Created by Prima Santosa on 09/11/20.
//

import SwiftUI
import KingfisherSwiftUI

struct ArticleDetailView: View {
  @StateObject var presenter: ArticleDetailPresenter
  private let article: ArticleModel

  init(article: ArticleModel, presenter: ArticleDetailPresenter) {
    self.article = article
    _presenter = StateObject(
      wrappedValue: presenter
    )
  }

  var body: some View {
    VStack {
      KFImage(
        URL(string: article.image),
        options: [
          .transition(.fade(1)),
          .scaleFactor(UIScreen.main.scale),
          .cacheOriginalImage
        ]
      )
      .placeholder {
        Image(systemName: "arrow.2.circlepath.circle")
          .font(.largeTitle)
          .opacity(0.3)
      }
      .cancelOnDisappear(true)
      .resizable()
      .frame(height: 240)

      VStack(alignment: .leading) {
        Text(article.title)
          .font(.title)
          .bold()
          .padding(.bottom, 5)

        Text("\(article.author) - \(article.date)")
          .font(.caption)
          .padding(.bottom, 5)

        Text(article.description)
          .padding(.bottom, 5)

        HStack {
          Spacer()

          NavigationLink(
            destination: ArticleWebView(article: article),
            label: {
              Text("Read more")
            }
          )
        }
      }
      .padding()

      Spacer()
    }
    .navigationBarTitle("Article Detail", displayMode: .inline)
    .navigationBarItems(
      trailing:
        Button(action: {
          if presenter.favoriteArticles.contains(article) {
            presenter.removeFavoriteArticle(withTitle: article.title)
            presenter.getFavoriteArticles()
          } else {
            presenter.addFavoriteArticle(article: article)
            presenter.getFavoriteArticles()
          }
        }, label: {
          if presenter.favoriteArticles.contains(article) {
            Image(systemName: "bookmark.fill")
          } else {
            Image(systemName: "bookmark")
          }
        })
    )
    .onAppear {
      presenter.getFavoriteArticles()
    }
  }
}

struct DetailView_Previews: PreviewProvider {
  static var previews: some View {
    let article = ArticleModel(
      id: "title",
      source: "Kontan.co.id",
      title: "Bertahan di atas Rp 1 juta per gram",
      description: "Minggu (8/11), harga emas Antam bertahan di Rp 1.004.000 ",
      author: "Anna Suci Perwitasari",
      url: "https://personalfinance.kontan.co.id",
      image: "https://foto.kontan.co.id/5S8m-moJdxMkYgcGA-byH4YwCDU=/smart/2020/08/31/1881540474p.jpg",
      date: "2020-11-08T08:00:12Z"
    )
    let presenter = ArticleDetailPresenter(
      useCase: ArticleDetailInteractor(
        repository: WartaRepository.shared
      )
    )

    ArticleDetailView(article: article, presenter: presenter)
  }
}
