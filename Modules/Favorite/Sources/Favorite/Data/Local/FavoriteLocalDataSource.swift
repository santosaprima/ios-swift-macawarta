//
//  FavoriteLocalDataSource.swift
//
//
//  Created by Prima Santosa on 10/01/21.
//

import Foundation
import Core
import RealmSwift
import Combine

public class FavoriteLocalDataSource: LocalDataSource {
  public typealias Request = Any
  public typealias Response = ArticleEntity

  private let realm: Realm

  public init(realm: Realm) {
    self.realm = realm
  }

  public func insert(entity: ArticleEntity) {
    try? realm.write {
      self.realm.add(entity, update: .modified)
    }
  }

  public func remove(title: String) {
    let articleToDeleteResults: Results<ArticleEntity> = {
      realm.objects(ArticleEntity.self)
        .filter("title = \"\(title)\"")
    }()
    try? realm.write {
      realm.delete(articleToDeleteResults)
    }
  }

  public func get(request: Any?) -> AnyPublisher<[ArticleEntity], Error> {
    return Future<[ArticleEntity], Error> { completion in
      let favoriteArticleResults: Results<ArticleEntity> = {
        self.realm.objects(ArticleEntity.self)
          .filter("isFavorite = true")
      }()
      completion(.success(Array(favoriteArticleResults)))
    }.eraseToAnyPublisher()
  }

  public func list(request: Any?) -> AnyPublisher<ArticleEntity, Error> {
    fatalError()
  }

  public func add(entity: ArticleEntity, page: Int) -> AnyPublisher<Bool, Error> {
    fatalError()
  }
}
