//
//  HomeViewController+EventKit.swift
//  YDNextLives
//
//  Created by Douglas Hennrich on 31/03/21.
//

import UIKit
import EventKit

import YDB2WComponents
import YDB2WAssets

extension HomeViewController {
  func schedule(event: NextLive, onCompletion completion: @escaping (Bool) -> Void) {
    eventKitCallback = completion
    let eventStore = EKEventStore()

    switch EKEventStore.authorizationStatus(for: .event) {
      case .notDetermined:
        DispatchQueue.main.async { [weak self] in
          guard let self = self else { return }

          eventStore.requestAccess(to: .event) { granted, error in
            if granted {
              self.callEventController(withLive: event, eventStore)
            } else {
              DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                let alert = YDDialog()
                alert.delegate = self
                alert.start(
                  ofType: .withIcon,
                  customIcon: Icons.scheduleLive,
                  customTitle: "poooxa, você não nos deu acesso ao calendário!",
                  customMessage: "precisamos acessar seu calendário para salvar a próxima live nele! habilite em configurações!",
                  customButton: "habilitar",
                  customCancelButton: "agora não"
                )
              }
            }
          }
        }
      case .authorized:
        callEventController(withLive: event, eventStore)

      case .denied:
        DispatchQueue.main.async { [weak self] in
          guard let self = self else { return }

          let alert = YDDialog()
          alert.delegate = self
          alert.start(
            ofType: .withIcon,
            customIcon: Icons.scheduleLive,
            customTitle: "poooxa, você não nos deu acesso ao calendário!",
            customMessage: "precisamos acessar seu calendário para salvar a próxima live nele! habilite em configurações!",
            customButton: "habilitar",
            customCancelButton: "agora não"
          )
        }
      default:
        break
    }
  }

  func callEventController(withLive live: NextLive, _ eventStore: EKEventStore) {
    guard let startTime = live.initialDate?.date(withFormat: "yyyy-MM-dd'T'HH:mm:ss"),
          let endTime = live.finalDate?.date(withFormat: "yyyy-MM-dd'T'HH:mm:ss")
    else { return }

    let calendar = eventStore.defaultCalendarForNewEvents
    let event = EKEvent(eventStore: eventStore)
    event.title = live.name
    event.startDate = startTime
    event.endDate = endTime
    event.calendar = calendar
    event.addAlarm(EKAlarm(relativeOffset: -15 * 60))

    try? eventStore.save(event, span: .thisEvent, commit: true)
    eventKitCallback?(true)
  }
}

// MARK: YDDialog Delegate
extension HomeViewController: YDDialogCoordinatorDelegate {
  func onActionYDDialog(payload: [String: Any]?) {
    guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
      return
    }

    if UIApplication.shared.canOpenURL(settingsUrl) {
      UIApplication.shared.open(settingsUrl)
    }
  }

  func onCancelYDDialog(payload: [String: Any]?) {}
}
