//
//  ArticlesRowCardView.swift
//  MacaWarta
//
//  Created by Prima Santosa on 09/11/20.
//

import SwiftUI
import KingfisherSwiftUI
import Core

struct ArticlesRowCardView: View {
  private let article: ArticleModel

  init(article: ArticleModel) {
    self.article = article
  }

  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 10.0, style: .continuous)
        .fill(Color(.systemBackground))
        .shadow(radius: 5.0)

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
        .cornerRadius(10.0)
        .padding(.bottom, 5)

        VStack(alignment: .leading) {
          Text(article.title)
            .bold()
            .lineLimit(2)
            .font(.system(size: 18))
            .lineSpacing(2.0)

          Text(article.description)
            .lineLimit(2)
            .lineSpacing(2.0)
            .font(.system(size: 14))

          Spacer()

          Text("\(article.source) - \(article.date)")
            .font(.system(size: 12))
        }
        .padding(.leading)
        .padding(.trailing)
        .padding(.bottom)
      }
    }
    .frame(height: 380)
    .padding(.top)
    .padding(.leading)
    .padding(.trailing)
  }
}

 struct HeadlinesRowCardView_Previews: PreviewProvider {
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

    ArticlesRowCardView(article: article)
  }
 }
