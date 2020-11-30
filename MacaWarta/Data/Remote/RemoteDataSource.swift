//
//  RemoteDataSource.swift
//  MacaWarta
//
//  Created by Prima Santosa on 08/11/20.
//

import Foundation
import Combine
import Alamofire

protocol RemoteDataSourceProtocol: class {
  func getHeadlines(
    in country: String,
    page: Int
  ) -> AnyPublisher<NewsResponse, Error>

  func getNews(
    from category: String,
    in country: String,
    page: Int
  ) -> AnyPublisher<NewsResponse, Error>

  func searchNews(
    withKeyword keyword: String,
    page: Int
  ) -> AnyPublisher<(response: [ArticleResponse], total: Int), Error>
}

final class RemoteDataSource: RemoteDataSourceProtocol {
  private init() {}
  static let shared = RemoteDataSource()

  func getHeadlines(
    in country: String,
    page: Int
  ) -> AnyPublisher<NewsResponse, Error> {
    return Future<NewsResponse, Error> { completion in
      let headers: HTTPHeaders = [
        .authorization(bearerToken: URL.bearer)
      ]
      AF.request(URL.headlines(in: country, page: page), headers: headers)
        .validate()
        .responseDecodable(of: NewsResponse.self) { response in
          switch response.result {
          case .success(let value):
            completion(.success(value))
          case .failure(let error):
            completion(.failure(error))
          }
        }
    }.eraseToAnyPublisher()
  }

  func getNews(
    from category: String,
    in country: String,
    page: Int
  ) -> AnyPublisher<NewsResponse, Error> {
    return Future<NewsResponse, Error> { completion in
      let headers: HTTPHeaders = [
        .authorization(bearerToken: URL.bearer)
      ]
      AF.request(URL.news(from: category, in: country, page: page), headers: headers)
        .validate()
        .responseDecodable(of: NewsResponse.self) { response in
          switch response.result {
          case .success(let value):
            completion(.success(value))
          case .failure(let error):
            completion(.failure(error))
          }
        }
    }.eraseToAnyPublisher()
  }

  func searchNews(
    withKeyword keyword: String,
    page: Int
  ) -> AnyPublisher<(response: [ArticleResponse], total: Int), Error> {
    return Future<(response: [ArticleResponse], total: Int), Error> { completion in
      let headers: HTTPHeaders = [
        .authorization(bearerToken: URL.bearer)
      ]
      AF.request(URL.news(withKeyword: keyword, page: page), headers: headers)
        .validate()
        .responseDecodable(of: NewsResponse.self) { response in
          switch response.result {
          case .success(let value):
            let results = (response: value.articles, total: value.totalResults)
            completion(.success(results))
          case .failure(let error):
            completion(.failure(error))
          }
        }
    }.eraseToAnyPublisher()
  }
}
