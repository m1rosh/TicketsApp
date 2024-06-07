//
//  TicketsAppApp.swift
//  TicketsApp
//
//  Created by Сергей Мирошниченко on 03.06.2024.
//

import SwiftUI

@main
struct TicketsAppApp: App {
    init() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = .black
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        
        UITabBar.appearance().barTintColor = .black
        
        UITabBar.appearance().tintColor = UIColor.systemBlue
        
        UITabBar.appearance().unselectedItemTintColor = UIColor.gray
        
        UITabBar.appearance().standardAppearance = tabBarAppearance
    }
    
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}
