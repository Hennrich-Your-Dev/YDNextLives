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
  let emptyStateView = UIView()
  let errorStateView = UIView()

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
