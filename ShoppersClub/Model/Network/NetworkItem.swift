//
//  NetworkItem.swift
//  ShoppersClub
//
//  Created by 오인탁 on 2021/12/06.
//

import Foundation

class NetworkItem {
    let networkManager = NetworkManager()
    
    func fetchItems(request: URLRequest, completion: @escaping (Result<ItemList, Error>) -> Void) {
        networkManager.fetchData(request: request) { result in
            switch result {
            case .success(let data):
                guard let decoding = self.decodeItems(data: data) else {
                    completion(.failure(NetworkError.decodingError))
                    return
                }
                completion(.success(decoding))
            case .failure(_):
                completion(.failure(NetworkError.emptyData))
            }
        }
    }
    
    func decodeItems(data: Data) -> ItemList? {
        guard let itemData = try? JSONDecoder().decode(ItemList.self, from: data) else { return nil }
        return itemData
    }
    
    /// GET - 목록 조회
    func loadItemListRequest(page: UInt) -> URLRequest {
        let requestURL = ShoppersClubAPI.loadItemList(page: page).url
        let request = URLRequest(url: requestURL)
        return request
    }
}
