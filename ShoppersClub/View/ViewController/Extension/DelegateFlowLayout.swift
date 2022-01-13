//
//  ViewController.swift
//  ShoppersClub
//
//  Created by 오인탁 on 2021/12/08.
//

import UIKit

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch self.cellSegmentedControl.selectedSegmentIndex {
        case 0:
            return CGSize(width: self.view.frame.width, height: self.view.frame.width * 1/3)
        case 1:
            return CGSize(width: (collectionView.frame.width / 2 - 25), height: (collectionView.frame.width / 2 - 25))
        default:
            return .zero
        }
    }
    
    func collectionView(_ collectionVIew: UICollectionView, layout collectionVIewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch cellSegmentedControl.selectedSegmentIndex {
        case 0:
            return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        case 1:
            return UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        default:
            return UIEdgeInsets()
        }
    }
}
