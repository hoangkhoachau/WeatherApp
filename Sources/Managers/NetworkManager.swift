//
//  NetworkManager.swift
//  Weather
//
//  Created by Chau Hoang Khoa on 13/07/2024.
//

import Foundation
import Network

final class NetworkManager: ObservableObject {
    private let networkMonitor = NWPathMonitor()
    private let workerQueue = DispatchQueue(label: "Monitor")
    
    var isConnected = true
    
    init() {
        networkMonitor.pathUpdateHandler = { path in
            Task {
                await MainActor.run { [weak self] in
                    self?.objectWillChange.send()
                    self?.isConnected = path.status == .satisfied
                }
            }
        }
        
        networkMonitor.start(queue: workerQueue)
    }
}
