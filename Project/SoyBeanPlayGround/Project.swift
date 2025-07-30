import ProjectDescription

    
let project = Project(
    name: "SoyBeanPlayGround",
    packages: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.9.1")),
        .package(url: "https://github.com/Moya/Moya.git", .upToNextMajor(from: "15.0.0")),
        .package(url: "https://github.com/devxoul/Then.git", .upToNextMajor(from: "3.0.0")),
        .package(url: "https://github.com/SnapKit/SnapKit.git", .upToNextMajor(from: "5.7.1")),
        .package(url: "https://github.com/onevcat/Kingfisher.git", .upToNextMajor(from: "8.0.3")),
        .package(url: "https://github.com/airbnb/lottie-spm.git", .upToNextMajor(from: "4.5.0")),
        .package(url: "https://github.com/Swinject/Swinject.git", .upToNextMajor(from: "2.9.0")),
        .package(url: "https://github.com/GuTaeHo/SoyBean.git", .branch("develop")),
        .package(url: "https://github.com/kean/Pulse.git", .upToNextMajor(from: "5.0.0")),
        .package(url: "https://github.com/kasketis/netfox.git", .upToNextMajor(from: "1.0.0"))
    ],
    targets: [
        .target(
            name: "SoyBeanPlayGround",
            destinations: .iOS,
            product: .app,
            bundleId: "com.example.SoyBeanPlayGround",
            deploymentTargets: .iOS("15.0"),
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": "",
                    ],
                ]
            ),
            sources: ["SoyBeanPlayGround/Sources/**"],
            resources: ["SoyBeanPlayGround/Resources/**"],
            dependencies: [
                .package(product: "Alamofire"),
                .package(product: "Moya"),
                .package(product: "Then"),
                .package(product: "SnapKit"),
                .package(product: "Kingfisher"),
                .package(product: "Lottie"),
                .package(product: "Swinject"),
                .package(product: "SoyBeanUI"),
                .package(product: "SoyBeanCore"),
                .package(product: "SoyBeanUtil"),
                .package(product: "SoyBean"),
                .package(product: "Pulse"),
                .package(product: "PulseUI"),
                .package(product: "netfox"),
            ],
            settings: .settings(
                base: [
                // 자동 서명
                "CODE_SIGN_STYLE": "Automatic",
                // Apple Developer Team ID
                "DEVELOPMENT_TEAM": "3MDWMG7Z69",
                ],
            )
        ),
        .target(
            name: "SoyBeanPlayGroundTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "com.example.SoyBeanPlayGroundTests",
            infoPlist: .default,
            sources: ["SoyBeanPlayGround/Tests/**"],
            resources: [],
            dependencies: [.target(name: "SoyBeanPlayGround")]
        ),
    ]
)
