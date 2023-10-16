//
//  View+extensions.swift
//  Task Management App
//
//  Created by Olivier Guillemot on 16/10/2023.
//

import SwiftUI


//Custom view extensions

extension View {
    
    @ViewBuilder
    func hSpacing(_ alignement: Alignment) -> some View {
        self
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: alignement)
    }
    
    func vSpacing(_ alignement: Alignment) -> some View {
        self
            .frame(maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: alignement)
    }
    
    func isSameDate(_ date1: Date, _ date2: Date) -> Bool {
        return Calendar.current.isDate(date1, inSameDayAs: date2)
    }
}
