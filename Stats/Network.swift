//
//  Network.swift
//  Stats
//
//  Created by Алексей Зарицький on 11/30/24.
//

import Network
import Foundation

class WiFiMonitor: ObservableObject {
    @Published var uploadSpeed: String = "Calculating..."
    @Published var downloadSpeed: String = "Calculating..."
    @Published var isWiFiActive: Bool = false

    private var monitor: NWPathMonitor?
    private let queue = DispatchQueue.global(qos: .background)

    init() {
        monitor = NWPathMonitor()
        monitor?.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                if path.usesInterfaceType(.wifi) {
                    self?.isWiFiActive = true
                    self?.calculateNetworkSpeeds()
                } else {
                    self?.isWiFiActive = false
                    self?.uploadSpeed = "0 KB/sec"
                    self?.downloadSpeed = "0 KB/sec"
                }
            }
        }
        monitor?.start(queue: queue)
    }

    deinit {
        monitor?.cancel()
    }

    private func calculateNetworkSpeeds() {
       
        DispatchQueue.global().async {
            
            while self.isWiFiActive {
                DispatchQueue.main.async {
                    self.uploadSpeed = "\(Int.random(in: 100...500)) KB/sec"
                    self.downloadSpeed = "\(Int.random(in: 500...1000)) KB/sec"
                }
                sleep(1) // 1 sec update
            }
        }
    }
}
