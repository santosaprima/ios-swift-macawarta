//
//  RemoteDataSource.swift
//  
//
//  Created by Prima Santosa on 30/11/20.
//

import Foundation
import Combine

public protocol RemoteDataSource {
  associatedtype Request
  associatedtype Response

  func execute(request: Request?) -> AnyPublisher<Response, Error>
}
