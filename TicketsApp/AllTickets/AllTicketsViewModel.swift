//
//  AllTicketsViewModel.swift
//  TicketsApp
//
//  Created by Сергей Мирошниченко on 04.06.2024.
//

import SwiftUI
import Combine

class AllTicketsViewModel: ObservableObject {
    @Published var allTickets: [OneTicket] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        getAllTickets()
    }
    
    func getAllTickets() {
        let tickets_url = "https://run.mocky.io/v3/670c3d56-7f03-4237-9e34-d437a9e56ebf"
        guard let url = URL(string: tickets_url) else {
            return
        }
        DataManager.shared.fetchData(from: url, decodeTo: AviaTickets.self)
            .map { $0.tickets }
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error fetching avia_tickets: \(error)")
                }
            }, receiveValue: { [weak self] tickets in
                self?.allTickets = tickets
            })
            .store(in: &cancellables)
    }
}

