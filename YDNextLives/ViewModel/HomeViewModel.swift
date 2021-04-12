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

  private let savedLivesName = "alreadyScheduledLives"
  private let defaults = UserDefaults.standard

  var loading: Binder<Bool> = Binder(false)
  var error: Binder<Bool> = Binder(false)
  var nextLives: Binder<[NextLive]> = Binder([])
  let alreadyScheduledLives: AlreadyScheduledLivesManager

  // MARK: Init
  init(navigation: HomeNavigation) {
    self.navigation = navigation
    alreadyScheduledLives = AlreadyScheduledLivesManager()
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

      let lives = [
        NextLive.fromMock(
          id: "1",
          startTime: "2021-04-012T18:20:00",
          endTime: "2021-04-012T19:00:00"
        ),
        NextLive.fromMock(id: "2"),
        NextLive.fromMock(id: "3"),
        NextLive.fromMock(id: "4"),
        NextLive.fromMock(id: "5")
      ]

      for live in lives {
        guard let id = live.liveId else { continue }

        if self.alreadyScheduledLives.checkIfExists(id) {
          live.alreadyScheduled = true
        }
      }

      self.nextLives.value = lives
      //      self.nextLives.value = []
      //      self.error.value = true
    }
  }
}
