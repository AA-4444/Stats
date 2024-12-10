//
//  SetingsView.swift
//  Stats
//
//  Created by Алексей Зарицький on 12/5/24.
//

import SwiftUI
import Foundation
import AppKit


struct SettingsView: View {
    @State private var someSetting = true
    @EnvironmentObject var themeManager: ThemeManager

    var body: some View {
        VStack(spacing: 15) {
            Text("Theme")
                .bold()
                .font(.system(size: 18))
                .padding(.top, 10)
                
//MARK: Classic Theme...
            VStack {
                Text("Classic")
                    .foregroundColor(.white)
                    .font(.headline)
                
                //Theme button
                Button {
                    
                } label: {
                    HStack {
                        
                        
                        VStack(alignment: .center, spacing: 15) {
                            
                            
                            ZStack {
                                
                                Circle()
                                    .stroke(lineWidth: 5)
                                    .opacity(0.3)
                                    .foregroundColor(.gray)
                                
                                Circle()
                                    .trim(from: 0.5, to: CGFloat(10 / 10))
                                    .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .round))
                                    .foregroundColor(.green)
                                    .rotationEffect(.degrees(90))
                                    .animation(.easeInOut, value: 100)
                                
                                
                                VStack {
                                    Image(systemName: "cpu")
                                        .symbolRenderingMode(.hierarchical)
                                        .font(.system(size: 19))
                                        .foregroundColor(.white)
                                    
                                    Text("%1")
                                        .font(.system(size: 8))
                                        .foregroundColor(.white)
                                        
                                    
                                    
                                }
                            }
                            .frame(width: 60, height: 60)
                            
                            
                        }
                        .padding()
                        .frame(width: 80)
                        
                        VStack(alignment: .center, spacing: 15) {
                            
                            
                            ZStack {
                                
                                Circle()
                                    .stroke(lineWidth: 5)
                                    .opacity(0.3)
                                    .foregroundColor(.gray)
                                
                                Circle()
                                    .trim(from: 0.4, to: CGFloat(10 / 10))
                                    .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .round))
                                    .foregroundColor(.yellow)
                                    .rotationEffect(.degrees(130))
                                    .animation(.easeInOut, value: 100)
                                
                                
                                VStack {
                                    Image(systemName: "cpu")
                                        .symbolRenderingMode(.hierarchical)
                                        .font(.system(size: 19))
                                        .foregroundColor(.white)
                                    
                                    Text("%1")
                                        .font(.system(size: 8))
                                        .foregroundColor(.white)
                                    
                                    
                                }
                            }
                            .frame(width: 60, height: 60)
                            
                            
                        }
                        .padding()
                        .frame(width: 80)
                        
                        VStack(alignment: .center, spacing: 15) {
                            
                            
                            ZStack {
                                
                                Circle()
                                    .stroke(lineWidth: 5)
                                    .opacity(0.3)
                                    .foregroundColor(.gray)
                                
                                Circle()
                                    .trim(from: 0.2, to: CGFloat(10 / 10))
                                    .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .round))
                                    .foregroundColor(.red)
                                    .rotationEffect(.degrees(200))
                                    .animation(.easeInOut, value: 100)
                                
                                
                                VStack {
                                    Image(systemName: "cpu")
                                        .symbolRenderingMode(.hierarchical)
                                        .font(.system(size: 19))
                                        .foregroundColor(.white)
                                    
                                    Text("%1")
                                        .font(.system(size: 8))
                                        .foregroundColor(.white)
                                    
                                }
                            }
                            .frame(width: 60, height: 60)
                            
                            
                        }
                        .padding()
                        .frame(width: 80)
                        
                    }
                }
                .buttonStyle(PlainButtonStyle())
            }
            
            //MARK: Neon theme
            VStack {
                Text("Neon")
                    .foregroundColor(.white)
                    .font(.headline)
                //Theme button ..
                Button {
                    themeManager.currentTheme = Themes.neon
                } label: {
                    HStack {
                        
                        
                        VStack(alignment: .center, spacing: 15) {
                            
                            
                            ZStack {
                                
                                Circle()
                                    .stroke(lineWidth: 5)
                                    .opacity(0.3)
                                    .foregroundColor(Color.mint)
                                
                                Circle()
                                    .trim(from: 0.5, to: CGFloat(10 / 10))
                                    .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .round))
                                    .foregroundColor(.mint)
                                    .rotationEffect(.degrees(90))
                                    .animation(.easeInOut, value: 100)
                                    .shadow(color: Color.mint.opacity(0.7), radius: 10, x: 0, y: 0)
                                
                                
                                VStack {
                                    Image(systemName: "cpu")
                                        .symbolRenderingMode(.hierarchical)
                                        .font(.system(size: 19))
                                        .foregroundColor(Color.mint)
                                        .shadow(color: .mint.opacity(0.7), radius: 10, x: 0, y: 0)
                                    
                                    Text("%1")
                                        .font(.system(size: 8))
                                        .foregroundColor(.mint)
                                    
                                    
                                }
                            }
                            .frame(width: 60, height: 60)
                            
                            
                        }
                        .padding()
                        .frame(width: 80)
                        
                        VStack(alignment: .center, spacing: 15) {
                            
                            
                            ZStack {
                                
                                Circle()
                                    .stroke(lineWidth: 5)
                                    .opacity(0.3)
                                    .foregroundColor(.mint)
                                
                                Circle()
                                    .trim(from: 0.4, to: CGFloat(10 / 10))
                                    .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .round))
                                    .foregroundColor(.mint)
                                    .rotationEffect(.degrees(130))
                                    .animation(.easeInOut, value: 100)
                                    .shadow(color: Color.mint.opacity(0.7), radius: 10, x: 0, y: 0)
                                
                                
                                VStack {
                                    Image(systemName: "cpu")
                                        .symbolRenderingMode(.hierarchical)
                                        .font(.system(size: 19))
                                        .foregroundColor(.mint)
                                        .shadow(color: Color.mint.opacity(0.7), radius: 10, x: 0, y: 0)
                                    
                                    Text("%1")
                                        .font(.system(size: 8))
                                        .foregroundColor(.mint)
                                    
                                }
                            }
                            .frame(width: 60, height: 60)
                            
                            
                        }
                        .padding()
                        .frame(width: 80)
                        
                        VStack(alignment: .center, spacing: 15) {
                            
                            
                            ZStack {
                                
                                Circle()
                                    .stroke(lineWidth: 5)
                                    .opacity(0.3)
                                    .foregroundColor(.mint)
                                
                                Circle()
                                    .trim(from: 0.2, to: CGFloat(10 / 10))
                                    .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .round))
                                    .foregroundColor(.mint)
                                    .rotationEffect(.degrees(200))
                                    .animation(.easeInOut, value: 100)
                                    .shadow(color: Color.mint.opacity(0.7), radius: 10, x: 0, y: 0)
                                
                                
                                VStack {
                                    Image(systemName: "cpu")
                                        .symbolRenderingMode(.hierarchical)
                                        .font(.system(size: 19))
                                        .foregroundColor(.mint)
                                        .shadow(color: Color.mint.opacity(0.7), radius: 10, x: 0, y: 0)
                                    
                                    Text("%1")
                                        .font(.system(size: 8))
                                        .foregroundColor(.mint)
                                    
                                }
                            }
                            .frame(width: 60, height: 60)
                            
                            
                        }
                        .padding()
                        .frame(width: 80)
                        
                    }
                }
                .buttonStyle(PlainButtonStyle())
            }
            
            //MARK: Blue Theme
            VStack {
                Text("Base")
                    .foregroundColor(.white)
                    .font(.headline)
                //Theme Button ...
                Button {
                    themeManager.currentTheme = Themes.blue
                } label: {
                    HStack {
                        
                        
                        VStack(alignment: .center, spacing: 15) {
                            
                            
                            ZStack {
                                
                                Circle()
                                    .stroke(lineWidth: 5)
                                    .opacity(0.3)
                                    .foregroundColor(Color.blue)
                                
                                Circle()
                                    .trim(from: 0.5, to: CGFloat(10 / 10))
                                    .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .round))
                                    .foregroundColor(.blue)
                                    .rotationEffect(.degrees(90))
                                    .animation(.easeInOut, value: 100)
                                
                                
                                
                                VStack {
                                    Image(systemName: "cpu")
                                        .symbolRenderingMode(.hierarchical)
                                        .font(.system(size: 19))
                                        .foregroundColor(Color.blue)
                                    
                                    Text("%1")
                                        .font(.system(size: 8))
                                        .foregroundColor(.blue)
                                    
                                }
                            }
                            .frame(width: 60, height: 60)
                            
                            
                        }
                        .padding()
                        .frame(width: 80)
                        
                        VStack(alignment: .center, spacing: 15) {
                            
                            
                            ZStack {
                                
                                Circle()
                                    .stroke(lineWidth: 5)
                                    .opacity(0.3)
                                    .foregroundColor(.blue)
                                
                                Circle()
                                    .trim(from: 0.4, to: CGFloat(10 / 10))
                                    .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .round))
                                    .foregroundColor(.blue)
                                    .rotationEffect(.degrees(130))
                                    .animation(.easeInOut, value: 100)
                                
                                
                                
                                VStack {
                                    Image(systemName: "cpu")
                                        .symbolRenderingMode(.hierarchical)
                                        .font(.system(size: 19))
                                        .foregroundColor(.blue)
                                    
                                    
                                    
                                    Text("%1")
                                        .font(.system(size: 8))
                                        .foregroundColor(.blue)
                                }
                            }
                            .frame(width: 60, height: 60)
                            
                            
                        }
                        .padding()
                        .frame(width: 80)
                        
                        VStack(alignment: .center, spacing: 15) {
                            
                            
                            ZStack {
                                
                                Circle()
                                    .stroke(lineWidth: 5)
                                    .opacity(0.3)
                                    .foregroundColor(.blue)
                                
                                Circle()
                                    .trim(from: 0.2, to: CGFloat(10 / 10))
                                    .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .round))
                                    .foregroundColor(.blue)
                                    .rotationEffect(.degrees(200))
                                    .animation(.easeInOut, value: 100)
                                
                                
                                
                                VStack {
                                    Image(systemName: "cpu")
                                        .symbolRenderingMode(.hierarchical)
                                        .font(.system(size: 19))
                                        .foregroundColor(.blue)
                                    
                                    
                                    
                                    Text("%1")
                                        .font(.system(size: 8))
                                        .foregroundColor(.blue)
                                }
                            }
                            .frame(width: 60, height: 60)
                            
                            
                        }
                        .padding()
                        .frame(width: 80)
                        
                    }
                }
                .buttonStyle(PlainButtonStyle())
            }
            
            
            

            Spacer()
        }
        .padding()
        .frame(width: 300, height: 450)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
SettingsView()
        .previewLayout(.sizeThatFits)
    }
}
