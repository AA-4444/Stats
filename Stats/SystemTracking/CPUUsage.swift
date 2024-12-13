//
//  CPUUsage.swift
//  Stats
//
//  Created by Алексей Зарицький on 11/30/24.
//

import Foundation
import Combine 

class CPUUsage {
    static func getCPUUsage() -> Double {
        var cpuInfo: processor_info_array_t?
        var numCPUInfo: mach_msg_type_number_t = 0
        var numCPUsU: natural_t = 0
        let CPUUsageLock = NSLock()
        
        let hostPort: host_t = mach_host_self()
      //  let hostSize = MemoryLayout<natural_t>.size / MemoryLayout<integer_t>.size
        
        let result = host_processor_info(
            hostPort,
            PROCESSOR_CPU_LOAD_INFO,
            &numCPUsU,
            &cpuInfo,
            &numCPUInfo
        )
        
        guard result == KERN_SUCCESS, let cpuInfo = cpuInfo else {
            return -1.0 // Failed to fetch CPU usage
        }
        
        CPUUsageLock.lock()
        
        var totalUsage: Double = 0.0
        let numCPUs = Int(numCPUsU)
        var cpuLoadInfo = [Double](repeating: 0.0, count: numCPUs)
        
        for i in 0..<numCPUs {
            let inUse = Double(cpuInfo[Int(CPU_STATE_MAX * Int32(i) + CPU_STATE_USER)])
            + Double(cpuInfo[Int(CPU_STATE_MAX * Int32(i) + CPU_STATE_SYSTEM)])
            + Double(cpuInfo[Int(CPU_STATE_MAX * Int32(i) + CPU_STATE_NICE)])
            let total = inUse + Double(cpuInfo[Int(CPU_STATE_MAX * Int32(i) + CPU_STATE_IDLE)])
            cpuLoadInfo[i] = inUse / total
            totalUsage += cpuLoadInfo[i]
        }
        
        CPUUsageLock.unlock()
        vm_deallocate(mach_task_self_, vm_address_t(bitPattern: cpuInfo), vm_size_t(numCPUInfo))
        
        return totalUsage / Double(numCPUs) * 100.0
    }
}



class CPUStats: ObservableObject {
    @Published var usage: Double = 0.0
    private var timer: Timer?

    init() {
        startMonitoring()
    }

    deinit {
        stopMonitoring()
    }

    private func startMonitoring() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.updateCPUUsage()
        }
    }

    private func stopMonitoring() {
        timer?.invalidate()
    }

    private func updateCPUUsage() {
        usage = CPUUsage.getCPUUsage()
    }
}

