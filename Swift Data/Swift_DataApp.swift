//
//  Swift_DataApp.swift
//  Swift Data
//
//  Created by Ben Hernes on 9/12/23.
//
// 9:04

import SwiftUI
import SwiftData

@main
struct Swift_DataApp: App {
    
        
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.colorScheme, .light)
        }
        .modelContainer(for: TaskItem.self)

    }
}
