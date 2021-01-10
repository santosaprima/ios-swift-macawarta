//
//  ExploreView.swift
//  MacaWarta
//
//  Created by Prima Santosa on 08/11/20.
//

import SwiftUI
import Core
import Explore

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
                    useCase: Interactor(
                      repository: ExploreRepository(
                        localDataSource: ExploreLocalDataSource(realm: Init.realm),
                        remoteDataSource: ExploreRemoteDataSource(),
                        mapper: ExploreTransformer()
                      )
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
