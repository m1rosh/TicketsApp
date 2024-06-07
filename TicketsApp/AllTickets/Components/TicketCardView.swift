//
//  TicketCardView.swift
//  TicketsApp
//
//  Created by Сергей Мирошниченко on 04.06.2024.
//

import SwiftUI

struct TicketCardView: View {
    let ticket: OneTicket
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(ticket.formattedPrice()) ₽")
                .font(.system(size: 22, weight: .semibold))
                .foregroundStyle(.white)
                .padding(.leading, 20)
            
            HStack(alignment: .center) {
                Circle()
                    .frame(width: 24, height: 24)
                    .foregroundStyle(Color(red: 255 / 255, green: 94 / 255, blue: 94 / 255))
                    .padding(.leading, 20)
                
                VStack(alignment: .leading) {
                    HStack(alignment: .firstTextBaseline) {
                        VStack(alignment: .leading) {
                            Text("\(ticket.extractTime(from: ticket.departure.date))")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundStyle(.white)
                                .italic()
                            Text(ticket.departure.airport)
                                .font(.system(size: 14))
                                .foregroundStyle(Color(red: 159 / 255, green: 159 / 255, blue: 159 / 255))
                        }
                        
                        Text("—")
                            .foregroundStyle(Color(red: 159 / 255, green: 159 / 255, blue: 159 / 255))
                        
                        VStack(alignment: .leading) {
                            Text("\(ticket.extractTime(from: ticket.arrival.date))")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundStyle(.white)
                                .italic()
                            Text(ticket.arrival.airport)
                                .font(.system(size: 14))
                                .foregroundStyle(Color(red: 159 / 255, green: 159 / 255, blue: 159 / 255))
                        }
                        HStack(spacing: 0) {
                            if let duration = ticket.getFlightDuration() {
                                Text(" \(duration) в пути ")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 14))
                            }
                            
                            if ticket.has_transfer {
                                Text("/ Без пересадок")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 14))
                            }
                        }
                    }
                }
                Spacer()
            }
        }.frame(height: 120)
        .background(Color(red: 29 / 255, green: 30 / 255, blue: 32 / 255))
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .overlay(
            Group {
                if let badge = ticket.badge {
                    Text(badge)
                        .font(.system(size: 14))
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color(red: 34 / 255, green: 97 / 255, blue: 188 / 255))
                        .foregroundColor(.white)
                        .cornerRadius(16)
                        .padding(.top, -10)
                }
            },
        alignment: .topLeading
        )
        
    }
    
}
