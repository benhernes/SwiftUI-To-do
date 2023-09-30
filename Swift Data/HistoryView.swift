//
//  TestAdditionalView.swift
//  Swift Data
//
//  Created by Ben Hernes on 9/14/23.
//

import SwiftUI
import SwiftData

struct HistoryView: View {
    @Environment(\.modelContext) private var taskModelContext
    @Query private var tasks: [TaskItem]
    
    @Query(
        filter: #Predicate<TaskItem>{ $0.isCompleted},
        sort: [.init(\TaskItem.date, order: .reverse)],
        animation: .bouncy) private var historicalTasks: [TaskItem]
    
    @State private var isShowingDeleteAlert = false
    
    var body: some View {
        
        var groupedTasks: [String: [TaskItem]] {
            var groups: [String: [TaskItem]] = [:]
            for task in historicalTasks {
                let key = dayKey(for: task.date!)
                groups[key, default: []].append(task)
            }
            return groups
        }
        
        NavigationStack {
            
            VStack {
                
                // MARK: Date select horizonal scroll view (deleted)
                //            ScrollView(.horizontal) {
                //                HStack {
                //                    ForEach(0 ..< 19) { _ in
                //                        RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                //                            .frame(height: 40)
                //                            .containerRelativeFrame(/*@START_MENU_TOKEN@*/.horizontal/*@END_MENU_TOKEN@*/, count: /*@START_MENU_TOKEN@*/4/*@END_MENU_TOKEN@*/, spacing: 10)
                //                            .foregroundStyle(.blue.gradient)
                //                            .scrollTransition { content, phase in
                //                                content
                //                                    .opacity(phase.isIdentity ? 1 : 0.2)
                //                                    .scaleEffect(phase.isIdentity ? 1 : 0.2)
                //                            }
                //                    }
                //                }
                //                .scrollTargetLayout()
                //            }
                //            .contentMargins(16, for: .scrollContent)
                //            .scrollTargetBehavior(.viewAligned)
                
                
                List {
                    VStack(alignment: .leading) {
                        Text("This list shows all previously completed tasks. Tap the plus icon to add a copy to today's list")
                        Divider()
                        Text("Tap anywhere on an item to delete from history")
                    }
                    .font(.footnote)
                    .foregroundStyle(.gray)
                    .italic()
                    
                    ForEach(groupedTasks.keys.sorted(by: >), id: \.self) { key in
                        Section(header: Text(key)) {
                            ForEach(groupedTasks[key]!, id: \.self) { task in
                                HistoricalTaskItemView(task: task)
                            }
                        }
                    }
                    
                    Button {
                        // delete all
                        isShowingDeleteAlert.toggle()
                    } label: {
                        Text("Delete all")
                            .foregroundStyle(.red)
                    }
                    
                }
                .listStyle(.plain)
                .alert("Are you sure you want to delete all tasks? This cannot be undone", isPresented: $isShowingDeleteAlert) {
                    Button {
                        // action
                    } label: {
                        Text("No, go back")
                    }
                    
                    Button {
                        // action
                        for task in tasks {
                            deleteTask(task)
                        }
                    } label: {
                        Text("Yes, delete all my tasks")
                    }
                }
            }
            .navigationTitle("History")
        }


    }
    
    func dayKey(for date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
    
    func deleteTask (_ task: TaskItem) {
        taskModelContext.delete(task)
    }
}

//#Preview {
//    TestAdditionalView()
//}


//Image(systemName: "ellipsis.message")
//    .symbolRenderingMode(.multicolor)
//    .symbolEffect(.variableColor.iterative)
//    .font(.largeTitle)
