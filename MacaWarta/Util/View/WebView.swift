//
//  WebView.swift
//  MacaWarta
//
//  Created by Prima Santosa on 09/11/20.
//

import Foundation
import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
  var url: String

  func makeUIView(context: Context) -> some UIView {
    guard let url = URL(string: self.url) else {
      return WKWebView()
    }

    let request = URLRequest(url: url)
    let wkWebView = WKWebView()
    wkWebView.load(request)
    return wkWebView
  }

  func updateUIView(_ uiView: UIViewType, context: Context) {}
}
