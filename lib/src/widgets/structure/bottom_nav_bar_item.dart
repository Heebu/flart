import '../../../flartdart.dart';

class FDBottomNavigationBarItem {
  final FDIcon icon;
  final FDIcon? activeIcon;
  final String? label;
  final Widget? badge;

  const FDBottomNavigationBarItem({
    required this.icon,
    this.activeIcon,
    this.label,
    this.badge,
  });
}
