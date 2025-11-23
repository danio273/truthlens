class NavigationItem {
  final String route;
  final String label;
  Function? onPressed;

  NavigationItem({required this.route, required this.label, this.onPressed});
}
