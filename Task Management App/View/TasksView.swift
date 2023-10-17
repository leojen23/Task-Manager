//
//  TasksView.swift
//  Task Management App
//
//  Created by Olivier Guillemot on 17/10/2023.
//

import SwiftUI
import SwiftData

struct TasksView: View {
    
    @Binding var currentDate: Date
    
    // Dynamic query SwiftData
    @Query private var tasks: [Task]
    
    init(currentDate: Binding<Date>) {
        self._currentDate = currentDate
        let calendar = Calendar.current
        let startOfDate = calendar.startOfDay(for: currentDate.wrappedValue)
        let endOfDate = calendar.date(byAdding: .day, value:1, to: startOfDate)!
        
        // Predicate
        let predicate = #Predicate<Task> {
            return $0.creationDate >= startOfDate && $0.creationDate < endOfDate
        }
        
        // Sorting
        
        let sortingDescription = [
            SortDescriptor(\Task.creationDate, order: .reverse)
        ]
        self._tasks = Query(filter: predicate, sort: sortingDescription,animation: .snappy)
    }
    

    var body: some View {
        VStack(alignment: .leading, spacing: 35) {
            ForEach(tasks) {task in
                TaskListItemView(task: task)
                    .background(alignment: .leading){
                        if tasks.last?.id != task.id {
                            Rectangle()
                                .frame(width: 1)
                                .offset(x:8)
                                .padding(.bottom, -35)
                        }
                    }
            }
        }
        .padding([.vertical, .leading], 15)
        .padding(.top, 15)
        .overlay {
            if tasks.isEmpty {
                Text("No Task's Found")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                .frame(width: 150)            }
        }
    }
}

#Preview {
    ContentView()
}
