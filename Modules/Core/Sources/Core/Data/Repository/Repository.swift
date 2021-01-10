//
//  Repository.swift
//  
//
//  Created by Prima Santosa on 30/11/20.
//

import Foundation
import Combine

public protocol Repository {
  associatedtype Request
  associatedtype Response

  func execute(request: Request?) -> AnyPublisher<Response, Error>
  func localExecute(request: Request?)
}
