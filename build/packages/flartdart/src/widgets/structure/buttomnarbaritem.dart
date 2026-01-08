import '../../../flartdart.dart';

class FDBottomNavigationBarItem {
  final FDIcon icon;
  final FDIcon? activeIcon;
  final String? label;
  final Widget? badge;

  FDBottomNavigationBarItem({
    required this.icon,
    this.activeIcon,
    this.label,
    this.badge,
  });
}
