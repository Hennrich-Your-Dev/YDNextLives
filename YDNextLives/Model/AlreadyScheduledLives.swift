//
//  AlreadyScheduledLives.swift
//  YDNextLives
//
//  Created by Douglas Hennrich on 12/04/21.
//

import Foundation

import YDExtensions
import YDB2WModels

class AlreadyScheduledLivesManager {
  // MARK: Properties
  private let defaults = UserDefaults.standard
  private let savedLivesPropertyName = "alreadyScheduledLives"

  private var lives: [ScheduledLive] = []

  // MARK: Init
  init() {
    guard let data = defaults.object(forKey: savedLivesPropertyName) as? Data,
          let saved = try? JSONDecoder().decode([ScheduledLive].self, from: data)
    else { return }

    pruneOldLives(from: saved)
  }
}

// MARK: Actions
extension AlreadyScheduledLivesManager {
  private func pruneOldLives(from saved: [ScheduledLive]) {
    var cleanLives: [ScheduledLive] = saved
    var indexesToRemove: [Int] = []
    var needToSave = false

    for (index, curr) in cleanLives.enumerated() {
      guard let endTimePlusOne = Calendar.current.date(byAdding: .day, value: 1, to: curr.endTime)
      else { continue }

      if endTimePlusOne.isInPast,
         cleanLives.at(index) != nil {
        indexesToRemove.append(index)

        if !needToSave {
          needToSave = true
        }
      }
    }

    if !indexesToRemove.isEmpty {
      indexesToRemove.reverse()
      indexesToRemove.forEach {
        if cleanLives.at($0) != nil {
          cleanLives.remove(at: $0)
        }
      }
    }

    lives = cleanLives

    if needToSave {
      save()
    }
  }

  private func save() {
    guard let encoded = try? JSONEncoder().encode(lives) else { return }
    defaults.set(encoded, forKey: savedLivesPropertyName)
  }

  func add(_ live: YDSpaceyComponentNextLive) {
    guard let id = live.liveId,
      lives.firstIndex(where: { $0.id == id }) == nil,
      let endTime = live.finalDateAsDate
    else { return }

    lives.append(ScheduledLive(id: id, endTime: endTime))
    save()
  }

  func checkIfExists(_ id: String) -> Bool {
    return lives.firstIndex(where: { $0.id == id }) != nil
  }
}

// MARK: Struct
struct ScheduledLive: Codable {
  let id: String
  let endTime: Date
}
