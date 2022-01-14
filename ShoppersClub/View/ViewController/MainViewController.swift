//
//  MainViewController.swift
//  ShoppersClub
//
//  Created by Tak on 2021/12/06.
//

import UIKit

class MainViewController: UIViewController {
    
    enum CellStyle: String, CaseIterable {
        case list = "List"
        case grid = "Grid"
    }
    
    var items: [Item] = []
    let networkManager = NetworkManager()
    let networkItem = NetworkItem()
    var page: UInt = 1
    
    // MARK: - UI Initialization, Constant
    let cellSegmentedControl: UISegmentedControl = {
        let cellSegmentedControl = UISegmentedControl(items: CellStyle.allCases.map { $0.rawValue })
        cellSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        cellSegmentedControl.selectedSegmentIndex = 0
        cellSegmentedControl.backgroundColor = .white
        return cellSegmentedControl
    }()
    
    let itemCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(ListCollectionViewCell.self, forCellWithReuseIdentifier: ListCollectionViewCell.cellId)
        collectionView.register(GridCollectionViewCell.self, forCellWithReuseIdentifier: GridCollectionViewCell.cellId)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemGray4
        return collectionView
    }()
    
    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setSegment()
        fetchGetItems(page: 1)
        setCollectionView()
    }
    
    func setSegment() {
        for index in 0..<CellStyle.allCases.count {
            self.cellSegmentedControl.setWidth(self.view.frame.width / 5, forSegmentAt: index)
        }
        self.cellSegmentedControl.addTarget(self, action: #selector(changeCellStyle), for: .valueChanged)
        self.navigationItem.titleView = self.cellSegmentedControl
    }
    
    @objc func changeCellStyle() {
        switch self.cellSegmentedControl.selectedSegmentIndex {
        case 0:
            self.itemCollectionView.reloadData()
        case 1:
            self.itemCollectionView.reloadData()
        default:
            return
        }
    }

    // MARK: - CollectionView Constraints
    func setCollectionView() {
        view.addSubview(itemCollectionView)
        itemCollectionView.delegate = self
        itemCollectionView.dataSource = self
        itemCollectionView.prefetchDataSource = self
        collectionViewConstraints()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderWidth = 2
        cell?.layer.borderColor = UIColor.magenta.cgColor
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderColor = UIColor.white.cgColor
    }
    
    func collectionViewConstraints() {
        NSLayoutConstraint.activate([
            itemCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            itemCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            itemCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            itemCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    // MARK: - Networking
    func fetchGetItems(page: UInt) {
        let request = networkItem.loadItemListRequest(page: page)
        networkItem.fetchItems(request: request) { result in
            switch result {
            case .success(let itemList):
                DispatchQueue.main.async {
                    self.items.append(contentsOf: itemList.items)
                    self.itemCollectionView.reloadData()
                }
            case .failure(_):
                fatalError()
            }
        }
    }
}
