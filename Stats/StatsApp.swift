//
//  StatsApp.swift
//  Stats
//
//  Created by Алексей Зарицький on 11/29/24.
//

import SwiftUI
import AppKit

@main
struct StatsApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        
        Settings {
            EmptyView()
        }
    }
}
