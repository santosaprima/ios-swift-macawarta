//
//  AboutView.swift
//  MacaWarta
//
//  Created by Prima Santosa on 08/11/20.
//

import SwiftUI

struct AboutView: View {
  var body: some View {
    VStack {
      Spacer()

      Image("me")
        .resizable()
        .clipShape(RoundedRectangle(cornerRadius: 1000.0))
        .frame(width: 200, height: 200)

      Text("Mauliawan Prima Santosa")
        .font(.title2)
        .bold()

      Text("trust3d@primasantosa.com")

      Spacer()
    }
    .navigationBarTitle("About", displayMode: .inline)
  }
}

struct AboutView_Previews: PreviewProvider {
  static var previews: some View {
    AboutView()
  }
}
