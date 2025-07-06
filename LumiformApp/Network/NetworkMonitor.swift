//
//  NetworkMonitor.swift
//  LumiformApp
//
//  Created by Emre Bingor on 7/6/25.
//

import Network

class NetworkMonitor {
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")
    var isConnected: Bool = false
    
    init() {
        startMonitoring()
    }
    
    func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status == .satisfied
            print(path.status == .satisfied ? "Network connected" : "Network disconnected")
        }
        monitor.start(queue: queue)
    }

    func stopMonitoring() {
        monitor.cancel()
    }
}
