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

  // MARK: Computed variables
  var formatedDate: String? {
    guard let initialDateFormat = initialDate?.date(withFormat: "yyyy-MM-dd'T'HH:mm:ss"),
          let finalDateFormat = finalDate?.date(withFormat: "yyyy-MM-dd'T'HH:mm:ss")
    else { return nil }

    if initialDateFormat.isInToday {
      let todayDate = "ao vivo •"
      let startTime = initialDateFormat.toFormat("HH:mm")
      let endTime = finalDateFormat.toFormat("HH:mm")

      return todayDate + " \(startTime)-\(endTime)"
    } else {
      let startTime = initialDateFormat.toFormat("dd/MM '•' HH:mm")
      let endTime = finalDateFormat.toFormat("HH:mm")
      return "\(startTime)-\(endTime)"
    }
  }

  var isToday: Bool {
    guard let date = initialDate?.date(withFormat: "yyyy-MM-dd'T'HH:mm:ss")
    else {
      return false
    }

    return date.isInToday
  }

  // MARK: CodingKeys
  enum CodingKeys: String, CodingKey {
    case liveId
    case photo
    case initialDate
    case finalDate
    case name
    case description
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
  static func fromMock() -> NextLive {
    return NextLive(
      liveId: "\(Int.random(in: 0..<100))",
      photo: "https://miro.medium.com/max/875/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg",
      initialDate: "2021-04-01T21:00:00",
      finalDate: "2021-04-01T22:00:00",
      name: "Nome da Live",
      description: .loremIpsum()
    )
  }
}
