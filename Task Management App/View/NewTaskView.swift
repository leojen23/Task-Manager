//
//  NewTaskView.swift
//  Task Management App
//
//  Created by Olivier Guillemot on 16/10/2023.
//

import SwiftUI

struct NewTaskView: View {
    
    @Environment(\.dismiss) private var dismiss
    @State private var taskTitle: String = ""
    @State private var taskDate: Date = .init()
    @State private var taskColor: Color = .taskColor1
    
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 15, content: {
           
            Button(action: {
                dismiss()
            },label:{
                Image(systemName: "xmark.circle.fill")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .tint(.red)
            })
            .hSpacing(.leading)
            
            VStack(alignment: .leading, spacing: 8, content: {
                Text("Task Title")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                
                TextField("Go for a walk", text: $taskTitle)
                    .padding(.vertical, 12)
                    .padding(.horizontal,15)
                    .background(.white.shadow(.drop(color: .black.opacity(0.25), radius: 2)),in: .rect(cornerRadius: 10))
                    
               
            })
            .padding(.top, 5)
            
            HStack(spacing: 12) {
                VStack(alignment: .leading, spacing: 8, content: {
                    Text("Task Date")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    DatePicker("", selection: $taskDate)
                        .datePickerStyle(.compact)
                        .scaleEffect(0.9, anchor: .leading)
                })
                .padding(.top, 5)
                .padding(.trailing, -15)
                
                VStack(alignment: .leading, spacing: 8, content: {
                    Text("Task Color")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    
                    let colors: [Color] = [.taskColor1, .taskColor2, .taskColor3, .taskColor4, .taskColor5 ]
                        
                    HStack(spacing: 0){
                        ForEach(colors, id:\.self ){color in
                            Circle()
                                .fill(color)
                                .frame(width: 20, height: 20)
                                .background(content: {
                                    Circle()
                                        .stroke(lineWidth: 2)
                                        .opacity(taskColor == color ? 1 : 0)
                                })
                                .hSpacing(.center)
                                .contentShape(.rect)
                                .onTapGesture(perform: {
                                    withAnimation(.snappy) {
                                        taskColor = color
                                    }
                                })
                        }
                    }
                })
                .padding(.top, 5)
                
            
                
                
            }
            Spacer(minLength: 0)
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Text("Create Task")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .textScale(.secondary)
                    .foregroundStyle(.black)
                    .hSpacing(.center)
                    .padding(.vertical,12)
                    .background(taskColor, in: .rect(cornerRadius: 10))
            })
        })
        .padding(15)
        
    }
}

#Preview {
    NewTaskView()
        .vSpacing(.bottom)
    
        
    }
