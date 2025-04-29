import ProjectDescription

//Project(name: <#T##String#>, organizationName: <#T##String?#>, classPrefix: <#T##String?#>, options: <#T##Project.Options#>, packages: <#T##[Package]#>, settings: <#T##Settings?#>, targets: <#T##[Target]#>, schemes: <#T##[Scheme]#>, fileHeaderTemplate: <#T##FileHeaderTemplate?#>, additionalFiles: <#T##[FileElement]#>, resourceSynthesizers: <#T##[ResourceSynthesizer]#>)

    
let project = Project(
    name: "SoyBeanPlayGround",
    packages: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.9.1")),
        .package(url: "https://github.com/devxoul/Then.git", .upToNextMajor(from: "3.0.0")),
        .package(url: "https://github.com/SnapKit/SnapKit.git", .upToNextMajor(from: "5.7.1")),
        .package(url: "https://github.com/onevcat/Kingfisher.git", .upToNextMajor(from: "8.0.3")),
        .package(url: "https://github.com/airbnb/lottie-spm.git", .upToNextMajor(from: "4.5.0")),
        .package(url: "https://github.com/Swinject/Swinject.git", .upToNextMajor(from: "2.9.0")),
        .package(url: "https://github.com/Swinject/Swinject.git", .upToNextMajor(from: "2.9.0")),
        .package(url: "https://github.com/GuTaeHo/SoyBean.git", .branch("main")),
    ],
    targets: [
//        .target(name: <#T##String#>, destinations: <#T##Destinations#>, product: <#T##Product#>, productName: <#T##String?#>, bundleId: <#T##String#>, deploymentTargets: <#T##DeploymentTargets?#>, infoPlist: <#T##InfoPlist?#>, sources: <#T##SourceFilesList?#>, resources: <#T##ResourceFileElements?#>, copyFiles: <#T##[CopyFilesAction]?#>, headers: <#T##Headers?#>, entitlements: <#T##Entitlements?#>, scripts: <#T##[TargetScript]#>, dependencies: <#T##[TargetDependency]#>, settings: <#T##Settings?#>, coreDataModels: <#T##[CoreDataModel]#>, environmentVariables: <#T##[String : EnvironmentVariable]#>, launchArguments: <#T##[LaunchArgument]#>, additionalFiles: <#T##[FileElement]#>, buildRules: <#T##[BuildRule]#>, mergedBinaryType: <#T##MergedBinaryType#>, mergeable: <#T##Bool#>, onDemandResourcesTags: <#T##OnDemandResourcesTags?#>)
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
                .package(product: "Then"),
                .package(product: "SnapKit"),
                .package(product: "Kingfisher"),
                .package(product: "Lottie"),
                .package(product: "Swinject"),
                .package(product: "SoyBeanUI"),
                .package(product: "SoyBeanCore"),
                .package(product: "SoyBeanUtil")
            ]
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
