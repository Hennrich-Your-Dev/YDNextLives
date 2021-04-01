//
//  HomeViewController+TableView.swift
//  YDNextLives
//
//  Created by Douglas Hennrich on 28/03/21.
//

import UIKit

import YDExtensions
import YDB2WComponents

// MARK: Data Source
extension HomeViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if shimmer {
      return numberOfShimmers
    }

    return viewModel?.nextLives.value.count ?? 0
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if shimmer {
      guard let cell = tableView.dequeueReusableCell(
        withIdentifier: LiveShimmerTableViewCell.identifier,
        for: indexPath
      ) as? LiveShimmerTableViewCell
      else {
        fatalError("dequeue LiveShimmerTableViewCell")
      }

      cell.shimmerCell()
      return cell
    }

    guard let cell = tableView.dequeueReusableCell(
      withIdentifier: LiveTableViewCell.identifier,
      for: indexPath
    ) as? LiveTableViewCell,
    let currentLive = viewModel?.nextLives.value.at(indexPath.row)
    else {
      fatalError("dequeue LiveTableViewCell")
    }

    cell.config(withLive: currentLive)

    cell.callback = { [weak self] in
      guard let self = self else { return }

      self.schedule(event: currentLive) { success in
        self.eventKitCallback = nil

        if success {
          Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
            YDPopOverMessage.show("adicionado ao calendário!", icon: nil)
          }
          currentLive.alreadyScheduled = true
          tableView.reloadRows(at: [indexPath], with: .fade)
        }
      }
    }

    return cell
  }
}
