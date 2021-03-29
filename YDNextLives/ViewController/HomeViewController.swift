//
//  HomeViewController.swift
//  YDNextLives
//
//  Created by Douglas Hennrich on 24/03/21.
//

import UIKit

class HomeViewController: UIViewController {
  // MARK: Properties
  var viewModel: HomeViewModelDelegate?
  let cellHeightSize: CGFloat = 154
  var shimmer = true
  var numberOfShimmers = 0

  // MARK: Components
  let tableView = UITableView()

  // MARK: View life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpLayouts()
    setUpBinds()
    viewModel?.getNextLives()
  }
}

// MARK: Actions
extension HomeViewController {
  @objc func onBackAction() {
    viewModel?.onExit()
  }
}

// MARK: Binds
extension HomeViewController {
  func setUpBinds() {
    viewModel?.loading.bind { [weak self] isLoading in
      guard let self = self else { return }
      self.shimmer = isLoading
      self.tableView.reloadData()

      if isLoading {
        DispatchQueue.main.async {
          self.tableView.contentOffset = CGPoint(x: 0, y: -50)
        }
      }
    }
  }
}
