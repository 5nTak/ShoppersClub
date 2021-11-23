//
//  NetworkError.swift
//  ShoppersClub
//
//  Created by 오인탁 on 2021/11/20.
//

import Foundation

enum NetworkError: Error {
    case unknownError
    case invalidURL
    case invalidResponse
    case invalidHttpStatusCode
    case emptyData
    case decodingError
}
