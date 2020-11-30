//
//  ArticleWebView.swift
//  MacaWarta
//
//  Created by Prima Santosa on 09/11/20.
//

import SwiftUI

struct ArticleWebView: View {
  private let article: ArticleModel

  init(article: ArticleModel) {
    self.article = article
  }

  var body: some View {
    VStack {
      WebView(url: article.url)
    }
    .navigationBarTitle("Article Reader", displayMode: .inline)
  }
}

struct ArticleWebView_Previews: PreviewProvider {
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

    ArticleWebView(article: article)
  }
}
