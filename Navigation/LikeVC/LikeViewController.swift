//
//  LikeViewController.swift
//  Navigation
//
//  Created by TIS Developer on 07.04.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//
import UIKit

class LikeViewController: UIViewController {

    let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .white
        table.register(PostTableViewCell.self, forCellReuseIdentifier: String(describing: PostTableViewCell.self))
        return table
    }()

    var posts: [PostVK] {
        return DataBaseService.shared.setPost()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        let deleteButton = UIBarButtonItem(title: "Удалить все", style: .plain, target: self, action: #selector(deleteAll))
        self.navigationItem.rightBarButtonItem = deleteButton
        tableView.dataSource = self
        tabBarController?.delegate = self
        setupViews()
        tableView.reloadData()
    }

    @objc func deleteAll() {
        DataBaseService.shared.deleteAll()
        self.tableView.reloadData()
    }
}

extension LikeViewController {
    func setupViews() {
        self.view.addSubview(tableView)

        [self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
         self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
         self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
         self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ].forEach {$0.isActive = true}
    }
}

extension LikeViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.posts.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PostTableViewCell.self), for: indexPath) as? PostTableViewCell
        cell?.content = self.posts[indexPath.item]
        return cell ?? UITableViewCell()
    }

}

extension LikeViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        self.tableView.reloadData()
    }
}
