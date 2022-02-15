//
//  Date.swift
//  ShoppersClub
//
//  Created by Tak on 2022/01/19.
//

import Foundation

extension Date {
    func formatDate(date: Date, dateFormat: String = "yyyy.MM.dd") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        return formatter.string(from: date)
    }
}
