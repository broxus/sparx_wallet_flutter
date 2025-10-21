enum AppBuildType { development, staging, production }

extension AppBuildTypeExt on AppBuildType {
  bool get isDevelopment => this == AppBuildType.development;
}
