//
//  Home.swift
//  Task Management App
//
//  Created by Olivier Guillemot on 16/10/2023.
//

import SwiftUI

struct Home: View {
    
    
    @State private var currentDate: Date = .init()
    @State private var weekSlider: [[Date.WeekDay]] = []
    @State private var currentWeekIndex: Int = 0
    @State private var createWeek: Bool = false
    @State private var tasks: [Task] = sampleTasks.sorted(by: {$1.creationDate > $0.creationDate})
    @State private var createNewTask: Bool = false
    
    //Animation Namespace
    @Namespace private var animation
    
    var body: some View {
        VStack( alignment: .leading, spacing: 0, content: {
            headerView()
            ScrollView(.vertical){
                VStack{
                    //TasksView
                    tasksView()
                }
                .hSpacing(.center)
                .vSpacing(.center)
                
                }
            .scrollIndicators(.hidden)
        })
        .vSpacing(.top)
        .overlay(alignment: .bottomTrailing, content: {
            Button(action: {
                createNewTask.toggle()
            }, label: {
               Image(systemName: "plus")
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(width: 55, height: 55)
                    .background(.brandPrimary.shadow(.drop(color:.black.opacity(0.25), radius: 5, x:10, y:10)), in:.circle)
            })
            .padding(15)
        })
        .onAppear(perform: {
            if weekSlider.isEmpty {
                let currentWeek = Date().fetchWeek()
                
                if let firstDate = currentWeek.first?.date{
                    weekSlider.append(firstDate.createPreviousWeek())
                }
                weekSlider.append(currentWeek)
                
                if let lastDate = currentWeek.last?.date{
                    weekSlider.append(lastDate.createNextWeek())
                }
            }
        })
        .sheet(isPresented: $createNewTask, content: {
            NewTaskView()
                .presentationDetents([.height(300)])
                .interactiveDismissDisabled()
                .presentationCornerRadius(30)
                .presentationBackground(.background)
            
            
        })
    }
    
    
    @ViewBuilder
    func headerView() -> some View {
        VStack( alignment: .leading, spacing: 6) {
            
            HStack(spacing: 5) {
                Text(currentDate.format("MMMM")).foregroundStyle(.brandPrimary)
                Text(currentDate.format("YYYY")).foregroundStyle(.secondary)
            }
            .font(.title.bold())
            
            Text(currentDate.formatted(date: .complete, time: .omitted))
                .font(.callout)
                .fontWeight(.semibold)
                .textScale(.secondary)
                .foregroundStyle(.secondary)
            
            
            //WeekSlider ================================================
            
            TabView(selection: $currentWeekIndex) {
                
                ForEach(weekSlider.indices,id:\.self){ index in
                    let week = weekSlider[index]
                    WeekView(week)
                        .padding(.horizontal, 15)
                        .tag(index)
                }
            }
            .padding(.horizontal, -10)
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(height:90)
        }
        .hSpacing(.leading)
        .overlay( alignment: .topTrailing, content: {
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Image(.avatar)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60 )
                    .clipShape(.circle)
            })
        })
        .padding(15)
        .background(.background)
        .onChange(of: currentWeekIndex, initial: false){oldValue, newValue in
            //Creating when it reaches first/Last PAge
            if newValue == 0 || newValue == (weekSlider.count - 1) {
                createWeek = true
            }
            
            
        }
    }
    
    @ViewBuilder
    func WeekView(_ week: [Date.WeekDay]) -> some View {
        HStack(spacing: 0) {
            
            ForEach(week) { day in
                VStack (spacing: 8) {
                    
                    Text(day.date.format("E"))
                        .font(.callout)
                        .fontWeight(.bold)
                        .textScale(.secondary)
                        .foregroundStyle(.secondary)
                    
                    Text(day.date.format("dd"))
                        .font(.callout)
                        .fontWeight(.bold)
                        .textScale(.secondary)
                        .foregroundStyle(isSameDate(day.date, currentDate) ? .white: .secondary)
                        .frame(width:40, height: 40)
                        .background(content: {
                            if isSameDate(day.date, currentDate){
                                Circle().fill(.brandPrimary)
                                    .matchedGeometryEffect(id: "TABINDICATOR", in: animation)
                                
                            }
                            
                            // indicator to show which is today
                            if day.date.isToday {
                                Circle()
                                    .fill(.brandPrimary)
                                    .frame(width:5, height:5)
                                    .vSpacing(.bottom)
                                    .offset(y:12)
                            }
                            
                        })
                        .background(.background.shadow(.drop( radius: 1 )), in: .circle)
                    
                    
                }
                .hSpacing(.center)
                .contentShape(.rect)
                .onTapGesture {
                    // updating current data
                    
                    withAnimation(.snappy){
                        currentDate = day.date
                    }
                }
            }
        }
        .background(){
            GeometryReader{
                let minX = $0.frame(in: .global).minX
                Color.clear
                    .preference(key: OffsetKey.self, value: minX)
                    .onPreferenceChange(OffsetKey.self){ value in
                        //when the Offset reaches 15 and if the createWeek is toggled then simply generatin next set of week
//                        print(createWeek)
                        if value.rounded() == 15 && createWeek{
                            paginateWeek()
                            createWeek = false
                        }
                    }
            }
        }
    }
    
    @ViewBuilder
    func tasksView() -> some View {
        VStack(alignment: .leading, spacing: 35) {
            ForEach($tasks) {$task in
                TaskListItemView(task: $task)
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
    }
    
    func paginateWeek() {
        
        if weekSlider.indices.contains(currentWeekIndex) {
            
            if let firstDate = weekSlider[currentWeekIndex].first?.date, currentWeekIndex == 0 {
                //Inserting new week at 0th index and removing last array item
                weekSlider.insert(firstDate.createPreviousWeek(), at: 0)
                weekSlider.removeLast()
                currentWeekIndex = 1
//                print(firstDate)
            }
            
            
            if let lastDate = weekSlider[currentWeekIndex].last?.date, currentWeekIndex == (weekSlider.count - 1) {
                //Appending new week at last index and removing first array item
                weekSlider.append(lastDate.createNextWeek())
                weekSlider.removeFirst()
                currentWeekIndex = weekSlider.count - 2
            }
        }
        
        print(weekSlider.count)
    }
}

#Preview {
    ContentView()
}
