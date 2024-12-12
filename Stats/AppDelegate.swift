//
//  AppDelegate.swift
//  Stats
//
//  Created by Алексей Зарицький on 11/29/24.
//

import SwiftUI
import AppKit
import Cocoa
import Foundation



// Custom NSWindow subclass..
class CustomSettingsWindow: NSWindow {
    override var canBecomeKey: Bool {
        return true
    }
}



//MARK:  Custom NSWindowController for managing --> settings window...
class SettingsWindowController: NSWindowController {
    
    init(themeManager: ThemeManager) {
        //Settings view and its hosting controller
     //   let settingsView = SettingsView()
        let settingsView = SettingsView().environmentObject(themeManager)
        let hostingController = NSHostingController(rootView: settingsView)
        
     
        let window = CustomSettingsWindow(
            contentRect: NSRect(x: 0, y: 0, width: 280, height: 300),
            styleMask: [.titled, .fullSizeContentView],
            backing: .buffered,
            defer: false
        )
        

        let visualEffectView = NSVisualEffectView()
        visualEffectView.blendingMode = .behindWindow
        visualEffectView.material = .sidebar
        visualEffectView.state = .active
        visualEffectView.frame = window.contentView?.bounds ?? NSRect(x: 0, y: 0, width: 280, height: 300)
        visualEffectView.autoresizingMask = [.width, .height]

        //Dark mdoe
        visualEffectView.appearance = NSAppearance(named: .darkAqua)

        
      
        window.contentView = visualEffectView
       // visualEffectView.material = .hudWindow
        visualEffectView.addSubview(hostingController.view)
        hostingController.view.frame = visualEffectView.bounds
        hostingController.view.autoresizingMask = [.width, .height]
        
        //opacity..
        window.alphaValue = 0.98
        
        window.isOpaque = false
        window.backgroundColor = .clear
        window.level = .floating
        window.titleVisibility = .hidden
        window.titlebarAppearsTransparent = true

        super.init(window: window)
        
        
        self.window?.makeKeyAndOrderFront(nil)
    }
    
    //Animation -- window moving
    func animateWindow(from startFrame: NSRect, to endFrame: NSRect) {
        window?.setFrame(startFrame, display: false)
        NSAnimationContext.runAnimationGroup { context in
            context.duration = 0.3
            context.allowsImplicitAnimation = true
            window?.animator().setFrame(endFrame, display: true)
        }
    }
    
    //MARK: Close settings window...
    func closeWindow() {
        self.window?.close()
    }
    
   
    func resetWindowController() {
        self.window = nil
    }
    
    // --Required initializer for NSWindowController subclass
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}



class AppDelegate: NSObject, NSApplicationDelegate {
    var statusItem: NSStatusItem?
    var statsPopover: NSPopover!
    var settingsWindowController: SettingsWindowController?
    var themeManager = ThemeManager() // Shared ThemeManager
    

    func applicationDidFinishLaunching(_ notification: Notification) {
        // MARK: Status bar item
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
        if let button = statusItem?.button {
            button.image = NSImage(systemSymbolName: "macbook.gen2", accessibilityDescription: " ")
            button.action = #selector(toggleStatsPopover)
            button.target = self
        }

        // Set up the stats popover
        statsPopover = NSPopover()
        let hostingController = NSHostingController(
            rootView: StatsView(
                memoryStats: MemoryStats(),
                onSettingsButtonClick: { [weak self] in self?.showSettingsWindow() }
            ).environmentObject(themeManager)
        )
        hostingController.view.appearance = NSAppearance(named: .darkAqua) // Force dark mode
        statsPopover.contentViewController = hostingController
        statsPopover.behavior = .semitransient
    }
    
    @objc func toggleStatsPopover() {
        guard let button = statusItem?.button else { return }
        
        if statsPopover.isShown {
            statsPopover.performClose(nil)

            //-- Close settings window if open
            if let windowController = settingsWindowController {
                windowController.closeWindow()
                settingsWindowController = nil
            }
        } else {
            statsPopover.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)

            // -- dark mode
            if let popoverWindow = statsPopover.contentViewController?.view.window {
                popoverWindow.appearance = NSAppearance(named: .darkAqua)
            }
        }
    }


    func showSettingsWindow() {
        if let windowController = settingsWindowController {
            windowController.closeWindow()
            self.settingsWindowController = nil
            return
        }

        let statsWindow = statsPopover.contentViewController?.view.window
        let statsFrame = statsWindow?.frame ?? NSRect.zero

        settingsWindowController = SettingsWindowController(themeManager: themeManager)

        let yOffset: CGFloat = -12
        let xOffset: CGFloat = -3

        let initialFrame = NSRect(
            x: statsFrame.maxX + xOffset,
            y: statsFrame.minY + yOffset,
            width: 280,
            height: statsFrame.height
        )
        let finalFrame = NSRect(
            x: statsFrame.maxX + xOffset,
            y: statsFrame.minY + yOffset,
            width: 280,
            height: statsFrame.height
        )

        settingsWindowController?.animateWindow(from: initialFrame, to: finalFrame)
    }
}
