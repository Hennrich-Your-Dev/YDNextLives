//
//  HomeViewController+TableView.swift
//  YDNextLives
//
//  Created by Douglas Hennrich on 28/03/21.
//

import UIKit

// MARK: Data Source
extension HomeViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 3
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(
      withIdentifier: LiveTableViewCell.identifier,
      for: indexPath
    ) as? LiveTableViewCell
    else {
      fatalError("dequeue LiveTableViewCell")
    }

    return cell
  }
}

// MARK: Delegate
extension HomeViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    return tableView.dequeueReusableHeaderFooterView(withIdentifier: LiveHeaderView.identifier)
  }
}
