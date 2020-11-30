//
//  NewsEntity.swift
//  MacaWarta
//
//  Created by Prima Santosa on 10/11/20.
//

import Foundation
import RealmSwift

class NewsEntity: Object {
  @objc dynamic var id: String = ""
  @objc dynamic var country: String = ""
  @objc dynamic var category: String = ""
  @objc dynamic var totalResults: Int = 0
  let articles = List<ArticleEntity>()

  override class func primaryKey() -> String? {
    return "id"
  }
}

class ArticleEntity: Object {
  @objc dynamic var id: String = ""
  @objc dynamic var title: String = ""
  @objc dynamic var source: String = ""
  @objc dynamic var desc: String = ""
  @objc dynamic var author: String = ""
  @objc dynamic var url: String = ""
  @objc dynamic var image: String = ""
  @objc dynamic var date: String = ""
  @objc dynamic var isFavorite: Bool = false

  override class func primaryKey() -> String? {
    return "id"
  }
}
