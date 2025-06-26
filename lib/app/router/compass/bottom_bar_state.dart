/// Defines the visibility state of the bottom navigation bar.
///
/// This enum is used to control how the bottom navigation bar
/// should be displayed in different parts of the application,
/// supporting edge-to-edge layout implementation.
enum BottomBarState {
  /// The bottom navigation bar is fully visible and expanded.
  /// Used for main screens like Wallet, Browser (when not scrolled), etc.
  expanded,

  /// The bottom navigation bar is partially visible or collapsed.
  /// Used for screens like Profile or Browser when content is scrolled.
  collapsed,

  /// The bottom navigation bar is completely hidden.
  /// Used for fullscreen experiences or detail pages
  /// where navigation should not be visible.
  hidden,
}
