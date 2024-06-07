//
//  AllTicketsView.swift
//  TicketsApp
//
//  Created by Сергей Мирошниченко on 04.06.2024.
//

import SwiftUI

struct AllTicketsView: View {
    @StateObject var viewModel: AllTicketsViewModel
    
    @Binding var departureDate: Date
    @Binding var fromCity: String
    @Binding var targetCity: String
    
    @Environment (\.presentationMode) var presentationMode
    
    func getFullMonthDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.locale = Locale(identifier: "ru_RU")
        
        dateFormatter.dateFormat = "dd LLLL"
        let dayNumAndMonth = dateFormatter.string(from: date)
        
        return dayNumAndMonth
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { reader in
                ZStack(alignment: .bottom) {
                    VStack {
                        Spacer()
                        
                        HStack {
                            Spacer()
                            depatureDestView()
                                .frame(width: reader.size.width * 0.95, height: 56)
                            Spacer()
                            
                        }.padding(.bottom, 20)
                        
                        ScrollView {
                            ForEach(viewModel.allTickets) { ticket in
                                TicketCardView(ticket: ticket)
                                    .padding(.top, ticket.badge == nil ? 10 : 20)
                            }
                            Rectangle()
                                .foregroundStyle(.black)
                                .frame(height: 60)
                            
                        }.frame(width: reader.size.width * 0.95)
                            .scrollIndicators(.hidden)
                        
                    }
                    
                    Button(action: {}) {
                        HStack {
                            Image("FilterIcon")
                                .imageScale(.large)
                                .foregroundColor(.white)
                                .frame(height: 37)
                            Text("Фильтр")
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundStyle(.white)
                            
                            Spacer()
                            
                            Image("GraphicIcon")
                                .imageScale(.large)
                                .foregroundColor(.white)
                            Text("График цен")
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundStyle(.white)
                        }
                    }.buttonStyle(.borderedProminent)
                        .clipShape(RoundedRectangle(cornerRadius: 50))
                        .tint(Color(red: 34 / 255, green: 97 / 255, blue: 188 / 255))
                        .padding()
                        .frame(width: reader.size.width * 0.7)
                }
                
            }.background(.black)
            
        }.navigationBarBackButtonHidden(true)
    }
    
    @ViewBuilder
    func depatureDestView() -> some View{
        HStack {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image("ArrowBlueIcon")
            }
            
            VStack(alignment: .leading) {
                Text("\(fromCity)-\(targetCity)")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.white)
                    .padding(.top, 8)
                Spacer()
                Text("\(getFullMonthDate(departureDate)), 1 пассажир")
                    .foregroundStyle(Color(red: 159 / 255, green: 159 / 255, blue: 159 / 255))
                    .font(.system(size: 14))
                    .padding(.bottom, 8)
            }
            Spacer()
        }
        .background(Color(red: 36 / 255, green: 37 / 255, blue: 41 / 255))
            
    }
}
