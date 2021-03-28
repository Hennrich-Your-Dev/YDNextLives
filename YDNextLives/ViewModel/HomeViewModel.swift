//
//  HomeViewModel.swift
//  YDNextLives
//
//  Created by Douglas Hennrich on 24/03/21.
//

import Foundation

protocol HomeNavigation {
  func onExit()
}

protocol HomeViewModelDelegate: AnyObject {
  func onExit()
}

class HomeViewModel {
  // MARK: Properties
  let navigation: HomeNavigation

  // MARK: Init
  init(navigation: HomeNavigation) {
    self.navigation = navigation
  }
}

extension HomeViewModel: HomeViewModelDelegate {
  func onExit() {
    navigation.onExit()
  }
}
