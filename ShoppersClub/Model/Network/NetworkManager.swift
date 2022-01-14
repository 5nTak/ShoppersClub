//
//  NetworkManager.swift
//  ShoppersClub
//
//  Created by Tak on 2021/11/20.
//

import Foundation

struct NetworkManager {
    let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetchData(request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) {
        let task = session.dataTask(with: request) { data, response, error in
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
