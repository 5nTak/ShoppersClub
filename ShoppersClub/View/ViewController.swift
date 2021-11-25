//
//  ViewController.swift
//  ShoppersClub
//
//  Created by 오인탁 on 2021/11/13.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var items: [Item] = []
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
        listTableViewConstraints()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.cellId, for: indexPath) as? ListTableViewCell else { return UITableViewCell() }
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
}

