
//! I CREATED THIS MODEL FOR BADGE SUPPORT
class NavTabModel {
  final String label;
  final String route;
  final String svgOutline;
  final String svgFilled;
  final bool hasDynamicBadge;

  const NavTabModel({
    required this.label,
    required this.route,
    required this.svgOutline,
    required this.svgFilled,
    this.hasDynamicBadge = false,
  });
}
