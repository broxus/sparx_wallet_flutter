sealed class TabAnimationType {
  TabAnimationType({
    this.tabX,
    this.tabY,
  });

  final double? tabX;
  final double? tabY;
}

class ShowViewAnimationType extends TabAnimationType {
  ShowViewAnimationType({
    super.tabX,
    super.tabY,
  });
}

class ShowTabsAnimationType extends TabAnimationType {
  ShowTabsAnimationType({
    super.tabX,
    super.tabY,
  });
}
