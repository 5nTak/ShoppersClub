//
//  MainView + DataSourcePreFetching.swift
//  ShoppersClub
//
//  Created by Tak on 2021/12/08.
//

import UIKit

extension MainViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if items.count == indexPath.row + 6 {
                self.page += 1
                fetchGetItems(page: page)
            }
        }
    }
}
