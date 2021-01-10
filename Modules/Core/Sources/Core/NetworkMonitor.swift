//
//  NetworkCheck.swift
//  MacaWarta
//
//  Created by Prima Santosa on 11/11/20.
//

import Foundation
import Network

public final class NetworkMonitor {
  private let monitor: NWPathMonitor
  private let queue: DispatchQueue
  private var isConnected = true

  private init() {
    self.monitor = NWPathMonitor()
    self.queue = DispatchQueue.global(qos: .background)
    self.monitor.start(queue: queue)
  }

  public static let shared = NetworkMonitor()

  public func start() {
    self.monitor.pathUpdateHandler = { path in
      if path.status == .satisfied {
        self.isConnected = true
      } else {
        self.isConnected = false
      }
    }
  }

  public func stop() {
    self.monitor.cancel()
  }

  public func status() -> Bool {
    return isConnected
  }
}
