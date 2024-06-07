//
//  DataManager.swift
//  TicketsApp
//
//  Created by Сергей Мирошниченко on 03.06.2024.
//

import Foundation
import Combine

class DataManager {
    static let shared = DataManager()
    
    func fetchData<T: Decodable>(from url: URL, decodeTo type: T.Type) -> AnyPublisher<T, Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func saveToCache(_ data: String) {
        UserDefaults.standard.setValue(data, forKey: "fromCity")
    }
    
    func loadFromCache() -> String {
        UserDefaults.standard.string(forKey: "fromCity") ?? ""
    }
    
}


