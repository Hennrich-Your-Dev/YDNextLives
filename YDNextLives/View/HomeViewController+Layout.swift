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

    extendedLayoutIncludesOpaqueBars = true

    createTableView()
    createEmptyState()
    createErrorState()
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
    view.addSubview(tableView)
    tableView.frame = view.frame
    tableView.separatorStyle = .none
    tableView.tableHeaderView = UIView(
      frame: CGRect(
        x: 0,
        y: 0,
        width: 0,
        height: 24
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
    tableView.estimatedRowHeight = cellHeightSize
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

    tableView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.topAnchor),
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

    emptyStateView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      emptyStateView.topAnchor.constraint(equalTo: view.topAnchor),
      emptyStateView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      emptyStateView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      emptyStateView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    ])

    // Icon
    let icon = UIImageView()
    icon.image = Icons.scheduleAction
    icon.tintColor = UIColor.Zeplin.grayNight
    emptyStateView.addSubview(icon)

    icon.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      icon.centerXAnchor.constraint(equalTo: emptyStateView.centerXAnchor),
      icon.widthAnchor.constraint(equalToConstant: 116),
      icon.heightAnchor.constraint(equalToConstant: 116)
    ])
    NSLayoutConstraint(
      item: icon,
      attribute: .centerY,
      relatedBy: .equal,
      toItem: emptyStateView,
      attribute: .centerY,
      multiplier: 0.8,
      constant: -1
    ).isActive = true

    // Title
    let titleLabel = UILabel()
    titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
    titleLabel.textColor = UIColor.Zeplin.black
    titleLabel.text = "poooxa, por enquanto não tem live planejada :/"
    titleLabel.numberOfLines = 0
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
    messageLabel.text = "mas fica de olho no calendário que já já tem um novo #AmericanasAoVivo esperando por você!"
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

  // Error State
  func createErrorState() {
    view.addSubview(errorStateView)
    errorStateView.isHidden = true

    errorStateView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      errorStateView.topAnchor.constraint(equalTo: view.topAnchor),
      errorStateView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      errorStateView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      errorStateView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    ])

    // Icon
    let icon = UIImageView()
    icon.image = Icons.sadFace
    icon.tintColor = UIColor.Zeplin.grayNight
    errorStateView.addSubview(icon)

    icon.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      icon.centerXAnchor.constraint(equalTo: errorStateView.centerXAnchor),
      icon.widthAnchor.constraint(equalToConstant: 116),
      icon.heightAnchor.constraint(equalToConstant: 116)
    ])
    NSLayoutConstraint(
      item: icon,
      attribute: .centerY,
      relatedBy: .equal,
      toItem: errorStateView,
      attribute: .centerY,
      multiplier: 0.8,
      constant: -1
    ).isActive = true

    // Title
    let titleLabel = UILabel()
    titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
    titleLabel.textColor = UIColor.Zeplin.black
    titleLabel.text = "ooops, tivemos um problema"
    titleLabel.textAlignment = .center
    errorStateView.addSubview(titleLabel)

    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      titleLabel.leadingAnchor.constraint(
        equalTo: errorStateView.leadingAnchor,
        constant: 24
      ),
      titleLabel.trailingAnchor.constraint(
        equalTo: errorStateView.trailingAnchor,
        constant: -24
      ),
      titleLabel.topAnchor.constraint(equalTo: icon.bottomAnchor, constant: 20)
    ])

    // Button
    errorStateView.addSubview(errorStateButton)

    errorStateButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      errorStateButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 32),
      errorStateButton.centerXAnchor.constraint(equalTo: errorStateView.centerXAnchor)
    ])

    errorStateButton.callback = onRefreshAction
  }
}
