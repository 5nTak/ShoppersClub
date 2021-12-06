//
//  ShoppersClubAPI.swift
//  ShoppersClub
//
//  Created by 오인탁 on 2021/12/06.
//

import Foundation

enum ShoppersClubAPI {
    static let baseURL = "https://camp-open-market-2.herokuapp.com/"
    case loadItemList(page: UInt)
    case loadItem(id: UInt)
    case registrateItem
    case editItem(id: UInt)
    case deleteItem(id: UInt)
    
    var url: URL {
        switch self {
        case .loadItemList(let page):
            return URL(string: ShoppersClubAPI.baseURL + "/items/" + "\(page)")!
        case .loadItem(let id):
            return URL(string: ShoppersClubAPI.baseURL + "/item/" + "\(id)")!
        case .registrateItem:
            return URL(string: ShoppersClubAPI.baseURL + "/item")!
        case .editItem(let id):
            return URL(string: ShoppersClubAPI.baseURL + "/items/" + "\(id)")!
        case .deleteItem(let id):
            return URL(string: ShoppersClubAPI.baseURL + "/item/" + "\(id)")!
        }
    }
    
    var method: String {
        switch self {
        case .loadItemList:
            return "GET"
        case .loadItem:
            return "GET"
        case .registrateItem:
            return "POST"
        case .editItem:
            return "PATCH"
        case .deleteItem:
            return "DELETE"
        }
    }
}
