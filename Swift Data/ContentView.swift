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
}

struct ContentView: View {
    
    @State private var currentTab: Tabs = .today
    
    var body: some View {
        
        TabView(selection: $currentTab) {
            TodayView()
                .navigationBarTitle("Today")
                .tabItem {
                    Image(systemName: "calendar.day.timeline.trailing")
                    Text("Today")
                }
                .tag(Tabs.today)
            
            
            HistoryView()
                .navigationBarTitle("History")
                .tabItem {
                    Image(systemName: "calendar")
                    Text("History")
                }
                .tag(Tabs.historical)
            //                .toolbarBackground(.automatic, for: .tabBar)
            //                .toolbarBackground(.visible, for: .navigationBar)
            
        }
        
        
    }
    
}
