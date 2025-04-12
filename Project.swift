import ProjectDescription

let project = Project(
  name: "MyApp",
  settings: .settings(configurations: [
    .release(
      name: "Release",
      xcconfig: .relativeToRoot("Xcconfigs/release.xcconfig")
    ),
    .debug(
      name: "Debug",
      xcconfig: .relativeToRoot("Xcconfigs/debug.xcconfig")
    ),
    .debug(
      name: "Test",
      xcconfig: .relativeToRoot("Xcconfigs/test.xcconfig")
    ),
  ]),
  targets: [
    .target(
      name: "MyApp",
      destinations: .iOS,
      product: .app,
      bundleId: "io.tuist.MyApp",
      infoPlist: .extendingDefault(
        with: [
          "UILaunchScreen": [
            "UIColorName": "",
            "UIImageName": "",
          ]
        ]
      ),
      sources: ["Targets/MyApp/Sources/**"],
      resources: ["Targets/MyApp/Resources/**"],
      dependencies: []
    ),
    .target(
      name: "MyAppTests",
      destinations: .iOS,
      product: .unitTests,
      bundleId: "io.tuist.MyAppTests",
      infoPlist: .default,
      sources: ["Targets/MyAppTests/Sources/**"],
      resources: [],
      dependencies: [.target(name: "MyApp")]
    ),
  ],
  schemes: [
    .scheme(
      name: "Tuisttest_Debug",
      buildAction: .buildAction(targets: [
        .target("MyApp")
      ]),
      runAction: .runAction(configuration: "Debug")
    ),
    .scheme(
      name: "Tuisttest_Release",
      buildAction: .buildAction(targets: [
        .target("MyApp")
      ]),
      runAction: .runAction(configuration: "Release")
    ),
    .scheme(
      name: "Tuisttest_Test",
      buildAction: .buildAction(targets: [
        .target("MyAppTests")
      ]),
      runAction: .runAction(configuration: "Test")
    ),
  ]
)
