import 'package:app/event_bus/events/base_event.dart';
import 'package:app/feature/root/view/root_tab.dart';

sealed class BottomNavigationEvent extends BaseEvent {}

class PressBottomNavigationEvent extends BottomNavigationEvent {
  PressBottomNavigationEvent({
    required this.prevTab,
    required this.currentTab,
  });

  final RootTab prevTab;
  final RootTab currentTab;

  late final bool isSameTab = prevTab == currentTab;
  late final bool isWalletTab = currentTab == RootTab.wallet;
}

class OpenBrowserTabEvent extends BottomNavigationEvent {}

class VisibleNavigationEvent extends BottomNavigationEvent {}

class HideNavigationEvent extends VisibleNavigationEvent {}

class RevertNavigationEvent extends VisibleNavigationEvent {}
