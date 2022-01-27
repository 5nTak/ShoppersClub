//
//  DetailView + DataSource.swift
//  ShoppersClub
//
//  Created by Tak on 2022/01/17.
//

import UIKit

extension DetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let images = item?.images else { return 0}
        return images.count
    }
}
