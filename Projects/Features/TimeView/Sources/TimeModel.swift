//
//  TimeModel.swift
//  TimeView
//
//  Created by YONDOLMAC on 4/10/25.
//

import Foundation

public struct TimeModel: Codable {
  public let dateTime: String
  public let date: String
  public let time: String

  public init(dateTime: String, date: String, time: String) {
    self.dateTime = dateTime
    self.date = date
    self.time = time
  }
}
