//
//  NetworkCheck.swift
//  MacaWarta
//
//  Created by Prima Santosa on 11/11/20.
//

import Foundation
import Network

final class NetworkMonitor {
  private let monitor: NWPathMonitor
  private let queue: DispatchQueue
  private var isConnected = true

  private init() {
    self.monitor = NWPathMonitor()
    self.queue = DispatchQueue.global(qos: .background)
    self.monitor.start(queue: queue)
  }

  static let shared = NetworkMonitor()

  func start() {
    self.monitor.pathUpdateHandler = { path in
      if path.status == .satisfied {
        self.isConnected = true
      } else {
        self.isConnected = false
      }
    }
  }

  func stop() {
    self.monitor.cancel()
  }

  func status() -> Bool {
    return isConnected
  }
}
