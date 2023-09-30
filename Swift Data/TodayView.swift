//
//  TodayView.swift
//  Swift Data
//
//  Created by Ben Hernes on 9/30/23.
//

import SwiftUI
import SwiftData

struct TodayView: View {
    @Environment(\.modelContext) private var taskModelContext
    @State private var isAddEditTask = false
    
    @Query(
        filter: #Predicate<TaskItem>{ !$0.isCompleted && $0.isA},
        sort: [.init(\TaskItem.taskName)],
        animation: .bouncy) private var sortedOpenTasksA: [TaskItem]
    
    @Query(
        filter: #Predicate<TaskItem>{ !$0.isCompleted && !$0.isA},
        sort: [.init(\TaskItem.taskName)],
        animation: .bouncy) private var sortedOpenTasksB: [TaskItem]
    
    @Query(
        filter: #Predicate<TaskItem>{ $0.isCompleted },
        sort: [.init(\TaskItem.taskName)],
        animation: .bouncy) private var sortedClosedTasks: [TaskItem]
    
    
    
    var body: some View {
        
        @State var filteredSortedClosedTasks: [TaskItem] = sortedClosedTasks.filter {
            Calendar.current.isDateInToday($0.date!)
        }
        
        NavigationStack {
            
            ZStack(alignment: .bottomTrailing) {
                
                List {
                    // MARK: Today A
                    Section("Priority A") {
                        ForEach(sortedOpenTasksA) { task in
                            NavigationLink {
                                NewTaskView(isCreate: false, task: task)
                                    .navigationTitle("Edit task")
                                    .navigationBarTitleDisplayMode(.inline)
                            } label: {
                                TaskItemView(task: task)
                            }
                        }
                        .onDelete { indexes in
                            for index in indexes {
                                deleteItem(sortedOpenTasksA[index])
                            }
                        }
                    }
                    
                    // MARK: Today B
                    Section("Priority B") {
                        ForEach(sortedOpenTasksB) { task in
                            NavigationLink {
                                NewTaskView(isCreate: false, task: task)
                                    .navigationTitle("Edit task")
                                    .navigationBarTitleDisplayMode(.inline)
                            } label: {
                                TaskItemView(task: task)
                            }
                        }
                        .onDelete { indexes in
                            for index in indexes {
                                deleteItem(sortedOpenTasksB[index])
                            }
                        }
                    }
                    
                    
                    Section("Completed today") {
                        ForEach(filteredSortedClosedTasks) { task in
                            TaskItemView(task: task)
                        }
                    }
                    
                }
                .listStyle(.plain)
                
                Button {
                    addItem()
                } label: {
                    Image(systemName: "plus")
                        .font(.title)
                        .foregroundStyle(.white)
                        .padding()
                        .frame(width: 65, height: 65)
                        .background(Color.blue.gradient)
                        .clipShape(Circle())
                        .shadow(radius: 6)
                        .padding()
                }
            }
            .navigationTitle("Today")
            .sheet(isPresented: $isAddEditTask) {
                NavigationStack {
                    NewTaskView(isCreate: true, task: nil)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarLeading) {
                                Button {
                                    isAddEditTask = false
                                } label: {
                                    HStack {
                                        Text("Cancel")
                                    }
                                }
                                
                            }
                        }
                        .navigationTitle("Add task")
                        .navigationBarTitleDisplayMode(.inline)
                }
                .presentationDetents([.fraction(0.75)])
                .environment(\.colorScheme, .light)
            }
        }
        
        
        
    }
    
    
    
    func addItem() {
        vibrate()
        isAddEditTask = true
    }
    
    func deleteItem(_ task: TaskItem) {
        vibrateDouble()
        taskModelContext.delete(task)
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
