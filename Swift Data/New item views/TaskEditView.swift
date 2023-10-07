//
//  TaskEditView.swift
//  Swift Data
//
//  Created by Ben Hernes on 10/7/23.
//

import SwiftUI

struct TaskEditView: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var task: TaskItem
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            List {
                Section("Task") {
                    TextField(text: $task.taskName) {
                        Text("Enter task")
                    }
                    
                }
                
                Section {
                    Toggle(isOn: $task.isA) {
                        HStack {
                            Text("Priority:")
                                .foregroundStyle(.gray)
                            Text(task.isA ? "A" : "B")
                                .bold()
                        }
                    }
                    .tint(.gray)
                }
            header: {
                Text("Priority")
            }
            footer: {
                Text("Select the toggle for 'A' tasks, items you will certainly complete today. Others will be marked as 'B'")
            }
                
                if let notes = task.habit?.notes {
                    Section("Associated project:") {
                        Text(notes)
                        NavigationLink {
                            HabitEditView(habit: task.habit!)
                        } label: {
                            Text("Edit project")
                        }
                    }
                }
                    
                
            }
            .listStyle(.sidebar)
            
            
            Button {
                // submit
                vibrate()
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
