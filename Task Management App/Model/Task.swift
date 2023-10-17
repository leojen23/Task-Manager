//
//  Task.swift
//  Task Management App
//
//  Created by Olivier Guillemot on 16/10/2023.
//

import SwiftUI
import SwiftData


@Model
class Task: Identifiable {
    
    var id: UUID
    var taskTitle: String
    var creationDate: Date
    var isCompleted: Bool
    var tint: String
    
    
    init(id: UUID = .init(), taskTitle: String, creationDate: Date = .init(), isCompleted: Bool = false, tint: String) {
        self.id = id
        self.taskTitle = taskTitle
        self.creationDate = creationDate
        self.isCompleted = isCompleted
        self.tint = tint
        
        
        
    }
    var tintColor: Color {
        switch tint {
        case "TaskColor 1": return .taskColor1
        case "TaskColor 2": return .taskColor2
        case "TaskColor 3": return .taskColor3
        case "TaskColor 4": return .taskColor4
        case "TaskColor 5": return .taskColor5
        default: return .black
        }
    }
    
}

//
//var sampleTasks: [Task] = [
//    .init(taskTitle:"book doctor appointment", creationDate: .updateHour(-5), isCompleted: true, tint: .taskColor1),
//    .init(taskTitle:"Apply for jobs", creationDate: .updateHour(-3), tint: .taskColor2),
//    .init(taskTitle:"Edit video", creationDate: .updateHour(0), isCompleted: true, tint: .taskColor3),
//    .init(taskTitle:"Publish video", creationDate: .updateHour(2), isCompleted: true, tint: .taskColor4),
//    .init(taskTitle:"go on bike ride", creationDate: .updateHour(1),  tint: .taskColor5),
//]

extension Date {
    static func updateHour(_ value: Int) -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .hour,value: value, to: .init()) ?? .init()
    }
}
