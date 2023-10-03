//
//  NewHabitView.swift
//  Swift Data
//
//  Created by Ben Hernes on 10/2/23.
//

import SwiftUI

struct NewHabitView: View {
    @State private var habitName: String = ""
    
    var body: some View {
        List {
            Section("Habit") {
                TextField(text: $habitName) {
                    Text("Enter habit")
                }
                
            }
        }
    }
}
