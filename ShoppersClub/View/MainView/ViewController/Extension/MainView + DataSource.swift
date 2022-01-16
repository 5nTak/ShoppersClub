//
//  MainView + DataSource.swift
//  ShoppersClub
//
//  Created by Tak on 2021/12/08.
//

import UIKit

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
}
