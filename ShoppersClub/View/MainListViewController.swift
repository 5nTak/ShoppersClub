//
//  MainListViewController.swift
//  ShoppersClub
//
//  Created by 오인탁 on 2021/12/06.
//

import UIKit

class MainListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var items: [Item] = []
    let networkManager = NetworkManager()
    let networkItem = NetworkItem()
    let listTableView: UITableView = {
        let ListTableView = UITableView()
        ListTableView.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.cellId)
        ListTableView.translatesAutoresizingMaskIntoConstraints = false
        return ListTableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        listTableView.delegate = self
        listTableView.dataSource = self
        listTableViewConstraints()
        fetchGetItems(page: 1)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.cellId, for: indexPath) as? ListTableViewCell else { return UITableViewCell() }
        cell.configureCell(with: items[indexPath.row])
        cell.prepareForReuse()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func listTableViewConstraints() {
        view.addSubview(listTableView)
        NSLayoutConstraint.activate([
            listTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            listTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            listTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            listTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func fetchGetItems(page: UInt) {
        let request = networkItem.loadItemListRequest(page: page)
        networkItem.fetchItems(request: request) { result in
            switch result {
            case .success(let itemList):
                DispatchQueue.main.async {
                    self.items.append(contentsOf: itemList.items)
                    self.listTableView.reloadData()
                }
            case .failure(_):
                fatalError()
            }
        }
    }
}
