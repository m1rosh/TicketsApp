//
//  AviaTicketsView.swift
//  TicketsApp
//
//  Created by Сергей Мирошниченко on 03.06.2024.
//

import SwiftUI

struct AviaTicketsView: View {
    @StateObject var viewModel: AviaTicketsViewModel
    @State var fromCity = DataManager.shared.loadFromCache()
    @State var targetCity = ""
    @State var isPresented = false
    @State var isFilter = false
    var body: some View {
        GeometryReader { reader in
            if isFilter {
                SearchFullScreenView(viewModel: SearchViewModel(loadTickets: true), fromCity: $fromCity, targetCity: $targetCity, isFilter: $isFilter)
            }
            else {
                VStack {
                    Text("Поиск дешевых\nавиабилетов")
                        .foregroundStyle(.white)
                        .font(.system(size: 22, weight: .semibold))
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 20)
                    
                    searchView(reader: reader, disabled: true)
                        .frame(width: reader.size.width * 0.95, height: 122)
                        .background(Color(red: 47 / 255, green: 48 / 255, blue: 54 / 255))
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .padding(.bottom, 20)
                    HStack {
                        Text("Музыкално отлететь")
                            .foregroundStyle(.white)
                            .font(.system(size: 22, weight: .semibold))
                            .padding(.leading, 10)
                        Spacer()
                    }
                    ScrollView(.horizontal) {
                        HStack(spacing: 20) {
                            ForEach(viewModel.offers) { offer in
                                oneOfferView(offer: offer)
                            }
                        }
                    }
                    Spacer()
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.black)
            }
        }
    }
    
    @ViewBuilder
    func oneOfferView(offer: OneOffer) -> some View {
        VStack {
            Image(viewModel.images[offer.id] ?? "FirstImageOffer")
                .resizable()
                .frame(width: 132, height: 132)
                .clipShape(RoundedRectangle(cornerRadius: 16))
            
            HStack {
                Text(offer.title)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.white)
                Spacer()
            }
            
            HStack {
                Text(offer.town)
                    .font(.system(size: 14))
                    .foregroundStyle(.white)
                Spacer()
            }
    
            HStack(spacing: 2) {
                Image("AviaTicketsTabIcon")
                Text("от \(offer.formattedPrice()) ₽")
                    .font(.system(size: 14))
                    .foregroundStyle(.white)
                Spacer()
            }
        }
    }
    
    @ViewBuilder
    func searchView(reader: GeometryProxy, disabled: Bool) -> some View {
        HStack {
            Spacer()
            Image("SearchIcon")
            Spacer()
            
            VStack {
                HStack {
                    CyrillicTextField(text: $fromCity, placeholder: "Откуда - Москва")
                    Spacer()
                }
                
                Divider()
                    .overlay(Color(red: 159 / 255, green: 159 / 255, blue: 159 / 255, opacity: 0.62))
                
                HStack {
                    Text(targetCity.count == 0 ? "Куда - Турция" : targetCity)
                        .foregroundStyle(
                            targetCity.count == 0 ? Color(red: 159 / 255, green: 159 / 255, blue: 159 / 255) : .white
                            )
                        .font(.system(size: 16, weight: .semibold))
                        .padding(.top, 4)
                        
                    Spacer()
                }
                .sheet(isPresented: $isPresented, content: {
                    SearchView(viewModel: SearchViewModel(), fromCity: $fromCity, targetCity: $targetCity, isFilter: $isFilter)
                        
                })
                .onTapGesture {
                    isPresented = true
                    DataManager.shared.saveToCache(fromCity)
                    
                }
            }
            
        }.frame(width: reader.size.width * 0.85, height: 90)
            .background(Color(red: 62 / 255, green: 63 / 255, blue: 67 / 255))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(radius: 16)
        
    }
}



