//
//  ViewController.swift
//  ShoppersClub
//
//  Created by 오인탁 on 2021/12/08.
//

import UIKit

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
}
