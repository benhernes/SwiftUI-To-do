//
//  ContentView.swift
//  Swift Data
//
//  Created by Ben Hernes on 9/12/23.
//

import SwiftUI
import SwiftData
import Foundation

enum Tabs: String {
    case today = "Today"
    case historical = "Historical"
    case habits = "Habits"
}

struct ContentView: View {
    
    @State private var currentTab: Tabs = .today

    
    var body: some View {
        
        TabView(selection: $currentTab) {
            TodayView()
                .tabItem {
                    Image(systemName: "calendar.day.timeline.trailing")
                    Text("Today")
                }
                .tag(Tabs.today)
                .onAppear {
                    vibrate()
                }

            
            
            HistoryView()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("History")
                }
                .tag(Tabs.historical)
                .onAppear {
                    vibrate()
                }
         
            HabitView()
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("Projects")
                }
                .badge(0)
                .tag(Tabs.habits)
                .onAppear {
                    vibrate()
                }
            
        }
        
    }
    
    // MARK: System feedback
    func vibrate() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
    
    func vibrateStrong() {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
    }
    
    func vibrateDouble() {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred(intensity: 100)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            generator.impactOccurred(intensity: 10)
        }
    }
    
}
