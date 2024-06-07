//
//  AviaTicketsViewModel.swift
//  TicketsApp
//
//  Created by Сергей Мирошниченко on 03.06.2024.
//

import SwiftUI
import Combine

class AviaTicketsViewModel: ObservableObject {
    @Published var offers: [OneOffer] = []
    var images: [Int: String] = [1: "FirstOfferImage", 2: "SecondOfferImage", 3: "ThirdOfferImage"]
    var all_tickets: [OneTicket] = []
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        getOffers()
    }

    func getOffers() {
        let offers_string = "https://run.mocky.io/v3/214a1713-bac0-4853-907c-a1dfc3cd05fd"
        
        guard let url = URL(string: offers_string)
        else {
            return
        }
        DataManager.shared.fetchData(from: url, decodeTo: Offers.self)
            .map { $0.offers }
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error fetching offers: \(error)")
                }
            }, receiveValue: { [weak self] offers in
                self?.offers = offers
            })
            .store(in: &cancellables)
    }
}

