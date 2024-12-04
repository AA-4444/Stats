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
    var statsPopover: NSPopover!
    var settingsPopover: NSPopover!

    func applicationDidFinishLaunching(_ notification: Notification) {
       
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
        if let button = statusItem?.button {
            button.image = NSImage(systemSymbolName: "macbook.gen2", accessibilityDescription: " ")
            button.action = #selector(toggleStatsPopover)
            button.target = self
        }

        // --> main stats view
        statsPopover = NSPopover()
        statsPopover.contentViewController = NSHostingController(
            rootView: StatsView(
                memoryStats: MemoryStats(),
                onSettingsButtonClick: { [weak self] in self?.showSettingsPopover() }
            )
        )
        statsPopover.behavior = .transient

        // --> settings view
        settingsPopover = NSPopover()
        settingsPopover.contentViewController = NSHostingController(rootView: SettingsView())
        settingsPopover.behavior = .transient
    }

    // Switch views
    @objc func toggleStatsPopover() {
        guard let button = statusItem?.button else { return }
        if statsPopover.isShown {
            statsPopover.performClose(nil)
        } else {
            statsPopover.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
        }
    }

    
    func showSettingsPopover() {
        guard let button = statusItem?.button else { return }
        if settingsPopover.isShown {
            settingsPopover.performClose(nil)
        } else {
            settingsPopover.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
        }
    }
}
