sealed class TabAnimationType {}

class ShowViewAnimationType extends TabAnimationType {
  ShowViewAnimationType({
    required this.tabX,
    required this.tabY,
  });

  final double tabX;
  final double tabY;
}

class ShowTabsAnimationType extends TabAnimationType {
  ShowTabsAnimationType({
    required this.tabX,
    required this.tabY,
  });

  final double tabX;
  final double tabY;
}
