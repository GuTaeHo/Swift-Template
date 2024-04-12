// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "naveridlogin-sdk-ios-sample",
    platforms: [.iOS(.v15)],
    products: [
        // Products 는 패키지가 생성하는 실행 파일과 라이브러리를 정의하여 다른 패키지에서도 볼 수 있도록 한다.
        .library(
            name: "NaverThirdPartyLogin",
            targets: ["MySPMPackage"]),
    ],
    targets: [
        // target 은 모듈 또는 테스트 모음을 정의하는 패키지의 기본 구성 요소
        // target 은 이 패키지의 다른 대상과 종속성의 products 에 따라 달라질 수 있다.
//        .target(
//            name: "MySPMPackage"),
        .binaryTarget(name: "NaverThirdPartyLogin", path: "./Frameworks/NaverThirdPartyLogin.xcframework"),
        .testTarget(
            name: "MySPMPackageTests",
            dependencies: ["MySPMPackage"]),
    ]
)
