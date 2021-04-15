//
//  HomeViewController.swift
//  YDNextLives
//
//  Created by Douglas Hennrich on 24/03/21.
//

import UIKit
import YDB2WComponents

class HomeViewController: UIViewController {
  // MARK: Properties
  var viewModel: HomeViewModelDelegate?
  let cellHeightSize: CGFloat = 154
  var shimmer = true
  var numberOfShimmers = 0
  var eventKitCallback: ((Bool) -> Void)?

  // MARK: Components
  let tableView = UITableView()
  let emptyStateView = UIView()
  let errorStateView = UIView()
  let errorStateButton = YDWireButton(withTitle: "atualizar lista de lives")

  // MARK: View life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpLayouts()
    setUpBinds()
    viewModel?.getNextLives()
    tableView.contentOffset = CGPoint(x: 0, y: -cellHeightSize)
  }
}

// MARK: Actions
extension HomeViewController {
  @objc func onBackAction() {
    viewModel?.onExit()
  }

  @objc func onRefreshAction(_ sender: UIButton) {
    self.emptyStateView.isHidden = true
    self.errorStateView.isHidden = true
    self.tableView.contentOffset = .zero
    viewModel?.getNextLives()
  }

  func showEmptyState() {
    DispatchQueue.main.async { [weak self] in
      guard let self = self else { return }
      self.tableView.isHidden = true
      self.errorStateView.isHidden = true
      self.emptyStateView.isHidden = false
    }
  }

  func showErrorState() {
    DispatchQueue.main.async { [weak self] in
      guard let self = self else { return }
      self.tableView.isHidden = true
      self.emptyStateView.isHidden = true
      self.errorStateView.isHidden = false
    }
  }
}
