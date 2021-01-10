//
//  String+Ext.swift
//  
//
//  Created by Prima Santosa on 10/01/21.
//

import Foundation

extension String {
  public func formatDate() -> String {
    let inputFormatter = DateFormatter()
    inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
    let date = inputFormatter.date(from: self)

    let outputFormatter = DateFormatter()
    outputFormatter.dateStyle = .medium
    outputFormatter.timeStyle = .short
    let formattedDate = outputFormatter.string(from: date ?? Date())

    return formattedDate
  }
}
