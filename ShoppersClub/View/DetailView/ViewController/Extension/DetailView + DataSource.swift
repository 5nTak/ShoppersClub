//
//  DetailView + DataSource.swift
//  ShoppersClub
//
//  Created by Tak on 2022/01/17.
//

import UIKit

extension DetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let unwrappingItem = item else { return 0 }
        guard let images = unwrappingItem.images else { return 0}
        return images.count
    }
}
