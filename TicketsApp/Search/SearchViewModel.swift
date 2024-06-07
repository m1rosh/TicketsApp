//
//  SearchViewModel.swift
//  TicketsApp
//
//  Created by Сергей Мирошниченко on 03.06.2024.
//

import Combine
import SwiftUI

class SearchViewModel: ObservableObject {
    var loadTickets: Bool
    @Published var tickets: [Ticket] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    var recomendations: [Recomendation] = [
        Recomendation(id: 1, photo: "IstanbulImage", city: "Стамбул", subtitle: "Популярное направление"),
        Recomendation(id: 2, photo: "SochiImage", city: "Сочи", subtitle: "Популярное направление"),
        Recomendation(id: 3, photo: "PhuketImage", city: "Пхукет", subtitle: "Популярное направление")
        ]
    
    var idColorMatch: [Int: Color] = [
        1: Color(red: 255 / 255, green: 94 / 255, blue: 94 / 255),
        10: Color(red: 34 / 255, green: 97 / 255, blue: 188 / 255),
        30: Color(red: 255 / 255, green: 255 / 255, blue: 255 / 255)
    ]
    
    init(loadTickets: Bool = false) {
            self.loadTickets = loadTickets
        
        if loadTickets {
            getTickets()
        }
    }
    
    func getTickets() {
        let ticketsPath = "https://run.mocky.io/v3/7e55bf02-89ff-4847-9eb7-7d83ef884017"
        guard let url = URL(string: ticketsPath)
        else {
            return
        }
        
        DataManager.shared.fetchData(from: url, decodeTo: Tickets.self)
            .map { $0.tickets_offers }
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error fetching tickets: \(error)")
                }
            }, receiveValue: { [weak self] tickets in
                self?.tickets = tickets
            })
            .store(in: &cancellables)
    }
}
