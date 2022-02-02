//
//  DetailImageViewCell.swift
//  ShoppersClub
//
//  Created by Tak on 2022/01/16.
//

import UIKit

//class DetailImageViewCell: UICollectionViewCell {
//    
//    static let cellId = "DetailImageViewCell"
//    
//    let networkManager = NetworkManager()
//    
//    let itemImages: UIImageView = {
//        let itemImages = UIImageView()
//        itemImages.translatesAutoresizingMaskIntoConstraints = false
//        itemImages.contentMode = .scaleAspectFit
//        return itemImages
//    }()
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        imagesConstraints()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError()
//    }
//    
//    func configureItemImages(with path: String) {
//        let url = URL(string: path)!
//        let request = URLRequest(url: url)
//        networkManager.fetchData(request: request) { [weak self] result in
//            switch result {
//            case .success(let data):
//                let image = UIImage(data: data)!
//                DispatchQueue.main.async {
//                    self?.itemImages.image = image
//                }
//            case .failure(_):
//                fatalError()
//            }
//        }
//    }
//    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        itemImages.image = nil
//    }
//    
//    func imagesConstraints() {
//        self.contentView.addSubview(itemImages)
//        NSLayoutConstraint.activate([
//            itemImages.topAnchor.constraint(equalTo: self.contentView.topAnchor),
//            itemImages.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
//            itemImages.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
//            itemImages.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
//        ])
//    }
//}
