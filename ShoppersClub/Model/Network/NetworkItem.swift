//
//  NetworkItem.swift
//  ShoppersClub
//
//  Created by Tak on 2021/12/06.
//

import Foundation

class NetworkItem {
    let networkManager = NetworkManager()
    
    //MARK: - Network 분기 처리
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
    
    func fetchItem(request: URLRequest, completion: @escaping (Result<Item, Error>) -> Void) {
        networkManager.fetchData(request: request) { result in
            switch result {
            case .success(let data):
                guard let decoding = self.decodeItem(data: data) else {
                    completion(.failure(NetworkError.decodingError))
                    return
                }
                completion(.success(decoding))
            case .failure(_):
                completion(.failure(NetworkError.emptyData))
            }
        }
    }
    
    // MARK: - JSON Decoding
    func decodeItems(data: Data) -> ItemList? {
        guard let itemData = try? JSONDecoder().decode(ItemList.self, from: data) else { return nil }
        return itemData
    }
    
    func decodeItem(data: Data) -> Item? {
        guard let itemData = try? JSONDecoder().decode(Item.self, from: data) else { return nil }
        return itemData
    }
    
    // MARK: - GET 목록 조회
    func loadItemListRequest(page: UInt) -> URLRequest {
        let requestURL = ShoppersClubAPI.loadItemList(page: page).url
        let request = URLRequest(url: requestURL)
        return request
    }
    
    // MARK: - GET 상품 조회
    func loadItemIdRequest(_ id: UInt) -> URLRequest? {
        let requestId = ShoppersClubAPI.loadItem(id: id).url
        let request = URLRequest(url: requestId)
        return request
    }
}
