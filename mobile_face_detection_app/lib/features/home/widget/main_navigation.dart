import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainNavigation extends StatelessWidget {
  final Widget child;

  const MainNavigation({super.key, required this.child});

  int _getIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();

    if (location.contains('/home')) return 0;
    if (location.contains('/scan')) return 1;
    if (location.contains('/tracker')) return 2;

    return 0;
  }

  bool _shouldHideBottomNav(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    return location.contains('/profile');
  }

  @override
  Widget build(BuildContext context) {
    final index = _getIndex(context);
    final shouldHideBottomNav = _shouldHideBottomNav(context);

    return Scaffold(
      body: child,
      extendBody: true,
      bottomNavigationBar: shouldHideBottomNav
          ? null
          : Container(
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 20,
                    color: Colors.black.withOpacity(0.05),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _navItem(
                    icon: Icons.home,
                    label: 'Home',
                    isActive: index == 0,
                    onTap: () => context.go('/home'),
                  ),
                  Transform.translate(
                    offset: const Offset(0, -20),
                    child: GestureDetector(
                      onTap: () => context.push('/scan'),
                      child: Container(
                        height: 64,
                        width: 64,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF06090),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFF06090).withOpacity(0.4),
                              blurRadius: 16,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                    ),
                  ),
                  _navItem(
                    icon: Icons.bar_chart,
                    label: 'Tracker',
                    isActive: index == 2,
                    onTap: () => context.go('/tracker'),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _navItem({
    required IconData icon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 26,
            color: isActive ? const Color(0xFFF06090) : Colors.grey.shade400,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: isActive ? const Color(0xFFF06090) : Colors.grey.shade400,
            ),
          ),
        ],
      ),
    );
  }
}
