//
//  Mapper.swift
//  
//
//  Created by Prima Santosa on 09/12/20.
//

import Foundation

public protocol Mapper {
  associatedtype Request
  associatedtype Response
  associatedtype Entity
  associatedtype Model

  func transformResponseToEntity(request: Request, response: Response) -> Entity
  func transformEntityToModel(entity: Entity) -> Model
  func transformResponseToModel(response: Response) -> Model
  func transformModelToEntity(model: Model) -> Entity
}
