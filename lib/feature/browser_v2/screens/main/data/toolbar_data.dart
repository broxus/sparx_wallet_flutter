class ToolbarData {
  ToolbarData({
    bool? isCanGoBack,
    bool? isCanGoForward,
  })  : isCanGoBack = isCanGoBack ?? false,
        isCanGoForward = isCanGoForward ?? false;

  final bool isCanGoBack;
  final bool isCanGoForward;
}
