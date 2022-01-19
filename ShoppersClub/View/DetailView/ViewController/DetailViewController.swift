//
//  DetailViewController.swift
//  ShoppersClub
//
//  Created by Tak on 2022/01/15.
//

import UIKit

class DetailViewController: UIViewController {
    
    var item: Item?
    let networkManager = NetworkManager()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    let contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    let imageCollectionView: UICollectionView = {
        let imageCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        imageCollectionView.translatesAutoresizingMaskIntoConstraints = false
        imageCollectionView.register(DetailImageViewCell.self, forCellWithReuseIdentifier: DetailImageViewCell.cellId)
        return imageCollectionView
    }()
    let itemTitleLabel: UILabel = {
        let itemTitleLabel = UILabel()
        itemTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        itemTitleLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        itemTitleLabel.textAlignment = .left
        return itemTitleLabel
    }()
    let itemStockLabel: UILabel = {
        let itemStockLabel = UILabel()
        itemStockLabel.translatesAutoresizingMaskIntoConstraints = false
        itemStockLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        itemStockLabel.textAlignment = .left
        return itemStockLabel
    }()
    let itemPriceLabel: UILabel = {
        let itemPriceLabel = UILabel()
        itemPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        itemPriceLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        return itemPriceLabel
    }()
    let itemDiscountedPriceLabel: UILabel? = {
        let itemDiscountedPriceLabel = UILabel()
        itemDiscountedPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        itemDiscountedPriceLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        return itemDiscountedPriceLabel
    }()
    let itemPriceStackView: UIStackView = {
        let itemPriceStackView = UIStackView()
        itemPriceStackView.translatesAutoresizingMaskIntoConstraints = false
        itemPriceStackView.axis = .horizontal
        itemPriceStackView.distribution = .fillEqually
        return itemPriceStackView
    }()
    let itemDescription: UITextView = {
        let itemDescription = UITextView()
        itemDescription.translatesAutoresizingMaskIntoConstraints = false
        itemDescription.font = UIFont.preferredFont(forTextStyle: .body)
        return itemDescription
    }()
    let itemRegistrationDateLabel: UILabel = {
        let itemRegistrationDateLabel = UILabel()
        itemRegistrationDateLabel.translatesAutoresizingMaskIntoConstraints = false
        itemRegistrationDateLabel.font = UIFont.preferredFont(forTextStyle: .callout)
        itemRegistrationDateLabel.textColor = .systemGray
        return itemRegistrationDateLabel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.backgroundColor = .systemGray6
        showDetailInfo()
        navigationController?.navigationBar.topItem?.backButtonTitle = "상품 목록"
        self.title = "\(itemTitleLabel.text!)"
    }
    
    func configureDetailInfo(item: Item) {
        let date = Date(timeIntervalSince1970: item.registrationDate)
        let dateString = date.formatDate(date: date, dateFormat: "yyyy.MM.dd")
        itemTitleLabel.text = item.title
        itemDescription.text = item.descriptions
        itemRegistrationDateLabel.text = dateString
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
    }
    
    func showDetailInfo() {
        scrollViewLayout()
        detailConstraints()
    }
    
    func scrollViewLayout() {
        view.addSubview(scrollView)
        scrollViewConstraints()
        scrollView.addSubview(contentView)
        scrollView.addSubview(imageCollectionView)
        scrollView.addSubview(itemTitleLabel)
        scrollView.addSubview(itemStockLabel)
        scrollView.addSubview(itemDescription)
        scrollView.addSubview(itemRegistrationDateLabel)
        scrollView.addSubview(itemPriceStackView)
    }
    
    func detailConstraints() {
        contentViewConstraints()
        imageCollectionViewConstraints()
        itemTitleConstraints()
        itemStockConstraints()
        itemPriceStackViewConstraints()
        itemDescriptionConstraints()
        itemRegistrationConstraints()
    }
    
    func scrollViewConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    func contentViewConstraints() {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])
    }
    
    func imageCollectionViewConstraints() {
        NSLayoutConstraint.activate([
            imageCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageCollectionView.bottomAnchor.constraint(equalTo: itemTitleLabel.topAnchor, constant: -20)
        ])
    }
    
    func itemTitleConstraints() {
        NSLayoutConstraint.activate([
            itemTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            itemTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            itemTitleLabel.bottomAnchor.constraint(equalTo: itemStockLabel.topAnchor, constant: 15)
        ])
    }
    
    func itemStockConstraints() {
        NSLayoutConstraint.activate([
            itemStockLabel.leadingAnchor.constraint(equalTo: itemTitleLabel.leadingAnchor),
            itemStockLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            itemStockLabel.bottomAnchor.constraint(equalTo: itemPriceStackView.topAnchor)
        ])
    }
    
    func itemPriceStackViewConstraints() {
        NSLayoutConstraint.activate([
            itemPriceStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            itemPriceStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            itemPriceStackView.bottomAnchor.constraint(equalTo: itemDescription.topAnchor, constant: -20)
        ])
        itemPriceStackView.addArrangedSubview(itemPriceLabel)
        itemPriceStackView.addArrangedSubview(itemDiscountedPriceLabel!)
    }
    
    func itemDescriptionConstraints() {
        NSLayoutConstraint.activate([
            itemDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            itemDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            itemDescription.bottomAnchor.constraint(equalTo: itemRegistrationDateLabel.topAnchor, constant: -30)
        ])
    }
    
    func itemRegistrationConstraints() {
        NSLayoutConstraint.activate([
            itemRegistrationDateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            itemRegistrationDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            itemRegistrationDateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
}
