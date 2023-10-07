//
//  HabitItem.swift
//  Swift Data
//
//  Created by Ben Hernes on 10/7/23.
//

import Foundation
import SwiftData

@Model
class HabitItem: Identifiable {
    
    var id: String
    var name: String
    var notes: String
    var dailyReminder: Bool
    var date: Date
    
    init(name: String, notes: String, dailyReminder: Bool, date: Date) {
        self.id = UUID().uuidString
        self.name = name
        self.notes = notes
        self.dailyReminder = dailyReminder
        self.date = date
    }
}


