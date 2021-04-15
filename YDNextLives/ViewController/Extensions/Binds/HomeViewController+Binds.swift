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
          self.tableView.isHidden = false
          self.tableView.reloadData()
        }
      }
    }

    viewModel?.nextLives.bind { [weak self] list in
      guard let self = self else { return }

      if list.isEmpty {
        self.shimmer = true
        self.showEmptyState()
      } else {
        self.shimmer = false
        self.tableView.reloadData()
      }
    }

    viewModel?.error.bind { [weak self] _ in
      guard let self = self else { return }
      self.shimmer = true
      self.showErrorState()
    }
  }
}
