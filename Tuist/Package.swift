// swift-tools-version: 5.9
import PackageDescription

#if TUIST
import ProjectDescription



#endif

let package = Package(
  name: "OnboardingKit",
  dependencies: [
    .package(
      url: "http://github.com/pointfreeco/swift-composable-architecture",
      revision: "1f952d8c69ace5e53bb69a218e6ed00e03a4695c" // 1.11.2
    ),
    .package(
      url: "https://github.com/Moya/Moya",
      revision: "c263811c1f3dbf002be9bd83107f7cdc38992b26" // 15.0.3
    ),
    .package(
      url: "https://github.com/kishikawakatsumi/KeychainAccess.git",
      revision: "84e546727d66f1adc5439debad16270d0fdd04e7" // 4.2.2
    ),
    .package(
      url: "https://github.com/onevcat/Kingfisher.git",
      revision: "2ef543ee21d63734e1c004ad6c870255e8716c50" // 7.12.0
    ),
    .package(
      url: "https://github.com/CSolanaM/SkeletonUI.git",
      revision: "f025e9ba5d051374d7344efa8859df5b9399a181" // 2.0.2
    ),
    .package(
      url: "https://github.com/kakao/kakao-ios-sdk.git",
      branch: "master"
    )
  ],
  targets: [
    .target(
      name: "OnboardingKit",
      dependencies: ["CombineMoya", "KakaoSDKAuth", "KakaoSDKUser"])
  ]
)
