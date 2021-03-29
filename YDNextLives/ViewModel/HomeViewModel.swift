//
//  HomeViewModel.swift
//  YDNextLives
//
//  Created by Douglas Hennrich on 24/03/21.
//

import Foundation

import YDExtensions
import YDUtilities

protocol HomeNavigation {
  func onExit()
}

protocol HomeViewModelDelegate: AnyObject {
  var loading: Binder<Bool> { get }

  func onExit()
  func getNextLives()
}

class HomeViewModel {
  // MARK: Properties
  let navigation: HomeNavigation

  var loading: Binder<Bool> = Binder(false)

  // MARK: Init
  init(navigation: HomeNavigation) {
    self.navigation = navigation
  }
}

extension HomeViewModel: HomeViewModelDelegate {
  func onExit() {
    navigation.onExit()
  }

  func getNextLives() {
    print(#function)
    loading.value = true

    Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { [weak self] _ in
      guard let self = self else { return }
      self.loading.value = false
    }
  }
}
