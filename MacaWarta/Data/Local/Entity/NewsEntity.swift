//
//  NewsEntity.swift
//  MacaWarta
//
//  Created by Prima Santosa on 10/11/20.
//

import Foundation
import RealmSwift

class NewsEntity: Object {
  @objc dynamic var totalResults: Int = 0
  @objc dynamic var country: String = ""
  @objc dynamic var category: String = ""
  let articles = List<ArticleEntity>()
}

class ArticleEntity: Object {
  @objc dynamic var id = UUID()
  @objc dynamic var title: String = ""
  @objc dynamic var source: String = ""
  @objc dynamic var desc: String = ""
  @objc dynamic var author: String = ""
  @objc dynamic var url: String = ""
  @objc dynamic var image: String = ""
  @objc dynamic var date: String = ""
  
  override class func primaryKey() -> String? {
    return "id"
  }
}
