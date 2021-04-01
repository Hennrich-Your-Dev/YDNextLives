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
  var error: Binder<Bool> { get }
  var nextLives: Binder<[NextLive]> { get }

  func onExit()
  func getNextLives()
}

class HomeViewModel {
  // MARK: Properties
  let navigation: HomeNavigation

  var loading: Binder<Bool> = Binder(false)
  var error: Binder<Bool> = Binder(false)
  var nextLives: Binder<[NextLive]> = Binder([])

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
    loading.value = true

    Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { [weak self] _ in
      guard let self = self else { return }
      self.loading.value = false
      self.nextLives.value = [
        NextLive.fromMock(startTime: "2021-04-01T13:20:00", endTime: "2021-04-01T19:00:00"),
        NextLive.fromMock(),
        NextLive.fromMock(),
        NextLive.fromMock(),
        NextLive.fromMock()
      ]
    }
  }
}
