//
//  NewsEntity.swift
//  
//
//  Created by Prima Santosa on 10/01/21.
//

import Foundation
import RealmSwift

public class NewsEntity: Object {
  @objc public dynamic var id: String = ""
  @objc public dynamic var country: String = ""
  @objc public dynamic var category: String = ""
  @objc public dynamic var totalResults: Int = 0
  public let articles = List<ArticleEntity>()

  public override class func primaryKey() -> String? {
    return "id"
  }
}

public class ArticleEntity: Object {
  @objc public dynamic var id: String = ""
  @objc public dynamic var title: String = ""
  @objc public dynamic var source: String = ""
  @objc public dynamic var desc: String = ""
  @objc public dynamic var author: String = ""
  @objc public dynamic var url: String = ""
  @objc public dynamic var image: String = ""
  @objc public dynamic var date: String = ""
  @objc public dynamic var isFavorite: Bool = false

  public override class func primaryKey() -> String? {
    return "id"
  }
}
