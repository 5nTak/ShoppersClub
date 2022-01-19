//
//  DetailView + Delegate.swift
//  ShoppersClub
//
//  Created by Tak on 2022/01/17.
//

import UIKit

extension DetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailImageViewCell.cellId, for: indexPath) as? DetailImageViewCell else { return UICollectionViewCell() }
        guard let images = item?.images else { return UICollectionViewCell() }
        cell.configureItemImages(with: images[indexPath.row])
        return cell
    }
}
