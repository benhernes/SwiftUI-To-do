//
//  NewHabitView.swift
//  Swift Data
//
//  Created by Ben Hernes on 10/2/23.
//

import SwiftUI

struct NewHabitView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var habitModelContext
    
    
    @State var habitName: String = ""
    @State var habitNotes: String = ""
    @State var habitDailyReminder: Bool = false
    
    
    var body: some View {
        
        ZStack (alignment: .bottomTrailing) {
            List {
                Section("Project") {
                    TextField(text: $habitName) {
                        Text("Enter project name")
                    }
                    
                    Toggle(isOn: $habitDailyReminder) {
                        Text("Daily reminder")
                    }
                }
                
                Section("Notes") {
                    TextEditor(text: $habitNotes)
                        .frame(minHeight: 80)
                }

            }
            
            
            Button {
                vibrateStrong()
                addItem(habitName: habitName)
                dismiss()
            } label: {
                Image(systemName: "paperplane.fill")
                    .font(.title)
                    .foregroundStyle(.white)
                    .padding()
                    .frame(width: 65, height: 65)
                    .background(Color.gray.gradient)
                    .clipShape(Circle())
                    .shadow(radius: 6)
                    .padding()
            }
        }
    }
    
    func addItem(habitName: String) {
        // Create item
        let habitItem = HabitItem(name: habitName, notes: habitNotes, dailyReminder: habitDailyReminder, date: Date())
        
        // Add item to data context
        habitModelContext.insert(habitItem)
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
