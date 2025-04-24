import Foundation
import XCTest

@testable import MyApp

@MainActor
final class MyAppTests: XCTestCase {
  func test_twoPlusTwo_isFour() {
    XCTAssertEqual(2 + 2, 4)
  }

  @MainActor
  func test_timeModuleBasics() {
    // TimeViewModel과 TimeView가 프로젝트에 올바르게 통합되어 있는지 확인
    let viewModel = TimeViewModel()
    XCTAssertNotNil(viewModel)

    // 기본 TimeView 생성 가능 확인
    let view = TimeView(showMenu: .constant(false))
    XCTAssertNotNil(view)
  }
}

// MainActor와 무관한 테스트는 별도 클래스로 분리
final class TimeModelTests: XCTestCase {
  func test_timeModelDecoding() {
    // TimeModel이 디코딩 가능한지 확인
    let jsonString = """
      {
          "dateTime": "2025-04-10T12:34:56.789",
          "date": "2025-04-10",
          "time": "12:34:56"
      }
      """

    guard let data = jsonString.data(using: .utf8) else {
      XCTFail("JSON 데이터 생성 실패")
      return
    }

    do {
      let model = try JSONDecoder().decode(TimeModel.self, from: data)
      XCTAssertEqual(model.date, "2025-04-10")
      XCTAssertEqual(model.time, "12:34:56")
      XCTAssertEqual(model.dateTime, "2025-04-10T12:34:56.789")
    } catch {
      XCTFail("TimeModel 디코딩 실패: \(error)")
    }
  }
}
