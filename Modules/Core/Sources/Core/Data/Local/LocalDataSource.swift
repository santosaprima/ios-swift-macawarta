//
//  LocalDataSource.swift
//  
//
//  Created by Prima Santosa on 30/11/20.
//

import Foundation
import Combine

public protocol LocalDataSource {
  associatedtype Request
  associatedtype Response

  func list(request: Request?) -> AnyPublisher<Response, Error>
  func add(entity: Response, page: Int) -> AnyPublisher<Bool, Error>
  func get(request: Request?) -> AnyPublisher<[Response], Error>
  func insert(entity: Response)
  func remove(title: String)
}
