//
//  DiskStats.swift
//  Stats
//
//  Created by Алексей Зарицький on 11/29/24.
//

import Foundation

class DiskStats: ObservableObject {
    @Published var totalSpace: UInt64 = 0
    @Published var usedSpace: UInt64 = 0
    @Published var freeSpace: UInt64 = 0

    init() {
        updateDiskStats()
    }

    func updateDiskStats() {
        if let attributes = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory()) {
            if let totalSize = attributes[.systemSize] as? NSNumber,
               let freeSize = attributes[.systemFreeSize] as? NSNumber {
                self.totalSpace = totalSize.uint64Value / (1024 * 1024 * 1024) // -> GB
                self.freeSpace = freeSize.uint64Value / (1024 * 1024 * 1024)   // -> GB
                self.usedSpace = self.totalSpace - self.freeSpace
            }
        }
    }
}
