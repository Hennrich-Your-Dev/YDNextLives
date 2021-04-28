//
//  HomeViewModel.swift
//  YDNextLives
//
//  Created by Douglas Hennrich on 24/03/21.
//

import Foundation

import YDExtensions
import YDUtilities
import YDB2WModels

protocol HomeNavigation {
  func onExit()
}

protocol HomeViewModelDelegate: AnyObject {
  var loading: Binder<Bool> { get }
  var error: Binder<Bool> { get }
  var nextLives: Binder<[YDSpaceyComponentNextLive]> { get }

  func onExit()
  func getNextLives()
  func saveLive(_ live: YDSpaceyComponentNextLive)
}

class HomeViewModel {
  // MARK: Properties
  let navigation: HomeNavigation

  private let savedLivesName = "alreadyScheduledLives"
  private let defaults = UserDefaults.standard

  var loading: Binder<Bool> = Binder(false)
  var error: Binder<Bool> = Binder(false)
  var nextLives: Binder<[YDSpaceyComponentNextLive]> = Binder([])
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

      let lives: [YDSpaceyComponentNextLive] = [1, 2, 3, 4, 5].map {
        YDSpaceyComponentNextLive.fromMock(
          id: "\($0)",
          startTime: "\(25 + $0)/04/2021 18:00",
          endTime: "\(25 + $0)/04/2021 19:00"
        )
      }

      for live in lives {
        guard let id = live.liveId else { continue }

        if self.alreadyScheduledLives.checkIfExists(id) {
          live.alreadyScheduled = true
        }
      }

      self.nextLives.value = lives
//        self.nextLives.value = []
//        self.error.value = true
    }
  }

  func saveLive(_ live: YDSpaceyComponentNextLive) {
    alreadyScheduledLives.add(live)
  }
}
