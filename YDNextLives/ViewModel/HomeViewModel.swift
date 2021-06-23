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
import YDB2WServices
import YDB2WIntegration

protocol HomeNavigation {
  func onExit()
}

protocol HomeViewModelDelegate: AnyObject {
  var loading: Binder<Bool> { get }
  var error: Binder<Bool> { get }
  var nextLives: Binder<[YDSpaceyComponentNextLive]> { get }
  var reminderTimeInMinutes: Double { get }

  func onExit()
  func getNextLives()
  func saveLive(_ live: YDSpaceyComponentNextLive)
}

class HomeViewModel {
  // MARK: Properties
  let navigation: HomeNavigation
  let service: YDB2WServiceDelegate
  let spaceyId: String
  lazy var logger = Logger.forClass(Self.self)

  private let savedLivesName = "alreadyScheduledLives"
  private let defaults = UserDefaults.standard

  var loading: Binder<Bool> = Binder(false)
  var error: Binder<Bool> = Binder(false)
  var nextLives: Binder<[YDSpaceyComponentNextLive]> = Binder([])
  let alreadyScheduledLives = YDManager.NextLives.shared
  var reminderTimeInMinutes: Double = 15

  // MARK: Init
  init(
    navigation: HomeNavigation,
    service: YDB2WServiceDelegate = YDB2WService(),
    spaceyId: String
  ) {
    self.navigation = navigation
    self.service = service
    self.spaceyId = spaceyId

    trackEvent(type: .state)
  }

  func trackEvent(type: TrackType, liveName: String? = nil) {
    if type == .state {
      YDIntegrationHelper.shared.trackEvent(withName: .nextLivesPageView, ofType: .state)
    } else {
      if let liveName = liveName {
        let parameters = TrackEvents.nextLivesAddToCalendar.parameters(body: ["liveName": liveName])
        YDIntegrationHelper.shared.trackEvent(
          withName: .nextLivesAddToCalendar,
          ofType: .action,
          withParameters: parameters
        )
      }
    }
  }
}

extension HomeViewModel: HomeViewModelDelegate {
  func onExit() {
    navigation.onExit()
  }

  func getNextLives() {
    loading.value = true

    service.getNextLives(
      spaceyId: spaceyId
    ) { [weak self] (response: Result<[YDSpaceyComponentNextLive], YDServiceError>) in
      guard let self = self else { return }
      self.loading.value = false

      switch response {
        case .success(let lives):
          let filteredLives = lives.filter { curr in
            guard let initialDate = curr.initialDateAsDate else { return false }
            return !initialDate.isInPast
          }

          let sorted = filteredLives.sorted { lhs, rhs -> Bool in
            guard let dateLhs = lhs.initialDateAsDate else { return false }
            guard let dateRhs = rhs.initialDateAsDate else { return true }

            return dateLhs.compare(dateRhs) == .orderedAscending
          }

          self.nextLives.value = sorted

        case .failure(let error):
          self.logger.error(error.message)
          self.error.value = true
      }
    }
  }

  func saveLive(_ live: YDSpaceyComponentNextLive) {
    guard let liveId = live.liveId,
          let endTime = live.finalDateAsDate
    else {
      return
    }

    trackEvent(type: .action, liveName: live.name)

    let liveToSave = YDManagerScheduleLive(id: liveId, endTime: endTime)
    alreadyScheduledLives.add(liveToSave)
  }
}
