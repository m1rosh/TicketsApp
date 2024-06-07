//
//  SearchFullScreenView.swift
//  TicketsApp
//
//  Created by Сергей Мирошниченко on 04.06.2024.
//

import SwiftUI

struct SearchFullScreenView: View {
    @StateObject var viewModel: SearchViewModel
    
    @State var backDate: Date = .now
    @State var departureDate: Date = .now
    
    @State var backDateSetted = false
    @State var departureDateSetted = false
    @State var isSubscribed = false
    
    @Binding var fromCity: String
    @Binding var targetCity: String
    @Binding var isFilter: Bool
    
    @Environment(\.presentationMode) var presentationMode
    
    func getFormattedTime(_ date: Date) -> (String, String) {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.locale = Locale(identifier: "ru_RU")
        
        dateFormatter.dateFormat = "dd LLL,"
        let dayNumAndMonth = dateFormatter.string(from: date)
        
        dateFormatter.dateFormat = "EEE"
        let weekDay = dateFormatter.string(from: date)
        
        return (dayNumAndMonth, weekDay)
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { reader in
                VStack {
                    HStack {
                        Spacer()
                        searchTextFieldView(reader: reader)
                            .frame(width: reader.size.width * 0.95, height: 100)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                        
                        Spacer()
                    }
                    filterButtonView()
                        .frame(width: reader.size.width * 0.95)
                    
                    flightListView(reader: reader)
                        .padding(.bottom, 20)
                    Button(action: {}) {
                        NavigationLink(destination: AllTicketsView(viewModel: AllTicketsViewModel(), departureDate: $departureDate, fromCity: $fromCity, targetCity: $targetCity)) {
                            HStack {
                                Text("Посмотреть все билеты")
                                    .font(.system(size: 16))
                                    .foregroundStyle(.white)
                                    .italic()
                            }.frame(width: reader.size.width * 0.9, height: 42)
                        }
                    }.buttonStyle(.borderedProminent)
                        .clipShape(.rect(cornerRadius: 8))
                        .tint(Color(red: 34 / 255, green: 97 / 255, blue: 188 / 255))
                }
                
            }.background(.black)
        }
            
    }
    
    @ViewBuilder
    func flightListView(reader: GeometryProxy) -> some View {
        VStack {
            HStack {
                Text("Прямые рейсы")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(.white)
                    .padding(.leading, 20)
                    .padding(.top, 20)
                Spacer()
            }
            ForEach(viewModel.tickets) { ticket in
                Button(action: {})
                {
                    HStack(alignment: .top) {
                        if let color = viewModel.idColorMatch[ticket.id] {
                            Circle()
                                .frame(width: 24, height: 24)
                                .foregroundStyle(color)
                                .padding(.leading, 20)
                        }
                        
                        VStack(alignment: .leading) {
                            HStack {
                                Text(ticket.title)
                                    .font(.system(size: 16))
                                    .foregroundStyle(.white)
                                    .italic()
                                Spacer()
                                Text("\(ticket.formattedPrice()) ₽")
                                    .font(.system(size: 14))
                                    .foregroundStyle(Color(red: 34 / 255, green: 97 / 255, blue: 188 / 255))
                                Image("ArrowLeftIcon")
                                
                            }
                            
                            Text(ticket.timeRangeOneString())
                                .font(.system(size: 14))
                                .foregroundStyle(.white)
                        }
                        Spacer()
                        
                    }
                }
                .padding(.top, ticket.id == 1 ? 15 : 0)
                    .frame(height: 60)
                    Divider()
                        .overlay(Color(red: 94 / 255, green: 95 / 255, blue: 97 / 255))
                        .frame(width: reader.size.width * 0.85)
                        .padding(.top, 4)
                        .padding(.bottom, ticket.id == 3 ? 10 : 0)
            }
            
        }
        .frame(width: reader.size.width * 0.95)
        .background(Color(red: 29 / 255, green: 30 / 255, blue: 32 / 255))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
    
    @ViewBuilder
    func filterButtonView() -> some View {
        ScrollView(.horizontal) {
            HStack(spacing: 10) {
                Button(action: {}) {
                    NavigationLink(destination: CalendarView(date: $backDate, dateSetted: $backDateSetted)) {
                        HStack {
                            if backDateSetted {
                                Text(getFormattedTime(backDate).0)
                                    .font(.system(size: 14))
                                    .foregroundStyle(.white)
                                Text(getFormattedTime(backDate).1)
                                    .font(.system(size: 14))
                                    .foregroundStyle(Color(red: 159 / 255, green: 159 / 255, blue: 159 / 255))
                            }
                            else {
                                Image("PlusIcon")
                                Text("обратно")
                                    .font(.system(size: 14))
                                    .foregroundStyle(.white)
                                    .italic()
                            }
                        }
                    }
                }.buttonStyle(.borderedProminent)
                    .clipShape(.rect(cornerRadius: 50))
                    .tint(Color(red: 47 / 255, green: 48 / 255, blue: 53 / 255))
                
                Button(action: {}) {
                    NavigationLink(destination: CalendarView(date: $departureDate, dateSetted: $departureDateSetted)) {
                        HStack {
                            if departureDateSetted {
                                Text(getFormattedTime(departureDate).0)
                                    .font(.system(size: 14))
                                    .foregroundStyle(.white)
                                    .italic()
                                Text(getFormattedTime(departureDate).1)
                                    .font(.system(size: 14))
                                    .italic()
                                    .foregroundStyle(Color(red: 159 / 255, green: 159 / 255, blue: 159 / 255))
                            }
                            else {
                                Text(getFormattedTime(.now).0)
                                    .font(.system(size: 14))
                                    .italic()
                                    .foregroundStyle(.white)
                                Text(getFormattedTime(.now).1)
                                    .font(.system(size: 14))
                                    .italic()
                                    .foregroundStyle(Color(red: 159 / 255, green: 159 / 255, blue: 159 / 255))
                            }
                        }
                    }
                }.buttonStyle(.borderedProminent)
                    .clipShape(.rect(cornerRadius: 50))
                    .tint(Color(red: 47 / 255, green: 48 / 255, blue: 53 / 255))
                
                Button(action: {}) {
                    HStack {
                        Image("PersonIcon")
                        Text("1,эконом")
                            .font(.system(size: 14))
                            .italic()
                            .foregroundStyle(.white)
                    }
                }.buttonStyle(.borderedProminent)
                    .clipShape(.rect(cornerRadius: 50))
                    .tint(Color(red: 47 / 255, green: 48 / 255, blue: 53 / 255))
                Button(action: {}) {
                    HStack {
                        Image("FilterIcon")
                        Text("фильтры")
                            .font(.system(size: 14))
                            .foregroundStyle(.white)
                    }
                }.buttonStyle(.borderedProminent)
                    .clipShape(.rect(cornerRadius: 50))
                    .tint(Color(red: 47 / 255, green: 48 / 255, blue: 53 / 255))
            }
        }.scrollIndicators(.hidden)
    }
    
    @ViewBuilder
    func searchTextFieldView(reader: GeometryProxy) -> some View {
        HStack {
            Button(action: {
                isFilter = false
            }) {
                Image("ArrowIcon")
            }
            .padding(.leading, 10)
            VStack {
                HStack {
                    CyrillicTextField(text: $fromCity, placeholder: "Откуда - Москва")
                    Spacer()
                    
                    Button(action: {
                        (targetCity, fromCity) = (fromCity, targetCity)
                    }) {
                        Image("ChangeCitiesIcon")
                    }
                    .padding(.trailing, 10)
                }
                
                Divider()
                    .overlay(Color(red: 62 / 255, green: 63 / 255, blue: 67 / 255))
                
                HStack {
                    CyrillicTextField(text: $targetCity, placeholder: "Куда - Турция")
                    Spacer()
                    
                    Button(action: {
                        targetCity = ""
                    }) {
                        Image("CloseIcon")
                    }
                    .padding(.trailing, 10)
                }
            }
        }.frame(width: reader.size.width * 0.95, height: 96)
            .background(Color(red: 47 / 255, green: 48 / 255, blue: 53 / 255))
            .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}
