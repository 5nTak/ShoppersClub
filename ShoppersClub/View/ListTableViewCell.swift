//
//  ListTableViewCell.swift
//  ShoppersClub
//
//  Created by 오인탁 on 2021/11/23.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    
    static let cellId = "ListTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}
