//
//  CyrillicFiled.swift
//  TicketsApp
//
//  Created by Сергей Мирошниченко on 04.06.2024.
//

import SwiftUI

struct CyrillicTextField: View {
    @Binding var text: String
    var placeholder: String
    
    var body: some View {
        TextField(text: $text) {
            Text(placeholder)
                .foregroundStyle(Color(red: 159 / 255, green: 159 / 255, blue: 159 / 255))
                .font(.system(size: 16, weight: .semibold))
        }
        .onChange(of: text) {
            let filteredText = text.filter { char in
                char.isCyrillic
            }
            if filteredText != text {
                self.text = filteredText
            }
        }
        .foregroundStyle(.white)
        .font(.system(size: 16, weight: .semibold))
    }
}

extension Character {
    var isCyrillic: Bool {
            return !(("a"..."z").contains(self) || ("A"..."Z").contains(self))
        }
}
