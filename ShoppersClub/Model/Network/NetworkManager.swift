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
    
    func fetchData(url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                completion(.failure(NetworkError.unknownError))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }
            guard (200...399).contains(httpResponse.statusCode) == true else {
                completion(.failure(NetworkError.invalidHttpStatusCode))
                return
            }
            
            guard let itemData = data else {
                completion(.failure(NetworkError.emptyData))
                return
            }
            completion(.success(itemData))
        }
        task.resume()
    }
}
