//
//  NewTaskView.swift
//  Swift Data
//
//  Created by Ben Hernes on 9/16/23.
//

import SwiftUI

struct NewTaskView: View {
    
    @Environment(\.modelContext) private var taskModelContext
    @Environment(\.dismiss) private var dismiss
    @FocusState private var isFocused: Bool
    
    var isCreate: Bool
    var task: TaskItem?
    @State var taskName: String
    @State var taskDue: Date = .now
    @State var isA: Bool
    
    init(isCreate: Bool, task: TaskItem?) {
        self.task = task
        self.isCreate = isCreate
        _taskName = State(initialValue: task?.taskName ?? "")
        _isA = State(initialValue: task?.isA ?? false)
    }
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            List {
                Section("Task") {
                    TextField(text: $taskName) {
                        Text("Enter task")
                    }
                    .focused($isFocused)

                }
                
                Section {
                    Toggle(isOn: $isA) {
                        HStack {
                            Text("Priority:")
                                .foregroundStyle(.gray)
                            Text(isA ? "A" : "B")
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
                
                // MARK: Secred add button (removed)
//                Button {
//                    var dateComponents = DateComponents() // Create a DateComponents object
//                    dateComponents.day = -5 // Set the day component to -1 to subtract one day
//                    let yesterday = Calendar.current.date(byAdding: dateComponents, to: Date())
//                    
//                    let taskItem = TaskItem(taskName: "test old add", isA: false, date: yesterday)
//                    taskModelContext.insert(taskItem)
//                } label: {
//                    Text("Secret add")
//                }
                
                // MARK: Due date section (removed)
//                Section("Due date") {
//                    DatePicker("Date", selection: $taskDue)
//                }
                
            }
            .listStyle(.sidebar)

            
            Button {
                // submit
                vibrateDouble()
                isCreate ? addItem(taskName: taskName) : updateItem(task!)
                taskName = ""
                taskDue = .now
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
    
    func addItem(taskName: String) {
        // Create item
        let taskItem = TaskItem(taskName: taskName, isA: isA, date: Date(), habit: nil)
        
        // Add item to data context
        taskModelContext.insert(taskItem)
    }
    
    func updateItem(_ task: TaskItem) {
        // Edit item data
        task.taskName = taskName
        task.isA = isA
        
        // Save the context
        try? taskModelContext.save()
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

//#Preview {
//    NewTaskView(isCreate: true)
//}
