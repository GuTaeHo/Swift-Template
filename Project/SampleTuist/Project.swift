import ProjectDescription

let project = Project(
    name: "SampleTuist",
    targets: [
        .target(
            name: "SampleTuist",
            destinations: .iOS,
            product: .app,
            bundleId: "io.tuist.SampleTuist",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchStoryboardName": "LaunchScreen.storyboard",
                ]
            ),
            sources: ["SampleTuist/Sources/**"],
            resources: ["SampleTuist/Resources/**"],
            dependencies: []
        ),
        .target(
            name: "SampleTuistTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.SampleTuistTests",
            infoPlist: .default,
            sources: ["SampleTuist/Tests/**"],
            resources: [],
            dependencies: [.target(name: "SampleTuist")]
        ),
    ]
)
