import ProjectDescription

let workspace = Workspace(
  name: "MyAppWorkspace",
  projects: [
    "Projects/App",
    "Projects/Features/TimeView",
  ],
  fileHeaderTemplate: nil,
  additionalFiles: []
)
