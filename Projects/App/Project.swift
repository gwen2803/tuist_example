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
      sources: ["Sources/**"],
      resources: ["Resources/**"],
      dependencies: [
        .external(name: "ViewInspector"),
        .project(target: "TimeView", path: .relativeToRoot("Projects/Features/TimeView")),
      ]
    ),
    .target(
      name: "MyAppTests",
      destinations: .iOS,
      product: .unitTests,
      bundleId: "io.tuist.MyAppTests",
      infoPlist: .default,
      sources: ["Tests/**"],
      resources: [],
      dependencies: [
        .target(name: "MyApp"),
        .external(name: "ViewInspector"),
      ]
    ),
  ],
  schemes: [
    .scheme(
      name: "MyApp_Debug",
      buildAction: .buildAction(targets: [
        .target("MyApp")
      ]),
      runAction: .runAction(configuration: "Debug")
    ),
    .scheme(
      name: "MyApp_Release",
      buildAction: .buildAction(targets: [
        .target("MyApp")
      ]),
      runAction: .runAction(configuration: "Release")
    ),
    .scheme(
      name: "MyApp_Test",
      buildAction: .buildAction(targets: [
        .target("MyAppTests")
      ]),
      runAction: .runAction(configuration: "Test")
    ),
  ]
)
