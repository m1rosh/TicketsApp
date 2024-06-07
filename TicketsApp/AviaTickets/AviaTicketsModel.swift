//
//  AviaTicketsModel.swift
//  TicketsApp
//
//  Created by Сергей Мирошниченко on 03.06.2024.
//

import Foundation
import Combine

struct OneOffer: Decodable, Identifiable {
    var id: Int
    var title: String
    var town: String
    var price: Price
    struct Price: Decodable {
        let value: Int
    }
    func formattedPrice() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: price.value)) ?? "\(price.value)"
    }
}

struct Offers: Decodable {
    var offers: [OneOffer]
}


