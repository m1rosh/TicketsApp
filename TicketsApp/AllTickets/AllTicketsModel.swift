//
//  AllTicketsModel.swift
//  TicketsApp
//
//  Created by Сергей Мирошниченко on 04.06.2024.
//

import Foundation

struct AviaTickets: Decodable {
    var tickets: [OneTicket]
}

struct OneTicket: Decodable, Identifiable {
    var id: Int
    var badge: String?
    var price: Price
    var departure: Depature
    var arrival: Depature
    var has_transfer: Bool
    
    struct Price: Decodable {
        var value: Int
    }
    
    struct Depature: Decodable {
        var town: String
        var date: String
        var airport: String
    }
    
    func formattedPrice() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: price.value)) ?? "\(price.value)"
    }
    
    func extractTime(from time: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        inputFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "HH:mm"
        outputFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        if let date = inputFormatter.date(from: time) {
            return outputFormatter.string(from: date)
        } else {
            return "00:00"
        }
    }
    
    func getFlightDuration() -> String? {
        let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
        guard let departureDate = formatter.date(from: extractTime(from: departure.date)),
        let arrivalDate = formatter.date(from: extractTime(from: arrival.date)) else {
                return nil
            }

            var duration: TimeInterval

            if arrivalDate >= departureDate {
                duration = arrivalDate.timeIntervalSince(departureDate)
            } else {
                duration = arrivalDate.timeIntervalSince(departureDate) + 24 * 60 * 60
            }
            let hours = Double(duration) / 3600
        
        return(String(format: "%.1f%ч", hours))
    }
    
}
