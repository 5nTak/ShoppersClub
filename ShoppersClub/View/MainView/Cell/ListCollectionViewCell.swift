//
//  ListCollectionViewCell.swift
//  ShoppersClub
//
//  Created by Tak on 2021/11/23.
//

import UIKit

class ListCollectionViewCell: UICollectionViewCell {
    
    static let cellId = "ListCollectionViewCell"

    let networkManager = NetworkManager()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCellRound()
        listCellConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Cell Property
    let thumbnailsImage: UIImageView = {
        let thumbnailsImage = UIImageView()
        thumbnailsImage.translatesAutoresizingMaskIntoConstraints = false
        thumbnailsImage.contentMode = .scaleAspectFit
        return thumbnailsImage
    }()
    let itemTitleLabel: UILabel = {
        let itemTitleLabel = UILabel()
        itemTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        itemTitleLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        itemTitleLabel.textColor = .black
        itemTitleLabel.numberOfLines = 2
        return itemTitleLabel
    }()
    let itemStockLabel: UILabel = {
        let itemStockLabel = UILabel()
        itemStockLabel.translatesAutoresizingMaskIntoConstraints = false
        itemStockLabel.font = UIFont.preferredFont(forTextStyle: .body)
        itemStockLabel.textColor = .gray
        itemStockLabel.textAlignment = .left
        return itemStockLabel
    }()
    let itemPriceLabel: UILabel = {
        let itemPriceLabel = UILabel()
        itemPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        itemPriceLabel.font = UIFont.preferredFont(forTextStyle: .body)
        itemPriceLabel.textColor = .gray
        return itemPriceLabel
    }()
    let itemDiscountedPriceLabel: UILabel? = {
        let itemDiscountedPriceLabel = UILabel()
        itemDiscountedPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        itemDiscountedPriceLabel.font = UIFont.preferredFont(forTextStyle: .body)
        itemDiscountedPriceLabel.textColor = .gray
        return itemDiscountedPriceLabel
    }()
    
    // MARK: - UI Update
    override func prepareForReuse() {
        super.prepareForReuse()
        thumbnailsImage.image = nil
        if itemStockLabel.text == "품절" {
            itemStockLabel.textColor = .orange
        } else {
            itemStockLabel.textColor = .gray
        }
    }
    
    func configureCell(with item: Item) {
        itemTitleLabel.text = item.title
        itemStockUpdate(item: item)
        itemPriceUpdate(item: item)
        configureThumbnails(with: item.thumbnails.first!)
    }
    
    func itemStockUpdate(item: Item) {
        if item.stock == 0 {
            itemStockLabel.text = "품절"
            itemStockLabel.textColor = .orange
        } else {
            itemStockLabel.text = "잔여 수량: \(String(item.stock))"
        }
    }
    
    func itemPriceUpdate(item: Item) {
        itemPriceLabel.text = "\(item.currency) \(String(item.price))"
        if let itemDiscountedPrice = item.discountedPrice {
            itemDiscountedPriceLabel?.text = "\(item.currency) \(String(itemDiscountedPrice))"
            itemPriceLabel.textColor = .red
            let strikeOutItemPrice: NSMutableAttributedString = NSMutableAttributedString(string: (itemPriceLabel.text)!)
            strikeOutItemPrice.addAttribute(.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, strikeOutItemPrice.length))
            itemPriceLabel.attributedText = strikeOutItemPrice
        }
    }
    
    // MARK: - Networking
    private func configureThumbnails(with path: String) {
        let url = URL(string: path)!
        let request = URLRequest(url: url)
        networkManager.fetchData(request: request) { [weak self] result in
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
    
    // MARK: - Item Autolayout
    func listCellConstraints() {
        self.contentView.addSubview(thumbnailsImage)
        self.contentView.addSubview(itemTitleLabel)
        self.contentView.addSubview(itemStockLabel)
        self.contentView.addSubview(itemPriceLabel)
        thumbnailsConstraints()
        itemTitleConstraints()
        itemStockConstraints()
        itemPriceConstraints()
    }
    
    func thumbnailsConstraints() {
        NSLayoutConstraint.activate([
            thumbnailsImage.topAnchor.constraint(equalTo: self.topAnchor),
            thumbnailsImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            thumbnailsImage.trailingAnchor.constraint(equalTo: itemTitleLabel.leadingAnchor, constant: -10),
            thumbnailsImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            thumbnailsImage.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/3),
            thumbnailsImage.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/3)
        ])
        thumbnailsImage.layer.cornerRadius = 10
        thumbnailsImage.layer.masksToBounds = true
    }
    
    func itemTitleConstraints() {
        NSLayoutConstraint.activate([
            itemTitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            itemTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
        ])
    }
    
    func itemStockConstraints() {
        NSLayoutConstraint.activate([
            itemStockLabel.topAnchor.constraint(equalTo: itemTitleLabel.bottomAnchor, constant: 10),
            itemStockLabel.leadingAnchor.constraint(equalTo: thumbnailsImage.trailingAnchor, constant: 10),
            itemStockLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
    }
    
    func itemPriceConstraints() {
        self.contentView.addSubview(itemDiscountedPriceLabel!)
        NSLayoutConstraint.activate([
            itemPriceLabel.topAnchor.constraint(equalTo: itemStockLabel.bottomAnchor, constant: 10),
            itemPriceLabel.leadingAnchor.constraint(equalTo: thumbnailsImage.trailingAnchor, constant: 10),
            itemPriceLabel.trailingAnchor.constraint(equalTo: itemDiscountedPriceLabel!.leadingAnchor, constant: -10),
            itemPriceLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            itemDiscountedPriceLabel!.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ])
    }
    
    func setupCellRound() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 10
        self.layer.cornerRadius = 15
        self.layer.masksToBounds = true
    }
}
