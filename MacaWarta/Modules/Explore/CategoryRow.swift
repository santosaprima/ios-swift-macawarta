//
//  CategoryRow.swift
//  MacaWarta
//
//  Created by Prima Santosa on 09/11/20.
//

import SwiftUI
import KingfisherSwiftUI

struct CategoryRow: View {
  let category: String

  init(category: String) {
    self.category = category
  }

  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 5.0, style: .continuous)
        .shadow(radius: 10.0)

      KFImage(
        URL(string: Selection.categories[category] ?? ""),
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

      LinearGradient(
        gradient: Gradient(
          colors: [Color.black.opacity(0.3), Color.black.opacity(0.5)]
        ),
        startPoint: .top,
        endPoint: .bottom
      )

      Text(category)
        .foregroundColor(.white)
        .font(.title)
    }
    .frame(height: 250)
    .cornerRadius(15.0)
    .shadow(radius: 5.0)
    .padding(.leading)
    .padding(.trailing)
    .padding(.top)
  }
}

struct CategoryRow_Previews: PreviewProvider {
  static var previews: some View {
    let category = "Technology"
    CategoryRow(category: category)
  }
}
