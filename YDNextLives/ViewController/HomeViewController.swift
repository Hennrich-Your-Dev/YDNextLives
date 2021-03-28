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

  // MARK: Components
  let tableView = UITableView()

  // MARK: View life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.reloadData()
  }
}

// MARK: Actions
extension HomeViewController {
  @objc func onBackAction() {
    viewModel?.onExit()
  }
}
