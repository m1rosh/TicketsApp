//
//  ProfileView.swift
//  TicketsApp
//
//  Created by Сергей Мирошниченко on 03.06.2024.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Профиль")
                    .foregroundStyle(.white)
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.black)
        }
    }
}
