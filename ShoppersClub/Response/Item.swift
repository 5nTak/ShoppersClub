//
//  Item.swift
//  ShoppersClub
//
//  Created by 오인탁 on 2021/11/13.
//

import Foundation

struct Item: Decodable {
    let title: String
    let descriptions: String
    let price: UInt
    let currency: String
    let stock: UInt
    let discountedPrice: UInt?
    let thumbnails: [String]
    let images: [String]
    let registrationDate: UInt
    
    enum CodingKeys: String, CodingKey {
        case title, descriptions, price, currency, stock, thumbnails, images
        case discountedPrice = "discounted_price"
        case registrationDate = "registration_date"
    }
}
