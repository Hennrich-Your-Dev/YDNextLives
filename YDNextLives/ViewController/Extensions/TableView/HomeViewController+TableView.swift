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
    if shimmer {
      return numberOfShimmers
    }

    return 8
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if shimmer {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: LiveShimmerTableViewCell.identifier, for: indexPath) as? LiveShimmerTableViewCell
      else {
        fatalError("dequeue LiveShimmerTableViewCell")
      }

      cell.shimmerCell()
      return cell
    }

    guard let cell = tableView.dequeueReusableCell(
      withIdentifier: LiveTableViewCell.identifier,
      for: indexPath
    ) as? LiveTableViewCell
    else {
      fatalError("dequeue LiveTableViewCell")
    }

    cell.setStyle(actived: indexPath.row == 0)
    cell.config()

    return cell
  }
}

// MARK: Delegate
extension HomeViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    return tableView.dequeueReusableHeaderFooterView(withIdentifier: LiveFooterView.identifier)
  }
}
