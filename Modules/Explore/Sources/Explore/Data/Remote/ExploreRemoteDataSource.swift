//
//  ExploreRemoteDataSource.swift
//  
//
//  Created by Prima Santosa on 10/01/21.
//

import Foundation
import Core
import Alamofire
import Combine

public struct ExploreRemoteDataSource: RemoteDataSource {
  public typealias Request = (category: String, country: String, page: Int)
  public typealias Response = NewsResponse

  public init() {}

  public func execute(request: (category: String, country: String, page: Int)?) -> AnyPublisher<NewsResponse, Error> {
    guard let request = request else { fatalError("Request cannot be empty") }

    return Future<NewsResponse, Error> { completion in
      let headers: HTTPHeaders = [
        .authorization(bearerToken: URL.apiKey)
      ]
      AF.request(
        URL.news(from: request.category, in: request.country, page: request.page), headers: headers
      )
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
}
