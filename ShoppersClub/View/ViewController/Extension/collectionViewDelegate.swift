//
//  ViewController.swift
//  ShoppersClub
//
//  Created by 오인탁 on 2021/12/08.
//

import UIKit

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch cellSegmentedControl.selectedSegmentIndex {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCollectionViewCell.cellId, for: indexPath) as? ListCollectionViewCell else { return UICollectionViewCell() }
            cell.configureCell(with: items[indexPath.row])
            cell.prepareForReuse()
            cell.backgroundColor = .white
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GridCollectionViewCell.cellId, for: indexPath) as? GridCollectionViewCell else { return UICollectionViewCell() }
            cell.configureCell(with: items[indexPath.row])
            cell.prepareForReuse()
            cell.backgroundColor = .white
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}
