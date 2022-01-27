//
//  CollectionViewController.swift
//  ShoppersClub
//
//  Created by Tak on 2022/01/27.
//

import UIKit

extension DetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewSize = self.view.frame.width
        return CGSize(width: collectionViewSize, height: collectionViewSize)
    }
}
