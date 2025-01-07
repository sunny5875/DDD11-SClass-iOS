import Foundation
import ProjectDescription
import DependencyPlugin
import ProjectTemplatePlugin

let project = Project.makeModule(
  name: "Feature",
  bundleId: .appBundleID(name: "Feature"),
  product: .staticFramework,
  settings: .settings(),
  dependencies: [
    .feature(implements: .onboarding),
    .feature(implements: .home),
    .feature(implements: .history),
    .feature(implements: .chat),
    .feature(implements: .article),
    .feature(implements: .myPage),
    .feature(implements: .splash),
    .feature(implements: .login),
    .core
  ],
  sources: ["Sources/**"]
)
