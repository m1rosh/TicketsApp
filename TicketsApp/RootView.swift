//
//  ContentView.swift
//  TicketsApp
//
//  Created by Сергей Мирошниченко on 03.06.2024.
//

import SwiftUI

struct RootView: View {
    
    var body: some View {
        TabView {
            AviaTicketsView(viewModel: AviaTicketsViewModel())
                .tabItem {
                    Image("AviaTicketsTabIcon")
                        .renderingMode(.template)
                        .foregroundStyle(.blue)
                    Text("Авиабилеты")
                }
            
            HotelsView()
                .tabItem {
                    Image("HotelsTabIcon")
                        .renderingMode(.template)
                        .foregroundStyle(.blue)
                    Text("Отели")
                }
            
            OtherView()
                .tabItem {
                    Image("OtherTabIcon")
                        .renderingMode(.template)
                        .foregroundStyle(.blue)
                    Text("Короче")
                }
            
            SubscriptionsView()
                .tabItem {
                    Image("SubsTabIcon")
                        .renderingMode(.template)
                        .foregroundStyle(.blue)
                    Text("Подписки")
                }
            
            ProfileView()
                .tabItem {
                    Image("ProfileTabIcon")
                        .renderingMode(.template)
                        .foregroundStyle(.blue)
                    Text("Профиль")
                }
        }
    }
}
