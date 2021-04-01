//
//  NextLive.swift
//  YDNextLives
//
//  Created by Douglas Hennrich on 29/03/21.
//

import Foundation

import YDExtensions

class NextLive: Codable {
  // MARK: Properties
  let liveId: String?
  let photo: String?
  let initialDate: String?
  let finalDate: String?
  let name: String?
  let description: String?
  var alreadyScheduled = false

  // MARK: Computed variables
  var formatedDate: String? {
    guard let initialDateFormat = initialDate?.date(withFormat: "yyyy-MM-dd'T'HH:mm:ss"),
          let finalDateFormat = finalDate?.date(withFormat: "yyyy-MM-dd'T'HH:mm:ss")
    else { return nil }

    let startTime = initialDateFormat.toFormat("HH:mm")
    let endTime = finalDateFormat.toFormat("HH:mm")
    let now = Date()

    if initialDateFormat.isInToday &&
        now.isBetween(initialDateFormat, and: finalDateFormat) {
      return "ao vivo • \(startTime)-\(endTime)"
    } else {
      return "\(initialDateFormat.toFormat("dd/MM '•' ")) \(startTime)-\(endTime)"
    }
  }

  var isAvailable: Bool {
    guard let initialDateFormat = initialDate?.date(withFormat: "yyyy-MM-dd'T'HH:mm:ss"),
          let finalDateFormat = finalDate?.date(withFormat: "yyyy-MM-dd'T'HH:mm:ss")
    else { return false }

    let now = Date()

    if initialDateFormat.isInToday &&
        now.isBetween(initialDateFormat, and: finalDateFormat) {
      return !alreadyScheduled
    }

    return false
  }

  // MARK: CodingKeys
  enum CodingKeys: String, CodingKey {
    case liveId = "_id"
    case photo
    case initialDate
    case finalDate
    case name = "liveTitle"
    case description = "liveDescription"
  }

  // MARK: Init
  init(
    liveId: String?,
    photo: String?,
    initialDate: String?,
    finalDate: String?,
    name: String?,
    description: String?
  ) {
    self.liveId = liveId
    self.photo = photo
    self.initialDate = initialDate
    self.finalDate = finalDate
    self.name = name
    self.description = description
  }
}

// MARK: Mock
extension NextLive {
  static func fromMock(startTime: String? = nil, endTime: String? = nil) -> NextLive {
    return NextLive(
      liveId: "\(Int.random(in: 0..<100))",
      photo: "https://miro.medium.com/max/875/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg",
      initialDate: startTime ?? "2021-04-01T21:00:00",
      finalDate: endTime ?? "2021-04-01T22:00:00",
      name: "Nome da Live",
      description: .loremIpsum()
    )
  }
}
