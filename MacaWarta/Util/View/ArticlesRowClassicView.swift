//
//  ArticlesRowClassicView.swift
//  MacaWarta
//
//  Created by Prima Santosa on 08/11/20.
//

import SwiftUI
import KingfisherSwiftUI
import Headlines
import Core

struct ArticlesRowClassicView: View {
  private let article: ArticleModel

  init(article: ArticleModel) {
    self.article = article
  }

  var body: some View {
    HStack(alignment: .top) {
      VStack(alignment: .leading) {
        Text(article.title)
          .bold()
          .lineLimit(2)

        Text(article.source)
          .foregroundColor(.gray)
          .font(.system(size: 14))

        Text(article.date)
          .foregroundColor(.gray)
          .font(.system(size: 12))
      }

      Spacer()

      KFImage(
        URL(string: article.image),
        options: [
          .transition(.fade(1)),
          .scaleFactor(UIScreen.main.scale),
          .cacheOriginalImage
        ]
      )
      .cancelOnDisappear(true)
      .resizable()
      .frame(width: 126, height: 86)
      .cornerRadius(5.0)

    }
    .padding(.leading)
    .padding(.trailing)
    .padding(.top)
  }
}

 struct HeadlinesRowView_Previews: PreviewProvider {
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

    ArticlesRowClassicView(article: article)
  }
 }
