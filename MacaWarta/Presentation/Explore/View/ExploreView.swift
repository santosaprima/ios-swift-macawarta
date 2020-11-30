//
//  ExploreView.swift
//  MacaWarta
//
//  Created by Prima Santosa on 08/11/20.
//

import SwiftUI

struct ExploreView: View {
  private let categories = Array(Selection.categories.keys.sorted())

  var body: some View {
    NavigationView {
      VStack {
        ScrollView {
          VStack {
            ForEach(categories, id: \.self) { category in
              NavigationLink(
                destination: CategoryDetailView(
                  category: category,
                  presenter: CategoryDetailPresenter(
                    useCase: CategoryDetailInteractor(
                      repository: WartaRepository.shared
                    )
                  )
                ),
                label: {
                  CategoryRow(category: category)
                }
              ).buttonStyle(PlainButtonStyle())
            }
          }
        }
      }
      .navigationBarTitle("Explore")
    }
  }
}

struct ExploreView_Previews: PreviewProvider {
  static var previews: some View {
    ExploreView()
  }
}
