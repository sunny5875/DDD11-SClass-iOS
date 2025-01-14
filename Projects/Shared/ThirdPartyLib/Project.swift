import Foundation
import ProjectDescription
import DependencyPlugin
import ProjectTemplatePlugin
import DependencyPackagePlugin

let project = Project.makeModule(
  name: "SharedThirdPartyLib",
  bundleId: .appBundleID(name: "Shared.ThirdPartyLib"),
  product: .staticFramework,
  settings: .settings(),
  dependencies: [
    .SPM.composableArchitecture,
    .SPM.moya,
    .SPM.combineMoya,
    .SPM.keychainAccess,
    .SPM.kingfisher,
    .SPM.skeletonUI,
    .SPM.kakaoSDKAuth,
    .SPM.kakaoSDKUser
  ],
  sources: ["Sources/**"]
)
