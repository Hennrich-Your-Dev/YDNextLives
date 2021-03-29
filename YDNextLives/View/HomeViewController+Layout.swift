//
//  HomeViewController+Layout.swift
//  YDNextLives
//
//  Created by Douglas Hennrich on 24/03/21.
//

import UIKit

import YDExtensions
import YDB2WComponents
import YDB2WAssets

extension HomeViewController {
  func setUpLayouts() {
    view.backgroundColor = .white
    title = "próximas lives"

    navigationItem.rightBarButtonItems = [createRightButton()]

    createTableView()
    createEmptyState()
  }

  // Bar Item
  func createRightButton() -> UIBarButtonItem {
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
    tableView.frame = view.frame
    tableView.separatorStyle = .none
    tableView.tableHeaderView = UIView(
      frame: CGRect(
        x: 0,
        y: 0,
        width: 0,
        height: 10
      )
    )
    tableView.tableFooterView = UIView(
      frame: CGRect(
        x: 0,
        y: 0,
        width: 0,
        height: view.safeAreaInsets.bottom + 20
      )
    )
    tableView.backgroundColor = .clear
    tableView.rowHeight = 154
    tableView.dataSource = self

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

    view.addSubview(tableView)
    tableView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])

    numberOfShimmers = Int((tableView.frame.size.height / cellHeightSize).rounded(.up))
  }

  // Empty State
  func createEmptyState() {
    view.addSubview(emptyStateView)
    emptyStateView.isHidden = true

    // Icon
    let icon = UIImageView()
    icon.image = Icons.scheduleAction
    icon.tintColor = UIColor.Zeplin.grayNight
    emptyStateView.addSubview(icon)

    icon.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      icon.centerXAnchor.constraint(equalTo: emptyStateView.centerXAnchor),
      icon.centerYAnchor.constraint(
        equalToSystemSpacingBelow: emptyStateView.centerYAnchor,
        multiplier: -1
      ),
      icon.widthAnchor.constraint(equalToConstant: 116),
      icon.heightAnchor.constraint(equalToConstant: 116)
    ])

    // Title
    let titleLabel = UILabel()
    titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
    titleLabel.textColor = UIColor.Zeplin.black
    titleLabel.text = "poooxa, não temos nada planejado!"
    titleLabel.textAlignment = .center
    emptyStateView.addSubview(titleLabel)

    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      titleLabel.leadingAnchor.constraint(
        equalTo: emptyStateView.leadingAnchor,
        constant: 24
      ),
      titleLabel.trailingAnchor.constraint(
        equalTo: emptyStateView.trailingAnchor,
        constant: -24
      ),
      titleLabel.topAnchor.constraint(equalTo: icon.bottomAnchor, constant: 20)
    ])

    // Message
    let messageLabel = UILabel()
    messageLabel.font = .systemFont(ofSize: 14)
    messageLabel.textColor = UIColor.Zeplin.grayLight
    messageLabel.numberOfLines = 0
    messageLabel.textAlignment = .center
    messageLabel.text = .loremIpsum()
    emptyStateView.addSubview(messageLabel)

    messageLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      messageLabel.leadingAnchor.constraint(
        equalTo: emptyStateView.leadingAnchor,
        constant: 46
      ),
      messageLabel.trailingAnchor.constraint(
        equalTo: emptyStateView.trailingAnchor,
        constant: -46
      ),
      messageLabel.topAnchor.constraint(
        equalTo: titleLabel.bottomAnchor,
        constant: 8
      )
    ])
  }
}
