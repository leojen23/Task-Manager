//
//  TaskListItemView.swift
//  Task Management App
//
//  Created by Olivier Guillemot on 16/10/2023.
//

import SwiftUI

struct TaskListItemView: View {
    
    @Binding var task: Task
    
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            
            Circle()
                .fill(indicatorColor)
                .frame(width: 10, height: 10)
                .padding(4)
                .background(.white.shadow(.drop(color:.black.opacity(0.2), radius: 3)), in:.circle)
                .overlay {
                    Circle()
                        .frame(width: 50, height: 50)
                        .blendMode(.destinationOver)
                        .onTapGesture(perform: {
                            withAnimation(.snappy){
                                task.isCompleted.toggle()
                            }
                        })
                }
            
            
            VStack(alignment: .leading, spacing: 0, content: {
                
                Text(task.taskTitle)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                Spacer()
                Label(task.creationDate.format("hh:mm a"), systemImage: "clock" )
                    .font(.caption)
                    .foregroundStyle(.secondary)
            })
            .padding(15)
            .hSpacing(.leading)
            .background(task.tint, in: .rect(topLeadingRadius: 10, bottomLeadingRadius: 10))
            .strikethrough(task.isCompleted, pattern: .solid, color: .black)
            .offset(y: -0)

        }
        
    }
    var indicatorColor: Color {
        if task.isCompleted {
            return .green
        }
        return task.creationDate.isSameHour ? .brandPrimary : (task.creationDate.isPast ? .red : .black)
    }
        
}

#Preview {
    ContentView()
}
