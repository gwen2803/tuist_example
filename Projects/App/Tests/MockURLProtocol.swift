import Foundation

@testable import MyApp

class MockURLProtocol: URLProtocol {
  static var mockURLs = [URL?: (Data, HTTPURLResponse)]()

  override class func canInit(with request: URLRequest) -> Bool {
    return true
  }

  override class func canonicalRequest(for request: URLRequest) -> URLRequest {
    return request
  }

  override func startLoading() {
    guard let url = request.url else {
      client?.urlProtocolDidFinishLoading(self)
      return
    }

    if let (data, response) = MockURLProtocol.mockURLs[url] {
      client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
      client?.urlProtocol(self, didLoad: data)
    } else {
      let response = HTTPURLResponse(
        url: url, statusCode: 404, httpVersion: nil, headerFields: nil)!
      client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
    }

    client?.urlProtocolDidFinishLoading(self)
  }

  override func stopLoading() {}

  // 유틸리티 메서드 - TimeAPI 응답 모킹
  static func mockTimeAPIResponse() {
    let jsonString = """
      {
          "dateTime": "2025-04-10T12:34:56.789",
          "date": "2025-04-10",
          "time": "12:34:56"
      }
      """

    guard let data = jsonString.data(using: .utf8),
      let url = URL(string: "https://timeapi.io/api/Time/current/zone?timeZone=UTC")
    else {
      return
    }

    let response = HTTPURLResponse(
      url: url,
      statusCode: 200,
      httpVersion: nil,
      headerFields: ["Content-Type": "application/json"]
    )!

    mockURLs[url] = (data, response)
  }

  static func setupMockSession() -> URLSession {
    let configuration = URLSessionConfiguration.ephemeral
    configuration.protocolClasses = [MockURLProtocol.self]
    return URLSession(configuration: configuration)
  }
}
