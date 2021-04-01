//
//  HomeViewController+EventKit.swift
//  YDNextLives
//
//  Created by Douglas Hennrich on 31/03/21.
//

import UIKit
import EventKitUI

extension HomeViewController {
  func schedule(event: NextLive, onCompletion completion: @escaping (Bool) -> Void) {
    eventKitCallback = completion
    switch EKEventStore.authorizationStatus(for: .event) {
      case .notDetermined:
        let eventStore = EKEventStore()

        DispatchQueue.main.async { [weak self] in
          guard let self = self else { return }

          eventStore.requestAccess(to: .event) { granted, error in
            if granted {
              self.callEventController(withLive: event)
            }
          }
        }
      case .authorized:
        callEventController(withLive: event)
      default:
        break
    }
  }

  func callEventController(withLive live: NextLive) {
    guard let startTime = live.initialDate?.date(withFormat: "yyyy-MM-dd'T'HH:mm:ss"),
          let endTime = live.finalDate?.date(withFormat: "yyyy-MM-dd'T'HH:mm:ss")
    else { return }

    DispatchQueue.main.async { [weak self] in
      guard let self = self else { return }

      let eventVC = EKEventEditViewController()
      eventVC.editViewDelegate = self
      eventVC.eventStore = EKEventStore()

      let event = EKEvent(eventStore: eventVC.eventStore)
      event.title = live.name
      event.startDate = startTime
      event.endDate = endTime

      eventVC.event = event
      self.present(eventVC, animated: true)
    }
  }
}

// MARK: EKEventEditViewDelegate
extension HomeViewController: EKEventEditViewDelegate {
  func eventEditViewController(
    _ controller: EKEventEditViewController,
    didCompleteWith action: EKEventEditViewAction
  ) {
    eventKitCallback?(action == .saved)

    controller.dismiss(animated: true, completion: nil)
  }
}
