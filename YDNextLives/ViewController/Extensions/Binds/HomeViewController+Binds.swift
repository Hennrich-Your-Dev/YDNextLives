//
//  HomeViewController+Binds.swift
//  YDNextLives
//
//  Created by Douglas Hennrich on 29/03/21.
//

import UIKit

// MARK: Binds
extension HomeViewController {
  func setUpBinds() {
    viewModel?.loading.bind { [weak self] isLoading in
      guard let self = self else { return }
      self.shimmer = isLoading

      if isLoading {
        DispatchQueue.main.async {
          self.tableView.reloadData()
          self.tableView.contentOffset = CGPoint(x: 0, y: -50)
        }
      }
    }

    viewModel?.nextLives.bind { [weak self] list in
      guard let self = self else { return }

      if list.isEmpty {
        self.tableView.isHidden = true
        self.emptyStateView.isHidden = false
      } else {
        self.shimmer = false
        self.tableView.reloadData()
      }
    }
  }
}
