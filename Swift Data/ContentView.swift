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
    
    @Environment(\.modelContext) private var taskModelContext
    @Query private var tasks: [TaskItem]
    
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
    
    @State private var currentTab: Tabs = .today
    @State private var isAddEditTask = false
    @State private var isExpandedCompletedList = false
    @State private var isShowingCompleted = true
    
    var body: some View {
        
        @State var filteredSortedClosedTasks: [TaskItem] = sortedClosedTasks.filter {
            Calendar.current.isDateInToday($0.date!)
        }

        NavigationStack {
            
            Text("what's up bitches")
                        
            TabView(selection: $currentTab) {
                
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
                        
                        
                        // MARK: Today completed (opt. toggle code below)
//                        Toggle(isOn: $isShowingCompleted) {
//                            Text("Show completed")
//                                .font(.caption2)
//                        }
//                        .animation(.easeInOut, value: isShowingCompleted)
                        
                        if isShowingCompleted {
                            Section("Completed today") {
                                ForEach(filteredSortedClosedTasks) { task in
                                    TaskItemView(task: task)
                                }
                            }
                        }
                        
                    }
                    .listStyle(.plain)
                    
                    .refreshable {
                        // code for refreshing
                    }
                    
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
                .tabItem {
                    Image(systemName: "calendar.day.timeline.trailing")
                    Text("Today")
                }
                .tag(Tabs.today)
                .toolbarBackground(.automatic, for: .tabBar)
                .toolbarBackground(.automatic, for: .navigationBar)


                
                HistoryView()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("History")
                }
                .tag(Tabs.historical)
                .toolbarBackground(.automatic, for: .tabBar)
                .toolbarBackground(.visible, for: .navigationBar)
                
                
            }
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
            .navigationTitle(currentTab.rawValue)
            .navigationBarTitleDisplayMode(.large)

            
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

//#Preview {
//    ContentView()
//}
