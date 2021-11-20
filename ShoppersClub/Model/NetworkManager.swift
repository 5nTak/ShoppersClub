//
//  NetworkManager.swift
//  ShoppersClub
//
//  Created by 오인탁 on 2021/11/20.
//

import Foundation

struct NetworkManager {
    let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetchData(completion: @escaping (Result<ItemList, Error>) -> Void) {
        let url = URL(string: "https://camp-open-market-2.herokuapp.com/")!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(fatalError()))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, (200...399).contains(httpResponse.statusCode) else {
                completion(.failure(fatalError()))
            }
            if let data = data {
                let itemData = try? JSONDecoder().decode(ItemList.self, from: data)
                completion(.success(itemData!))
            }
            completion(.failure(fatalError()))
        }
        task.resume()
    }
}
