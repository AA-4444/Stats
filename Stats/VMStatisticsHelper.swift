//
//  VMStatisticsHelper.swift
//  Stats
//
//  Created by Алексей Зарицький on 11/29/24.
//

import Darwin
import Foundation

func getVMStatistics64() -> vm_statistics64? {
    let hostPort: host_t = mach_host_self()
    var hostSize: mach_msg_type_number_t = mach_msg_type_number_t(
        UInt32(MemoryLayout<vm_statistics64_data_t>.size / MemoryLayout<integer_t>.size)
    )
    var returnData = vm_statistics64()
    let success = withUnsafeMutablePointer(to: &returnData) { (ptr) -> Bool in
        return ptr.withMemoryRebound(to: integer_t.self, capacity: Int(hostSize)) { reboundPtr in
            host_statistics64(hostPort, HOST_VM_INFO64, reboundPtr, &hostSize) == KERN_SUCCESS
        }
    }
    return success ? returnData : nil
}

extension vm_statistics64 {
    var pageSizeInBytes: UInt64 {
        return UInt64(getPageSize())
    }

    var freeBytes: UInt64 {
        return UInt64(free_count) * pageSizeInBytes
    }

    var activeBytes: UInt64 {
        return UInt64(active_count) * pageSizeInBytes
    }

    var inactiveBytes: UInt64 {
        return UInt64(inactive_count) * pageSizeInBytes
    }

    var wireBytes: UInt64 {
        return UInt64(wire_count) * pageSizeInBytes
    }
}

func getPageSize() -> UInt {
    let hostPort: host_t = mach_host_self()
    var pageSize: vm_size_t = 0
    host_page_size(hostPort, &pageSize)
    return UInt(pageSize)
}
