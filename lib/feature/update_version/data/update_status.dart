/// Represents the status of an app update
enum UpdateStatus {
  /// A blocking update is required (user must update to continue)
  blocking,

  /// A warning update is recommended (user can dismiss)
  warning,

  /// No update is required
  none,
}
