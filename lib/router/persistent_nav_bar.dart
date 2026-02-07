import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:retail_mart/design_system/components/liquid_container.dart';
import 'package:retail_mart/design_system/tokens/colors.dart';
import 'package:retail_mart/router/nav_bar_model.dart';
import 'package:retail_mart/router/route_provider.dart';

class PersistentNavBar extends ConsumerWidget {
  const PersistentNavBar({super.key});

  static const tabs = [
    NavTabModel(
      label: 'Home',
      route: '/home',
      svgOutline: 'assets/icons/home.svg',
      svgFilled: 'assets/icons/filled/home.svg',
    ),
    NavTabModel(
      label: 'Shop',
      route: '/shop',
      svgOutline: 'assets/icons/shop.svg',
      svgFilled: 'assets/icons/filled/calendar.svg',
      hasDynamicBadge: true,
    ),
    NavTabModel(
      label: 'Cart',
      route: '/cart',
      svgOutline: 'assets/icons/cart.svg',
      svgFilled: 'assets/icons/filled/calendar.svg',
      hasDynamicBadge: true,
    ),
    NavTabModel(
      label: 'Profile',
      route: '/profile',
      svgOutline: 'assets/icons/profile.svg',
      svgFilled: 'assets/icons/filled/profile.svg',
    ),
  ];

  int _getSelectedIndex(String location) {
    return tabs.indexWhere((tab) => location.startsWith(tab.route));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = GoRouterState.of(context).uri.toString();
    final selectedIndex = _getSelectedIndex(location);

    final eventsBadge = ref.watch(eventsBadgeProvider);

    return LiquidGlassContainer(
      margin: const EdgeInsets.only(bottom: 32, left: 32, right: 32),
      padding: const EdgeInsets.only(top: 8, bottom: 8),

      //------------------
      // I intentionally return row here instead of bottomappbar becuase of height issue and since am not using a nocthed shape or any feature that would require it am good to go

      //--------------------
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(tabs.length, (index) {
          final tab = tabs[index];
          final isSelected = index == selectedIndex;

          // Badge logic
          int badge = 0;
          if (tab.label == "Events") badge = eventsBadge;

          return _NavBarItem(
            tab: tab,
            isSelected: isSelected,
            badgeCount: badge,
            onTap: () {
              if (!isSelected) context.go(tab.route);
            },
          );
        }),
      ),
    );
  }
}

class _NavBarItem extends StatefulWidget {
  final NavTabModel tab;
  final bool isSelected;
  final int badgeCount;
  final VoidCallback onTap;

  const _NavBarItem({
    required this.tab,
    required this.isSelected,
    required this.badgeCount,
    required this.onTap,
  });

  @override
  State<_NavBarItem> createState() => _NavBarItemState();
}

class _NavBarItemState extends State<_NavBarItem>
    with SingleTickerProviderStateMixin {
  double scale = 1.0;

  void _playBounce() {
    setState(() => scale = 0.85);
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() => scale = 1.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _playBounce();
        widget.onTap();
      },
      child: AnimatedScale(
        scale: scale,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutBack,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(horizontal: 22),
          height: 48,
          child: Stack(
            alignment: Alignment.center,
            children: [

              /// Icon when it isnot active
              Visibility(
                visible: !widget.isSelected,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    SvgPicture.asset(
                      widget.tab.svgOutline,
                      width: 26,
                      height: 26,
                      colorFilter: const ColorFilter.mode(
                        AppColors.gray600,
                        BlendMode.srcIn,
                      ),
                    ),

                    // Badge
                    if (widget.badgeCount > 0)
                      Positioned(
                        right: -6,
                        top: -6,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            widget.badgeCount.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Visibility(
                visible: widget.isSelected,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/circle.svg',
                      height: 8,
                      colorFilter: const ColorFilter.mode(
                        AppColors.primary,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      widget.tab.label,
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
