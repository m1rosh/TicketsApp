//
//  CalendarView.swift
//  TicketsApp
//
//  Created by Сергей Мирошниченко on 04.06.2024.
//

import SwiftUI

struct CalendarView: View {
    
    let dateRange: ClosedRange<Date>? = {
        let calendar = Calendar.current
        let today = Date()
        
        let startComponents = calendar.dateComponents([.year, .month, .day], from: today)
        
        if let startDate = calendar.date(from: startComponents), 
            let endDate = calendar.date(byAdding: .year, value: 1, to: startDate) {
                return startDate...endDate
        }
        
        return nil
        }()
    
    @Binding var date: Date
    @Binding var dateSetted: Bool
   
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            if let dateRange {
                DatePicker("Jump to", selection: $date, in: dateRange, displayedComponents: [.date])
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .colorInvert()
            }
            
            Button(action: {
                dateSetted = true
                presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                    Text("OK")
                        .font(.custom("SFProDisplay-Semibold", size: 16))
                        .foregroundStyle(.white)
                    
                }.frame(width: 100, height: 42)
            }.buttonStyle(.borderedProminent)
                .clipShape(.rect(cornerRadius: 8))
                .tint(.green)
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.black)
    }
}
