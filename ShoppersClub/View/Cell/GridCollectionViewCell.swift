//
//  CollectionViewCell.swift
//  ShoppersClub
//
//  Created by 오인탁 on 2021/12/07.
//

import UIKit

class GridCollectionViewCell: UICollectionViewCell {
    
    static let cellId = "GridCollectionViewCell"

    let networkManager = NetworkManager()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        gridCellConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    // MARK: - UI Initializer, Constant
    let thumbnailsImage: UIImageView = {
        let thumbnailsImage = UIImageView()
        thumbnailsImage.translatesAutoresizingMaskIntoConstraints = false
        thumbnailsImage.contentMode = .scaleAspectFit
        return thumbnailsImage
    }()
    let itemTitleLabel: UILabel = {
        let itemTitleLabel = UILabel()
        itemTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        itemTitleLabel.font = UIFont.preferredFont(forTextStyle: .body)
        itemTitleLabel.textColor = .black
        itemTitleLabel.textAlignment = .center
        itemTitleLabel.numberOfLines = 2
        return itemTitleLabel
    }()
    let itemStockLabel: UILabel = {
        let itemStockLabel = UILabel()
        itemStockLabel.translatesAutoresizingMaskIntoConstraints = false
        itemStockLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        itemStockLabel.textColor = .gray
        itemStockLabel.textAlignment = .center
        return itemStockLabel
    }()
    let itemPriceLabel: UILabel = {
        let itemPriceLabel = UILabel()
        itemPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        itemPriceLabel.font = UIFont.preferredFont(forTextStyle: .callout)
        itemPriceLabel.textColor = .gray
        return itemPriceLabel
    }()
    let itemDiscountedPriceLabel: UILabel? = {
        let itemDiscountedPriceLabel = UILabel()
        itemDiscountedPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        itemDiscountedPriceLabel.font = UIFont.preferredFont(forTextStyle: .callout)
        itemDiscountedPriceLabel.textColor = .gray
        itemDiscountedPriceLabel.textAlignment = .center
        return itemDiscountedPriceLabel
    }()
    let itemPriceStackView: UIStackView = {
        let itemPriceStackView = UIStackView()
        itemPriceStackView.translatesAutoresizingMaskIntoConstraints = false
        itemPriceStackView.axis = .vertical
        itemPriceStackView.alignment = .center
        return itemPriceStackView
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
//        thumbnailsImage.image = nil
        if itemStockLabel.text == "품절" {
            itemStockLabel.textColor = .orange
        } else {
            itemStockLabel.textColor = .gray
        }
    }
    
    func configureCell(with item: Item) {
        itemTitleLabel.text = item.title
        if item.stock == 0 {
            itemStockLabel.text = "품절"
            itemStockLabel.textColor = .orange
        } else {
            itemStockLabel.text = "잔여 수량: \(String(item.stock))"
        }
        itemPriceLabel.text = "\(item.currency) \(String(item.price))"
        if let itemDiscountedPrice = item.discountedPrice {
            itemDiscountedPriceLabel?.text = "\(item.currency) \(String(itemDiscountedPrice))"
            itemPriceLabel.textColor = .red
            let strikeOutItemPrice: NSMutableAttributedString = NSMutableAttributedString(string: (itemPriceLabel.text)!)
            strikeOutItemPrice.addAttribute(.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, strikeOutItemPrice.length))
            itemPriceLabel.attributedText = strikeOutItemPrice
        }
        configureThumbnails(with: item.thumbnails.first!)
    }
    
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
    
    func gridCellConstraints() {
        self.contentView.addSubview(thumbnailsImage)
        self.contentView.addSubview(itemTitleLabel)
        self.contentView.addSubview(itemStockLabel)
        self.contentView.addSubview(itemPriceStackView)
        thumbnailsConstraints()
        itemTitleConstraints()
        itemStockConstraints()
        itemPriceStackViewConstraints()
    }
    
    func thumbnailsConstraints() {
        NSLayoutConstraint.activate([
            thumbnailsImage.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5),
            thumbnailsImage.bottomAnchor.constraint(equalTo: itemTitleLabel.topAnchor, constant: -5),
            thumbnailsImage.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 2/5),
            thumbnailsImage.heightAnchor.constraint(equalTo: thumbnailsImage.widthAnchor),
            thumbnailsImage.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor)
        ])
        thumbnailsImage.layer.cornerRadius = 10
        thumbnailsImage.layer.masksToBounds = true
    }
    
    func itemTitleConstraints() {
        NSLayoutConstraint.activate([
            itemTitleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            itemTitleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            itemTitleLabel.bottomAnchor.constraint(equalTo: itemStockLabel.topAnchor, constant: -5)
        ])
    }
    
    func itemStockConstraints() {
        NSLayoutConstraint.activate([
            itemStockLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            itemStockLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            itemStockLabel.bottomAnchor.constraint(equalTo: itemPriceStackView.topAnchor, constant: -5)
        ])
    }
    
    func itemPriceStackViewConstraints() {
        NSLayoutConstraint.activate([
            itemPriceStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            itemPriceStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            itemPriceStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5)
        ])
        itemPriceConstraints()
    }
    
    func itemPriceConstraints() {
        self.itemPriceStackView.addArrangedSubview(itemPriceLabel)
        self.itemPriceStackView.addArrangedSubview(itemDiscountedPriceLabel!)
    }
}
