//
//  TaskItem.swift
//  Swift Data
//
//  Created by Ben Hernes on 9/12/23.
//

import Foundation
import SwiftData


@Model
class TaskItem: Identifiable {
    
    var id: String
    var taskName: String
    var isCompleted: Bool
    var isA: Bool
    var date: Date?
    
    init(taskName: String, isCompleted: Bool = false, isA: Bool, date: Date?) {
        self.id = UUID().uuidString
        self.taskName = taskName
        self.isCompleted = isCompleted
        self.isA = isA
        self.date = date ?? Date()
    }
}
