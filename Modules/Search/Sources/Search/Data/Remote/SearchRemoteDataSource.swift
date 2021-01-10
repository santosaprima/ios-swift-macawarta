//
//  SearchRemoteDataSource.swift
//  
//
//  Created by Prima Santosa on 10/01/21.
//

import Foundation
import Core
import Alamofire
import Combine

public struct SearchRemoteDataSource: RemoteDataSource {
  public typealias Request = (keyword: String, page: Int)
  public typealias Response = (response: [ArticleResponse], total: Int)

  public init() {}

  public func execute(
    request: (keyword: String, page: Int)?
  ) -> AnyPublisher<(response: [ArticleResponse], total: Int), Error> {
    guard let request = request else { fatalError("Request cannot be empty") }

    return Future<(response: [ArticleResponse], total: Int), Error> { completion in
      let headers: HTTPHeaders = [
        .authorization(bearerToken: URL.apiKey)
      ]
      AF.request(
        URL.news(withKeyword: request.keyword, page: request.page), headers: headers
      )
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
