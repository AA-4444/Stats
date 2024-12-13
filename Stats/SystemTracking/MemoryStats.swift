//
//  MemoryStats.swift
//  Stats
//
//  Created by Алексей Зарицький on 11/29/24.
//

import Foundation


func getCompressedMemory() -> UInt64 {
    var taskInfo = task_basic_info()
    var count = mach_msg_type_number_t(MemoryLayout.size(ofValue: taskInfo) / MemoryLayout.size(ofValue: integer_t()))
    let result = withUnsafeMutablePointer(to: &taskInfo) {
        $0.withMemoryRebound(to: integer_t.self, capacity: Int(count)) {
            task_info(mach_task_self_, task_flavor_t(TASK_BASIC_INFO), $0, &count)
        }
    }
    return result == KERN_SUCCESS ? UInt64(taskInfo.virtual_size) : 0
}




class MemoryStats: ObservableObject {
    @Published var free: UInt64 = 0
    @Published var active: UInt64 = 0
    @Published var inactive: UInt64 = 0
    @Published var wired: UInt64 = 0
    @Published var total: UInt64 = 0

    var freePercentage: Double {
        total > 0 ? Double(free) / Double(total) : 0
    }

    private var timer: Timer?

    init() {
        updateStats()
        startUpdating()
    }

    deinit {
        stopUpdating()
    }

    func updateStats() {
        if let stats = getVMStatistics64() {
        //    let pageSize = stats.pageSizeInBytes
            self.free = stats.freeBytes / (1024 * 1024) // Convert to MB
            self.active = stats.activeBytes / (1024 * 1024)
            self.inactive = stats.inactiveBytes / (1024 * 1024)
            self.wired = stats.wireBytes / (1024 * 1024)
            self.total = (stats.freeBytes + stats.activeBytes + stats.inactiveBytes + stats.wireBytes) / (1024 * 1024)
        }
    }

    func startUpdating() {
        timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { [weak self] _ in
            self?.updateStats()
        }
    }

    func stopUpdating() {
        timer?.invalidate()
        timer = nil
    }
}
