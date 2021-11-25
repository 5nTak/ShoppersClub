//
//  ViewController.swift
//  ShoppersClub
//
//  Created by 오인탁 on 2021/11/13.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var items: [Item] = []
    let networkManager = NetworkManager()
    let ListTableView: UITableView = {
        let ListTableView = UITableView()
        ListTableView.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.cellId)
        ListTableView.translatesAutoresizingMaskIntoConstraints = false
        return ListTableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        ListTableView.delegate = self
        ListTableView.dataSource = self
        fetchItems()
        listTableViewConstraints()
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
        view.addSubview(ListTableView)
        NSLayoutConstraint.activate([
            ListTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            ListTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            ListTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ListTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func fetchItems() {
        let url = URL(string: "https://camp-open-market-2.herokuapp.com/items/1")!
        networkManager.fetchData(url: url) { [weak self] result in
            switch result {
            case .success(let data):
                let itemList = try! JSONDecoder().decode(ItemList.self, from: data)
                self?.items.append(contentsOf: itemList.items)
                DispatchQueue.main.async {
                    self?.ListTableView.reloadData()
                }
            case .failure(_):
                fatalError()
            }
        }
    }
}

