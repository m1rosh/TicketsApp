//
//  TestNet.swift
//  TicketsApp
//
//  Created by Сергей Мирошниченко on 05.06.2024.
//

import Foundation

enum MyError: Error {
    case FetchingError
}

class TestNet {
    static let shared = TestNet()
    
    func fetchAndDecode(completion: @escaping(Result<AviaTickets, Error>) -> Void) {
        let string_url = "https://run.mocky.io/v3/670c3d56-7f03-4237-9e34-d437a9e56ebf"
        
        guard let url = URL(string: string_url) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            //print(response)
            guard let data = data, error == nil else {
                if let error = error {
                    completion(.failure(error))
                }
                return
            }
            do {
                let tickets = try JSONDecoder().decode(AviaTickets.self, from: data)
                completion(.success(tickets))
            }
            catch {
                print("no")
            }
        }
        task.resume()
    }
    
    func fetchData(completion: @escaping(Result<Data, Error>) -> Void) {
        let string_url = "https://run.mocky.io/v3/670c3d56-7f03-4237-9e34-d437a9e56ebf"
        
        guard let url = URL(string: string_url) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            //print(response)
            guard let data = data, error == nil else {
                if let error = error {
                    completion(.failure(error))
                }
                return
            }
            completion(.success(data))
        }
        task.resume()
    }
    
    func decodeData<M: Decodable>(from: M.Type) {
        fetchData { result in
            switch result {
            case .success(let data):
                do {
                    let ticketsData = try JSONDecoder().decode(M.self, from: data)

                    DispatchQueue.main.async {
                        print(ticketsData)
                    }
                }
                catch {
                    
                    print("decoding error")
                }
            case .failure(_):
                
                print("fetching error")
                
            }
        }
    }
}
