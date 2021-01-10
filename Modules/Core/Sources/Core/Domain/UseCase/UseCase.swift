//
//  UseCase.swift
//  
//
//  Created by Prima Santosa on 05/12/20.
//

import Foundation
import Combine

public protocol UseCase {
  associatedtype Request
  associatedtype Response

  func execute(request: Request?) -> AnyPublisher<Response, Error>
  func localExecute(request: Request?)
}
