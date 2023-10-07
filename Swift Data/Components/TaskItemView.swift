//
//  TaskItemView.swift
//  Swift Data
//
//  Created by Ben Hernes on 9/23/23.
//

import SwiftUI

struct TaskItemView: View {
    @State var task: TaskItem
    @State private var isEdit = false
    @State private var isCompletedTemp: Bool
    
    init(task: TaskItem, isEdit: Bool = false) {
        self.task = task
        self.isEdit = isEdit
        self.isCompletedTemp = task.isCompleted
    }
    
    var body: some View {
        HStack {
            Button {
                withAnimation(.bouncy) {
                    vibrateStrong()
                    task.date = Date()
                    isCompletedTemp.toggle()
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        task.isCompleted.toggle()
                        isCompletedTemp = task.isCompleted
                    }
                }
            }
            label: {
                HStack {
                    Group {
                        isCompletedTemp ? Image(systemName: "checkmark.square"): Image(systemName: "square")
                    }
                    .font(.title2)
                }
                .foregroundStyle(isCompletedTemp ? .green.opacity(0.3) : .black)
            }
            .buttonStyle(PlainButtonStyle())
            
            HStack {
//                Text(task.isA ? "A/" : "B/")
//                    .font(.callout)
//                    .foregroundStyle(isCompletedTemp ? .green.opacity(0.3) : task.isA ? .black : .black)
//                    .fontWeight(task.isA ? .bold : .bold)
                    
                RoundedRectangle(cornerSize: CGSize(width: 5, height: 5))
                    .presentationCornerRadius(20)
                    .frame(width: 4, height: 30)
                    .foregroundStyle(isCompletedTemp ? .green.opacity(0.3) : task.isA ? .blue : .gray)
    
                
                Text(task.taskName)
                    .font(.callout)
                    .foregroundStyle(isCompletedTemp ? .green.opacity(0.3) : .black)
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

//#Preview {
//    TaskItemView(task: TaskItem(taskName: "Test task", isCompleted: false, isA: true, date: Date()))
//}
