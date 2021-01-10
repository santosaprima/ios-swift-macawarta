//
//  HeadlinesLocalDataSource.swift
//
//
//  Created by Prima Santosa on 09/12/20.
//

import Foundation
import Core
import RealmSwift
import Combine

public class HeadlinesLocalDataSource: LocalDataSource {
  public typealias Request = (country: String, category: String)
  public typealias Response = NewsEntity

  private let realm: Realm

  public init(realm: Realm) {
    self.realm = realm
  }

  public func list(
    request: (country: String, category: String)?
  ) -> AnyPublisher<NewsEntity, Error> {
    guard let request = request else { fatalError("Request cannot be empty") }

    return Future<NewsEntity, Error> { completion in
      let currentEntityResults: Results<NewsEntity> = {
        self.realm.objects(NewsEntity.self)
          .filter("country = '\(request.country)' AND category = '\(request.category)'")
      }()

      let newsEntity = NewsEntity()
      currentEntityResults.forEach { currentEntity in
        currentEntity.articles.forEach { article in
          newsEntity.articles.append(article)
        }
        newsEntity.category = currentEntity.category
        newsEntity.country = currentEntity.country
        newsEntity.totalResults = currentEntity.totalResults
      }

      completion(.success(newsEntity))
    }.eraseToAnyPublisher()
  }

  public func add(
    entity: NewsEntity,
    page: Int
  ) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      let currentEntityResults: Results<NewsEntity> = {
        self.realm.objects(NewsEntity.self)
          .filter("id = '\(entity.id)'")
      }()

      let favoriteArticleResults: Results<ArticleEntity> = {
        self.realm.objects(ArticleEntity.self)
          .filter("isFavorite = true")
      }()

      let favoriteArticles = Array(favoriteArticleResults)

      try? self.realm.write {
        if page == 1 {
          self.realm.delete(currentEntityResults)
        }

        let newsEntity = NewsEntity()
        currentEntityResults.forEach { currentEntity in
          currentEntity.articles.forEach { currentArticle in
            newsEntity.articles.append(currentArticle)
          }
          newsEntity.id = currentEntity.id
          newsEntity.category = currentEntity.category
          newsEntity.country = currentEntity.country
          newsEntity.totalResults = currentEntity.totalResults
        }

        if entity.id == newsEntity.id {
          newsEntity.articles.append(objectsIn: entity.articles)
          self.realm.delete(currentEntityResults)
          self.realm.add(newsEntity, update: .modified)
        } else {
          self.realm.add(entity, update: .modified)
        }

        favoriteArticles.forEach { article in
          article.isFavorite = true
          self.realm.add(article, update: .modified)
        }

        completion(.success(true))
      }
    }.eraseToAnyPublisher()
  }

  public func insert(entity: NewsEntity) {
    fatalError()
  }

  public func remove(title: String) {
    fatalError()
  }

  public func get(request: (country: String, category: String)?) -> AnyPublisher<[NewsEntity], Error> {
    fatalError()
  }
}
