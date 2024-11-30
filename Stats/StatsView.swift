//
//  MemoryUsageView.swift
//  Stats
//
//  Created by Алексей Зарицький on 11/29/24.
//
import SwiftUI

//for canvas
//class MockMemoryStats: MemoryStats {
//    override init() {
//        super.init()
//        self.free = 2048   // mock free memory (in MB)
//        self.active = 4096 // mock active memory (in MB)
//        self.inactive = 1024 // mock inactive memory (in MB)
//        self.wired = 512   // mock wired memory (in MB)
//        self.total = 8192  // mock total memory (in MB)
//    }
//
//    override var freePercentage: Double {
//        return Double(free) / Double(total)
//    }
//}
//
//class MockDiskStats: DiskStats {
//    override init() {
//        super.init()
//        self.totalSpace = 500  // mock total space in GB
//        self.freeSpace = 200   // mock free space in GB
//        self.usedSpace = 300   // mock used space in GB
//    }
//}

struct StatsView: View {
    @ObservedObject var memoryStats: MemoryStats
    @ObservedObject var diskStats = DiskStats()
    @StateObject private var wifiMonitor = WiFiMonitor()
    @ObservedObject var cpuStats = CPUStats()
   
    var body: some View {
        VStack(spacing: 0) {
            
            HStack {
                //MARK: Wi-Fi
                VStack(alignment: .center, spacing: 15) {
                    Text("WI-FI")
                        .font(.headline)
                        .padding(.bottom, 5)
                    
                    ZStack {
                        Circle()
                            .stroke(lineWidth: 5)
                            .opacity(0.3)
                            .foregroundColor(.blue)
                        
                        Circle()
                            .trim(from: 0.0, to: wifiMonitor.isWiFiActive ? 1.0 : 0.0)
                            .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .round))
                            .foregroundColor(.blue)
                            .rotationEffect(Angle(degrees: -90))
                            .animation(.easeInOut, value: wifiMonitor.isWiFiActive)
                        
                        VStack {
                            Image(systemName: "wifi")
                                .symbolRenderingMode(.hierarchical)
                                .font(.system(size: 15))
                                .foregroundColor(wifiMonitor.isWiFiActive ? .blue : .gray)
                            
                            Text(wifiMonitor.isWiFiActive ? "Active" : "Inactive")
                                .font(.caption)
                                .bold()
                                .foregroundColor(.blue)
                        }
                    }
                    .frame(width: 65, height: 65)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Image(systemName: "arrow.up")
                                .foregroundColor(.blue).bold()
                            Text(wifiMonitor.uploadSpeed)
                                .bold()
                                .font(.system(size: 12))
                        }
                        
                        HStack {
                            Image(systemName: "arrow.down")
                                .foregroundColor(.blue).bold()
                            Text(wifiMonitor.downloadSpeed)
                                .bold()
                                .font(.system(size: 12))
                        }
                    }
                }
                .padding()
                .frame(width: 130)
                
                
                //MARK: Disk space
                VStack(alignment: .center, spacing: 15) {
                    Text("Disk")
                        .font(.headline)
                        .padding(5)
                    
                    ZStack {
                        
                        
                        // Circular Progress for Disk Usage
                        Circle()
                            .stroke(lineWidth: 5)
                            .opacity(0.3)
                            .foregroundColor(.blue)
                        
                        Circle()
                            .trim(from: 0.0, to: CGFloat(diskStats.usedPercentage))
                            .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .round))
                            .foregroundColor(.blue)
                            .rotationEffect(.degrees(-90))
                            .animation(.easeInOut, value: diskStats.usedPercentage)
                        
                        
                        VStack {
                            Image(systemName: "opticaldiscdrive")
                                .symbolRenderingMode(.hierarchical)
                                .font(.system(size: 20))
                                .foregroundColor(.blue)
                            
                            Text("\(Int(diskStats.usedPercentage * 100))%")
                                .font(.caption)
                                .bold()
                                .foregroundColor(.blue)
                        }
                    }
                    .frame(width: 65, height: 65)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        
                        
                        Text("Used: \(diskStats.usedSpace) GB").bold()
                            .font(.system(size: 12))
                        
                        
                        Text("Free: \(diskStats.freeSpace) GB")
                            .bold()
                            .font(.system(size: 12))
                    }
                }
                .padding()
                .frame(width: 130)
            }
           // .background(.green)
            .padding(.horizontal, 0)
            
            HStack {
                //MARK: Virtual Memoery Usafe
                VStack(alignment: .center, spacing: 15) {
                    Text("Memory")
                        .font(.headline)
                        .padding(.bottom, 5)
                    
                    ZStack {
                        // Circular Progress View
                        Circle()
                            .stroke(lineWidth: 5)
                            .opacity(0.3)
                            .foregroundColor(.blue)
                        
                        Circle()
                            .trim(from: 0.0, to: CGFloat(memoryStats.freePercentage))
                            .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .round))
                            .foregroundColor(.blue)
                            .rotationEffect(Angle(degrees: -90))
                        
                        // Memory Chip Icon
                        VStack {
                            Image(systemName: "memorychip")
                                .symbolRenderingMode(.hierarchical)
                                .font(.system(size: 20))
                                .foregroundColor(.blue)
                            
                            Text("\(Int(memoryStats.freePercentage * 100))%")
                                .font(.caption)
                                .bold()
                                .foregroundColor(.blue)
                        }
                    }
                    .frame(width: 65, height: 65)
                    
                    // Detailed Statistics
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text("Free:").bold()
                                .font(.system(size: 12))
                            Spacer()
                            Text("\(memoryStats.free) MB")
                                .font(.system(size: 12)).bold()
                        }
                        HStack {
                            Text("Active:").bold()
                                .font(.system(size: 12))
                            Spacer()
                            Text("\(memoryStats.active) MB")
                                .font(.system(size: 12)).bold()
                        }
                        //                    HStack {
                        //                        Text("Inactive:").bold()
                        //                        Spacer()
                        //                        Text("\(memoryStats.inactive) MB")
                        //                    }
                        //                    HStack {
                        //                        Text("Wired:").bold()
                        //                        Spacer()
                        //                        Text("\(memoryStats.wired) MB")
                        //                    }
                        //                    Divider()
                        //                    HStack {
                        //                        Text("Total:").bold()
                        //                        Spacer()
                        //                        Text("\(memoryStats.total) MB")
                        //                    }
                    }
                    
                }
                .padding()
                .frame(width: 130)
                
                //MARK: CPU
                VStack(alignment: .center, spacing: 15) {
                    Text("CPU")
                        .font(.headline)
                        .padding(5)
                    
                    ZStack {
                        
                        Circle()
                            .stroke(lineWidth: 5)
                            .opacity(0.3)
                            .foregroundColor(.blue)
                        
                        Circle()
                            .trim(from: 0.0, to: CGFloat(cpuStats.usage / 100))
                            .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .round))
                            .foregroundColor(.blue)
                            .rotationEffect(.degrees(-90))
                            .animation(.easeInOut, value: cpuStats.usage)
                        
                        
                        VStack {
                            Image(systemName: "cpu")
                                .symbolRenderingMode(.hierarchical)
                                .font(.system(size: 20))
                                .foregroundColor(.blue)
                            
                            Text("\(String(format: "%.1f", cpuStats.usage))%")
                                .font(.caption)
                                .bold()
                                .foregroundColor(.blue)
                        }
                    }
                    .frame(width: 65, height: 65)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Usage: \(String(format: "%.1f", cpuStats.usage))%")
                            .bold()
                            .font(.system(size: 12))
                        Text("Cores: \(ProcessInfo.processInfo.processorCount)")
                            .bold()
                            .font(.system(size: 12))
                    }
                }
                .padding()
                .frame(width: 130)
            }
           // .background(.red)
        }
    }
}
extension DiskStats {
    var usedPercentage: Double {
        guard totalSpace > 0 else { return 0 }
        return Double(usedSpace) / Double(totalSpace)
    }
}

//For canvas
//struct StatsView_Previews: PreviewProvider {
//    static var previews: some View {
//        MemoryUsageView(
//            memoryStats: MockMemoryStats(),
//            diskStats: MockDiskStats()
//        )
//        .previewLayout(.sizeThatFits)
//    }
//}
