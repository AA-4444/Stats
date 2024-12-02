//
//  AppDelegate.swift
//  Stats
//
//  Created by Алексей Зарицький on 11/29/24.
//

import SwiftUI
import AppKit

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusItem: NSStatusItem?
    var popover: NSPopover?
    var timer: Timer?
    @ObservedObject var memoryStats = MemoryStats()

    func applicationDidFinishLaunching(_ notification: Notification) {
        
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
        if let button = statusItem?.button {
            button.image = NSImage(systemSymbolName: "macbook.gen2", accessibilityDescription: " ")
            button.action = #selector(togglePopover)
            button.target = self
        }

        
        popover = NSPopover()
        popover?.contentViewController = NSHostingController(rootView: StatsView(memoryStats: memoryStats))
        popover?.behavior = .transient

        //MARK:  Start updating virtual memory stat...
        startUpdatingMemoryUsage()
    }

    func startUpdatingMemoryUsage() {
        // Timer to   update memory every sec
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.memoryStats.updateStats()
        }
    }

    @objc func togglePopover() {
        if let button = statusItem?.button {
            if popover?.isShown == true {
                popover?.performClose(nil)
            } else {
                popover?.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
            }
        }
    }
}
