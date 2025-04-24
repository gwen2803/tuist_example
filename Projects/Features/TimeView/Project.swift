import ProjectDescription

let project = Project(
  name: "TimeView",
  settings: .settings(configurations: [
    .release(name: "Release"),
    .debug(name: "Debug"),
    .debug(name: "Test"),
  ]),
  targets: [
    .target(
      name: "TimeView",
      destinations: .iOS,
      product: .framework,
      bundleId: "io.tuist.TimeView",
      infoPlist: .default,
      sources: ["Sources/**"],
      resources: [],
      dependencies: [
        .external(name: "ViewInspector")
      ]
    ),
    .target(
      name: "TimeViewTests",
      destinations: .iOS,
      product: .unitTests,
      bundleId: "io.tuist.TimeViewTests",
      infoPlist: .default,
      sources: ["Tests/**"],
      resources: [],
      dependencies: [
        .target(name: "TimeView"),
        .external(name: "ViewInspector"),
      ]
    ),
  ],
  schemes: [
    .scheme(
      name: "TimeView",
      buildAction: .buildAction(targets: [
        .target("TimeView")
      ]),
      testAction: .targets(["TimeViewTests"]),
      runAction: .runAction(configuration: "Debug")
    )
  ]
)
