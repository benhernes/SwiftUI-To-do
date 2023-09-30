//
//  HistoricalTaskItemView.swift
//  Swift Data
//
//  Created by Ben Hernes on 9/24/23.
//

import SwiftUI

struct HistoricalTaskItemView: View {
    
    @Environment(\.modelContext) private var taskModelContext
    @State var task: TaskItem
    @State var isAdded = false
    @State private var isShowingDeleteAlert = false
    
    var body: some View {
        HStack {
            Group {
                Image(systemName: "checkmark.square")
                    .font(.title2)
                
                HStack {
//                    Text(task.isA ? "A/" : "B/")
//                        .font(.callout)
                    
                    RoundedRectangle(cornerSize: CGSize(width: 5, height: 5))
                        .presentationCornerRadius(20)
                        .frame(width: 4, height: 30)
                    
                    Text(task.taskName)
                        .font(.callout)
                }
            }
            .foregroundStyle(.green.opacity(0.3))
            .onLongPressGesture {
                vibrateStrong()
                isShowingDeleteAlert.toggle()
            }
            
            Spacer()
            
            Button {
                withAnimation(.bouncy) {
                    // MARK: Duplicate to today action
                    vibrateDouble()
                    isAdded = true
                    duplicateItem(task: task)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                        isAdded = false
                    }

                }
            }
            
            label: {
                HStack {
                    Group {
                    // MARK: Plus icon ('added to today')
                        Image(systemName: isAdded ? "checkmark" : "plus")
                            .contentTransition(.symbolEffect(.replace.downUp.byLayer))
                    }
                    .font(.title2)
                }
                .foregroundStyle(isAdded ? .blue : .black)
            }
            .buttonStyle(PlainButtonStyle())
            
        }
        .alert("Are you sure you want to delete '\(task.taskName)'?", isPresented: $isShowingDeleteAlert) {
            Button {
                // do nothing
            } label: {
                Text("Cancel")
            }
            
            Button {
                // delete task
                deleteItem(task: task)
            } label: {
                Text("Delete item")
            }
        }
        
    }
    
    func duplicateItem(task: TaskItem) {
        let newTaskItem = TaskItem(taskName: task.taskName, isA: task.isA, date: Date())
        
        taskModelContext.insert(newTaskItem)
    }
    
    func deleteItem(task: TaskItem) {
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            generator.impactOccurred(intensity: 10)
        }
    }
}

//#Preview {
//    HistoricalTaskItemView()
//}
