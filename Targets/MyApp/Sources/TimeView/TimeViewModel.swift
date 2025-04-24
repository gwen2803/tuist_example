//
//  TimeViewModel.swift
//  MyApp
//
//  Created by YONDOLMAC on 4/10/25.
//

import Combine
import Foundation

@MainActor
final class TimeViewModel: ObservableObject {
  @Published var currentTime: String = ""
  @Published var isLoading: Bool = false
  @Published var errorMessage: String? = nil
  @Published var selectedTimeZone: String = "UTC"

  let availableTimeZones = [
    "UTC", "Asia/Seoul", "America/New_York", "Europe/London", "Asia/Tokyo",
  ]

  private var cancellables = Set<AnyCancellable>()

  func fetchCurrentTime() {
    isLoading = true
    errorMessage = nil

    guard
      let url = URL(string: "https://timeapi.io/api/Time/current/zone?timeZone=\(selectedTimeZone)")
    else {
      currentTime = ""
      errorMessage = "Invalid URL"
      isLoading = false
      return
    }

    URLSession.shared.dataTaskPublisher(for: url)
      .map(\.data)
      .decode(type: TimeModel.self, decoder: JSONDecoder())
      .map { response -> String in
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        if let date = formatter.date(from: response.dateTime) {
          formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
          return formatter.string(from: date)
        } else {
          return "\(response.date) \(response.time)"
        }
      }
      .receive(on: DispatchQueue.main)
      .sink(
        receiveCompletion: { [weak self] completion in
          self?.isLoading = false
          if case let .failure(error) = completion {
            self?.errorMessage = error.localizedDescription
            self?.currentTime = ""
          }
        },
        receiveValue: { [weak self] time in
          self?.currentTime = time
        }
      )
      .store(in: &cancellables)
  }

  func fetchCancel() {
    cancellables.forEach {
      $0.cancel()
    }
  }
}
