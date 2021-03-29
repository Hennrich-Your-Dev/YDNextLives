//
//  HomeViewController+Layout.swift
//  YDNextLives
//
//  Created by Douglas Hennrich on 24/03/21.
//

import UIKit

extension HomeViewController {
  func setUpLayouts() {
    view.backgroundColor = .white
    title = "próximas lives"

    navigationItem.rightBarButtonItems = [createRightButton()]

    createTableView()
  }

  // Bar Item
  private func createRightButton() -> UIBarButtonItem {
    let button = UIBarButtonItem(
      title: "fechar",
      style: .plain,
      target: self,
      action: #selector(onBackAction)
    )
    return button
  }

  // TableView
  func createTableView() {
    tableView.separatorStyle = .none
    tableView.tableFooterView = UIView()
    tableView.backgroundColor = .clear
    tableView.rowHeight = 142
    tableView.estimatedSectionFooterHeight = 20
    tableView.dataSource = self
    tableView.delegate = self

    // Cell
    tableView.register(
      LiveTableViewCell.self,
      forCellReuseIdentifier: LiveTableViewCell.identifier
    )

    // Shimmer
    tableView.register(
      LiveShimmerTableViewCell.self,
      forCellReuseIdentifier: LiveShimmerTableViewCell.identifier
    )

    // Footer
    tableView.register(
      LiveFooterView.self,
      forHeaderFooterViewReuseIdentifier: LiveHeaderView.identifier
    )

    view.addSubview(tableView)
    tableView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }
}
