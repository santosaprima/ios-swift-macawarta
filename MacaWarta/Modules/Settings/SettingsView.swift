//
//  SettingsView.swift
//  MacaWarta
//
//  Created by Prima Santosa on 08/11/20.
//

import SwiftUI

struct SettingsView: View {
  @AppStorage("country") var country = "United States"
  @AppStorage("articleStyle") var articleStyle = "Card"

  private let styles = Selection.articleStyles
  private let countries = Selection.countries.sorted { (first, second) -> Bool in
    return second.key > first.key
  }.map { return $0.key }

  var body: some View {
    NavigationView {
      Form {
        Section(header: Text("View Options")) {
          Picker("Default view", selection: $articleStyle) {
            ForEach(styles, id: \.self) { style in
              Text(style)
            }
          }
          Picker("Country", selection: $country) {
            ForEach(countries, id: \.self) { country in
              Text(country)
            }
          }
        }
        NavigationLink(
          destination: AboutView(),
          label: {
            Text("About")
          }
        )
      }
      .navigationBarTitle("Settings")
    }
  }
}

struct SettingsView_Previews: PreviewProvider {
  static var previews: some View {
    SettingsView()
  }
}
