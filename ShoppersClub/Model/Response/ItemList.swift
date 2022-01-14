//
//  ItemList.swift
//  ShoppersClub
//
//  Created by Tak on 2021/11/13.
//

import Foundation

struct ItemList: Decodable {
    let page: UInt
    let items: [Item]
}
