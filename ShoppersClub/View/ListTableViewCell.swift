//
//  ListTableViewCell.swift
//  ShoppersClub
//
//  Created by 오인탁 on 2021/11/23.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    
    static let cellId = "ListTableViewCell"

    let networkManager = NetworkManager()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        listCellConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    let thumbnailsImage: UIImageView = {
        let thumbnailsImage = UIImageView()
        thumbnailsImage.translatesAutoresizingMaskIntoConstraints = false
        thumbnailsImage.contentMode = .scaleAspectFit
        return thumbnailsImage
    }()
    let itemTitle: UILabel = {
        let itemTitle = UILabel()
        itemTitle.translatesAutoresizingMaskIntoConstraints = false
        itemTitle.font = UIFont.preferredFont(forTextStyle: .title2)
        itemTitle.textColor = .black
        itemTitle.numberOfLines = 0
        return itemTitle
    }()
    let itemStock: UILabel = {
        let itemStock = UILabel()
        itemStock.translatesAutoresizingMaskIntoConstraints = false
        itemStock.font = UIFont.preferredFont(forTextStyle: .body)
        itemStock.textColor = .gray
        return itemStock
    }()
    let itemPrice: UILabel = {
        let itemPrice = UILabel()
        itemPrice.translatesAutoresizingMaskIntoConstraints = false
        itemPrice.font = UIFont.preferredFont(forTextStyle: .body)
        itemPrice.textColor = .gray
        return itemPrice
    }()
    let itemDiscountedPrice: UILabel? = {
        let itemDiscountedPrice = UILabel()
        itemDiscountedPrice.translatesAutoresizingMaskIntoConstraints = false
        itemDiscountedPrice.font = UIFont.preferredFont(forTextStyle: .body)
        itemDiscountedPrice.textColor = .gray
        return itemDiscountedPrice
    }()
    
    func configureCell(with item: Item) {
        itemTitle.text = item.title
        if item.stock == 0 {
            itemStock.text = "품절"
            itemStock.textColor = .orange
        } else {
            itemStock.text = "재고: \(String(item.stock))"
        }
        itemPrice.text = "\(item.currency) \(String(item.price))"
        if let itemsDiscountedPrice = item.discountedPrice {
            itemDiscountedPrice?.text = "\(item.currency) \(String(itemsDiscountedPrice))"
        }
        configureThumbnails(with: item.thumbnails.first!)
    }
    
    private func configureThumbnails(with path: String) {
        let url = URL(string: path)!
        networkManager.fetchData(url: url) { [weak self] result in
            switch result {
            case .success(let data):
                let image = UIImage(data: data)!
                DispatchQueue.main.async {
                    self?.thumbnailsImage.image = image
                }
            case .failure(_):
                fatalError()
            }
        }
    }
    
    func listCellConstraints() {
        self.contentView.addSubview(thumbnailsImage)
        self.contentView.addSubview(itemTitle)
        self.contentView.addSubview(itemStock)
        self.contentView.addSubview(itemPrice)
        thumbnailsConstraints()
        itemTitleConstraints()
        itemStockConstraints()
        itemPriceConstraints()
    }
    
    func thumbnailsConstraints() {
        NSLayoutConstraint.activate([
            thumbnailsImage.topAnchor.constraint(equalTo: self.topAnchor),
            thumbnailsImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            thumbnailsImage.trailingAnchor.constraint(equalTo: itemTitle.leadingAnchor, constant: -10),
            thumbnailsImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            thumbnailsImage.widthAnchor.constraint(equalTo: thumbnailsImage.heightAnchor)
        ])
    }
    
    func itemTitleConstraints() {
        NSLayoutConstraint.activate([
            itemTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            itemTitle.leadingAnchor.constraint(equalTo: thumbnailsImage.trailingAnchor, constant: 10),
            itemTitle.trailingAnchor.constraint(equalTo: itemStock.leadingAnchor, constant: -10)
        ])
    }
    
    func itemStockConstraints() {
        NSLayoutConstraint.activate([
            itemStock.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            itemStock.leadingAnchor.constraint(equalTo: itemTitle.trailingAnchor, constant: 10),
            itemStock.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
    }
    
    func itemPriceConstraints() {
        if itemDiscountedPrice == nil {
            NSLayoutConstraint.activate([
                itemPrice.leadingAnchor.constraint(equalTo: thumbnailsImage.trailingAnchor, constant: 10),
                itemPrice.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
            ])
        } else {
            self.contentView.addSubview(itemDiscountedPrice!)
            itemPrice.textColor = .red
            NSLayoutConstraint.activate([
                itemPrice.leadingAnchor.constraint(equalTo: thumbnailsImage.trailingAnchor, constant: 10),
                itemPrice.trailingAnchor.constraint(equalTo: itemDiscountedPrice!.leadingAnchor, constant: -10),
                itemPrice.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
                itemDiscountedPrice!.leadingAnchor.constraint(equalTo: itemPrice.trailingAnchor, constant: 10),
                itemDiscountedPrice!.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
            ])
        }
    }
}
