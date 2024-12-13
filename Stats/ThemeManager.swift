//
//  ThemeManager.swift
//  Stats
//
//  Created by Алексей Зарицький on 12/9/24.
//


import SwiftUI

class ThemeManager: ObservableObject {
    @Published var currentTheme: Theme = Themes.blue //--> Default theme
    
    
//    func getDiskCircleColor(for usedPercentage: Double) -> Color {
//          switch usedPercentage {
//          case 0..<0.55:
//              return .green
//          case 0.55..<0.80:
//              return .yellow
//          case 0.80...1.0:
//              return .red
//          default:
//              return .clear
//          }
//      }
}
struct Theme: Equatable {
    var circleColor: Color
    var iconColor: Color
    var textColor: Color
    var shadowColor: Color
    var hasShadow: Bool
}


struct Themes {
    static let classic = Theme(circleColor: .gray, iconColor: .white, textColor: .white, shadowColor: .clear, hasShadow: false)
    static let neon = Theme(circleColor: .mint, iconColor: .mint, textColor: .mint, shadowColor: .mint.opacity(0.7), hasShadow: true)
    static let blue = Theme(circleColor: .blue, iconColor: .blue, textColor: .blue, shadowColor: .clear, hasShadow: false)
}

// add classic theme and create logic for it
