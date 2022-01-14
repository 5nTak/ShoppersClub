//
//  ItemRegistration.swift
//  ShoppersClub
//
//  Created by Tak on 2021/11/13.
//

import Foundation

struct ItemRegistration: Decodable {
    let title: String
    let descriptions: String
    let price: UInt
    let currency: String
    let stock: UInt
    let discountedPrice: UInt?
    let images: [String]
    let password: String
    
    enum CodingKeys: String, CodingKey {
        case title, descriptions, price, currency, stock, images, password
        case discountedPrice = "discounted_price"
    }
}
