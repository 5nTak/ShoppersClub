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
            if error != nil {
                completion(.failure(NetworkError.unknownError))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }
            guard (200...399).contains(httpResponse.statusCode) == false else {
                completion(.failure(NetworkError.invalidHttpStatusCode))
                return
            }
            
            guard let itemData = data else {
                completion(.failure(NetworkError.emptyData))
                return
            }
            do {
                guard let itemDecodingData = try? JSONDecoder().decode(ItemList.self, from: itemData) else { return }
                completion(.success(itemDecodingData))
            } catch {
                completion(.failure(NetworkError.decodingError))
            }
            return
        }
        task.resume()
    }
}
