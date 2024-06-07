//
//  SearchView.swift
//  TicketsApp
//
//  Created by Сергей Мирошниченко on 03.06.2024.
//

import SwiftUI

struct SearchView: View {
    @StateObject var viewModel: SearchViewModel
    @Binding var fromCity: String
    @Binding var targetCity: String
    @State var isPresented: Bool = false
    @Binding var isFilter: Bool
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            GeometryReader { reader in
                VStack {
                    Divider()
                        .frame(width: 38, height: 8)
                        .overlay(Color(red: 94 / 255, green: 95 / 255, blue: 97 / 255))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.top, 10)
                    HStack {
                        Spacer()
                        searchTextFieldView(reader: reader)
                            .frame(width: reader.size.width * 0.95, height: 122)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .padding(.bottom, 20)
                        
                        Spacer()
                    }
                    HStack(spacing: reader.size.width / 14) {
                        Button(action: {}) {
                            NavigationLink(destination: OtherView()) {
                                VStack {
                                    Image("RootIcon")
                                        .frame(width: 48, height: 48)
                                        .background(Color(red: 58 / 255, green: 99 / 255, blue: 59 / 255))
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                    Text("Сложный\nмаршрут")
                                        .font(.system(size: 14))
                                        .foregroundStyle(.white)
                                }
                                .frame(height: 90)
                            }
                        }
                        Button(action: {
                            targetCity = "Куда угодно"
                            isFilter = true
                            presentationMode.wrappedValue.dismiss()
                            
                        }) {
                            
                            VStack {
                                Image("GlobeIcon")
                                    .frame(width: 48, height: 48)
                                    .background(Color(red: 34 / 255, green: 97 / 255, blue: 188 / 255))
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                Text("Куда угодно")
                                    .font(.system(size: 14))
                                    .foregroundStyle(.white)
                                Spacer()
                            }
                            .frame(height: 90)
                            
                        }
                        Button(action: {}) {
                            NavigationLink(destination: OtherView()) {
                                VStack {
                                    Image("CalendarIcon")
                                        .frame(width: 48, height: 48)
                                        .background(Color(red: 0 / 255, green: 66 / 255, blue: 125 / 255))
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                    Text("Выходные")
                                        .font(.system(size: 14))
                                        .foregroundStyle(.white)
                                    Spacer()
                                }
                                .frame(height: 90)
                            }
                        }
                        Button(action: {}) {
                            NavigationLink(destination: OtherView()) {
                                VStack {
                                    Image("FireIcon")
                                        .frame(width: 48, height: 48)
                                        .background(Color(red: 255 / 255, green: 94 / 255, blue: 94 / 255))
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                    Text("Горячие\nбилеты")
                                        .font(.system(size: 14))
                                        .foregroundStyle(.white)
                                }
                                .frame(height: 90)
                            }
                        }
                    }
                    
                    recomendationView(reader: reader)
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(red: 36 / 255, green: 37 / 255, blue: 41 / 255))
                .onDisappear(perform: {
                    DataManager.shared.saveToCache(fromCity)
                })
            }
        }
    }
    
    @ViewBuilder
    func recomendationView(reader: GeometryProxy) -> some View {
        VStack {
            ForEach(viewModel.recomendations) { recomendation in
                Button(action: {
                    targetCity = recomendation.city
                    isFilter = true
                    presentationMode.wrappedValue.dismiss()
                })
                {
                    HStack {
                        Image(recomendation.photo)
                            .resizable()
                            .frame(width: 40, height: 40)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .padding(.leading, 10)
                        
                        VStack(alignment: .leading) {
                            Text(recomendation.city)
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundStyle(.white)
                            
                            Text(recomendation.subtitle)
                                .font(.system(size: 14))
                                .foregroundStyle(Color(red: 94 / 255, green: 95 / 255, blue: 97 / 255))
                        }
                        Spacer()
                        
                    }
                }
                .padding(.top, recomendation.id == 1 ? 15 : 0)
                    .frame(height: 60)
                    Divider()
                        .overlay(Color(red: 94 / 255, green: 95 / 255, blue: 97 / 255))
                        .frame(width: reader.size.width * 0.85)
                        .padding(.top, 4)
                        .padding(.bottom, recomendation.id == 3 ? 10 : 0)
            }
            
        }
        .frame(width: reader.size.width * 0.95)
        .background(Color(red: 47 / 255, green: 48 / 255, blue: 53 / 255))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        
    }
    
    @ViewBuilder
    func searchTextFieldView(reader: GeometryProxy) -> some View {
            VStack {
                HStack {
                    Spacer()
                    Image("PlaneIcon")
                    Spacer()
                    CyrillicTextField(text: $fromCity, placeholder: "Откуда - Москва")
                }
                
                Divider()
                    .overlay(Color(red: 62 / 255, green: 63 / 255, blue: 67 / 255))
                    .frame(width: reader.size.width * 0.85)
                HStack {
                    Spacer()
                    Image("SearchIcon")
                    Spacer()
                    CyrillicTextField(text: $targetCity, placeholder: "Куда - Турция")
                    .onSubmit {
                        isFilter = true
                        presentationMode.wrappedValue.dismiss()
                        
                    }
                    .foregroundStyle(.white)
                    .font(.system(size: 16, weight: .semibold))
                    
                    Spacer()
                    
                    Button(action: {
                        targetCity = ""
                    }) {
                        Image("CloseIcon")
                    }
                    .padding(.trailing, 10)
                }
            }.frame(width: reader.size.width * 0.95, height: 96)
            .background(Color(red: 47 / 255, green: 48 / 255, blue: 53 / 255))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(radius: 8)
    }
}
