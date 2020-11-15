//
//  Date.swift
//  MacaWarta
//
//  Created by Prima Santosa on 15/11/20.
//

import Foundation

extension String {
  func formatDate(from date: String) -> String {
    let inputFormatter = DateFormatter()
    inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
    let date = inputFormatter.date(from: date)
    
    let outputFormatter = DateFormatter()
    outputFormatter.dateStyle = .medium
    outputFormatter.timeStyle = .short
    let formattedDate = outputFormatter.string(from: date ?? Date())
    
    return formattedDate
  }
}
