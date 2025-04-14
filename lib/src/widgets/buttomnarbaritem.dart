import '../../flart.dart';

class BottomNavigationBarItem {
  final Icon icon;
  final Icon? activeIcon;
  final String? label;
  final Widget? badge;

  BottomNavigationBarItem({
    required this.icon,
    this.activeIcon,
    this.label,
    this.badge,
  });
}