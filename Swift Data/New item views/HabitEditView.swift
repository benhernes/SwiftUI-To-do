//
//  HabitEditView.swift
//  Swift Data
//
//  Created by Ben Hernes on 10/7/23.
//

import SwiftUI

struct HabitEditView: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var habit: HabitItem
    
    var body: some View {
        ZStack (alignment: .bottomTrailing) {
            List {
                Section("Project") {
                    TextField(text: $habit.name) {
                        Text("Enter project name")
                    }
                    
                    Toggle(isOn: $habit.dailyReminder) {
                        Text("Daily reminder")
                    }
                }
                
                Section("Notes") {
                    TextEditor(text: $habit.notes)
                        .frame(minHeight: 120)

                }

            }
            
            
            Button {
                vibrateStrong()
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
