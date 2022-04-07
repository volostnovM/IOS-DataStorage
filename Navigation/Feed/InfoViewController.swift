//
//  InfoViewController.swift
//  Navigation
//
//  Created by Artem Novichkov on 12.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.text = "Wait for update"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var nameResidents = [String]()
    
    private lazy var residentID = String(describing: TableViewCellResident.self)
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.backgroundColor = .white
        tableView.layer.cornerRadius = 10
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray
        
        setupConstraints()
        
        tableView.register(TableViewCellResident.self, forCellReuseIdentifier: residentID)
        tableView.dataSource = self
        
        NetworkService.getResidents(completion: { [weak self] (result: [String]) in
            self?.label.text = "Rundom name: \(result.randomElement() ?? "")"
            self?.nameResidents = result
            self?.tableView.reloadData()
        })
    }

}

extension InfoViewController {
    private func setupConstraints() {
        view.addSubview(label)
        view.addSubview(tableView)
        
        [
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.heightAnchor.constraint(equalToConstant: 50),

            tableView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 50),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
        ]
            .forEach {$0.isActive = true}
    }
}

extension InfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TableViewCellResident = tableView.dequeueReusableCell(withIdentifier: residentID, for: indexPath) as! TableViewCellResident
        if indexPath.row >= nameResidents.count {
            cell.nameResident.text = "Wait for update"
        } else {
            cell.nameResident.text = nameResidents[indexPath.row]
        }
        cell.selectionStyle = .none
        return cell
    }
}
