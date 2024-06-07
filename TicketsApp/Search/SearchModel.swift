//
//  SearchModel.swift
//  TicketsApp
//
//  Created by Сергей Мирошниченко on 03.06.2024.
//

import Foundation

struct Recomendation: Identifiable {
    var id: Int
    var photo: String
    var city: String
    var subtitle: String
}

struct Tickets: Decodable {
    var tickets_offers: [Ticket]
    
}

struct Ticket: Decodable, Identifiable {
    var id: Int
    var title: String
    var time_range: [String]
    var price: Price
    
    struct Price: Decodable {
        var value: Int
    }
    
    func timeRangeOneString() -> String {
        var result = ""
        for time in time_range {
            result += "\(time) "
        }
        return result
    }
    
    func formattedPrice() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: price.value)) ?? "\(price.value)"
    }
}
