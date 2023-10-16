//
//  Task.swift
//  Task Management App
//
//  Created by Olivier Guillemot on 16/10/2023.
//

import SwiftUI

struct Task: Identifiable {
    
    var id: UUID = .init()
    var taskTitle: String
    var creationDate: Date = .init()
    var isCompleted = false
    var tint: Color
    
}


var sampleTasks: [Task] = [
    .init(taskTitle:"book doctor appointment", creationDate: .updateHour(-5), isCompleted: true, tint: .taskColor1),
    .init(taskTitle:"Apply for jobs", creationDate: .updateHour(-3), tint: .taskColor2),
    .init(taskTitle:"Edit video", creationDate: .updateHour(0), isCompleted: true, tint: .taskColor3),
    .init(taskTitle:"Publish video", creationDate: .updateHour(2), isCompleted: true, tint: .taskColor4),
    .init(taskTitle:"go on bike ride", creationDate: .updateHour(1),  tint: .taskColor5),
]

extension Date {
    static func updateHour(_ value: Int) -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .hour,value: value, to: .init()) ?? .init()
    }
}
