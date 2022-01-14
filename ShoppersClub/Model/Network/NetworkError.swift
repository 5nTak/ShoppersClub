//
//  NetworkError.swift
//  ShoppersClub
//
//  Created by Tak on 2021/11/20.
//

import Foundation

enum NetworkError: Error {
    case unknownError
    case invalidURL
    case invalidResponse
    case invalidHttpStatusCode
    case emptyData
    case decodingError
    
    var errorDescription: String? {
        switch self {
        case .unknownError:
            return "An unknown error has occurred!"
        case .invalidURL:
            return "URL is invalid!"
        case .invalidResponse:
            return "HTTPResponse is invalid!"
        case .invalidHttpStatusCode:
            return "HTTPStatusCode does not match!"
        case .emptyData:
            return "Data is empty!"
        case .decodingError:
            return "An error occurred during decoding!"
        }
    }
}
