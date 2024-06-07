//
//  HotelsView.swift
//  TicketsApp
//
//  Created by Сергей Мирошниченко on 03.06.2024.
//

import SwiftUI

struct HotelsView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Отели")
                    .foregroundStyle(.white)
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.black)
        }
    }
}
