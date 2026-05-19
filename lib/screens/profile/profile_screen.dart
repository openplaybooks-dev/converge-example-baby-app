import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../theme/app_theme.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: colorScheme.surfaceContainer,
      appBar: AppBar(
        title: Text(
          'Profile',
          style: textTheme.titleLarge?.copyWith(
            color: colorScheme.onSurface,
          ),
        ),
        backgroundColor: colorScheme.surfaceContainer,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: AppTheme.spaceMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: AppTheme.spaceMd),
            _ProfileHeader(colorScheme: colorScheme, textTheme: textTheme),
            const SizedBox(height: AppTheme.spaceLg),
            _MindfulnessCard(colorScheme: colorScheme, textTheme: textTheme),
            const SizedBox(height: AppTheme.spaceSm),
            _SettingsCard(colorScheme: colorScheme, textTheme: textTheme),
            const SizedBox(height: AppTheme.spaceSm),
            const _AboutCard(),
            const SizedBox(height: 100),
          ],
        )
        .animate()
        .fadeIn(duration: 300.ms, curve: Curves.easeOut),
      ),
      bottomNavigationBar: _BottomNavBar(colorScheme: colorScheme),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  final ColorScheme colorScheme;
  final TextTheme textTheme;

  const _ProfileHeader({
    required this.colorScheme,
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                colorScheme.primary,
                colorScheme.tertiary,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              'S',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w700,
                color: colorScheme.onPrimary,
              ),
            ),
          ),
        )
            .animate()
            .scale(
              begin: const Offset(0.95, 0.95),
              duration: 200.ms,
              curve: Curves.easeOut,
            ),
        const SizedBox(height: AppTheme.spaceSm + 4),
        Text(
          'Sarah',
          style: textTheme.displayLarge?.copyWith(
            color: colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: AppTheme.spaceXxs),
        Text(
          'Due December 15, 2026',
          style: textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: AppTheme.spaceSm + 4),
        TextButton(
          onPressed: () => context.push('/settings'),
          style: TextButton.styleFrom(
            minimumSize: const Size(48, 48),
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.spaceMd,
              vertical: AppTheme.spaceXs,
            ),
          ),
          child: Text(
            'Edit profile',
            style: textTheme.labelLarge?.copyWith(
              color: colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}

class _MindfulnessCard extends ConsumerWidget {
  final ColorScheme colorScheme;
  final TextTheme textTheme;

  const _MindfulnessCard({
    required this.colorScheme,
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _NavCard(
      colorScheme: colorScheme,
      textTheme: textTheme,
      icon: Icons.self_improvement,
      iconContainerColor: colorScheme.tertiary.withValues(alpha: 0.2),
      iconColor: colorScheme.tertiary,
      title: 'Mindfulness',
      description: 'Breathing exercises, stretching, relaxation',
      route: '/mindfulness',
    );
  }
}

class _SettingsCard extends ConsumerWidget {
  final ColorScheme colorScheme;
  final TextTheme textTheme;

  const _SettingsCard({
    required this.colorScheme,
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _NavCard(
      colorScheme: colorScheme,
      textTheme: textTheme,
      icon: Icons.settings_outlined,
      iconContainerColor: colorScheme.primary.withValues(alpha: 0.15),
      iconColor: colorScheme.primary,
      title: 'Settings',
      description: 'Notifications, due date, data export',
      route: '/settings',
    );
  }
}

class _NavCard extends StatefulWidget {
  final ColorScheme colorScheme;
  final TextTheme textTheme;
  final IconData icon;
  final Color iconContainerColor;
  final Color iconColor;
  final String title;
  final String description;
  final String route;

  const _NavCard({
    required this.colorScheme,
    required this.textTheme,
    required this.icon,
    required this.iconContainerColor,
    required this.iconColor,
    required this.title,
    required this.description,
    required this.route,
  });

  @override
  State<_NavCard> createState() => _NavCardState();
}

class _NavCardState extends State<_NavCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: () => context.push(widget.route),
      child: AnimatedScale(
        scale: _isPressed ? 0.98 : 1.0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        child: Container(
          padding: const EdgeInsets.all(AppTheme.spaceMd),
          decoration: BoxDecoration(
            color: widget.colorScheme.surface,
            borderRadius: BorderRadius.circular(AppTheme.radiusLg),
            boxShadow: const [
              BoxShadow(
                color: AppTheme.shadow,
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: widget.iconContainerColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  widget.icon,
                  size: 24,
                  color: widget.iconColor,
                ),
              ),
              const SizedBox(width: AppTheme.spaceMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: widget.textTheme.titleMedium?.copyWith(
                        color: widget.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      widget.description,
                      style: widget.textTheme.bodyMedium?.copyWith(
                        color: widget.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                size: 24,
                color: widget.colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AboutCard extends StatelessWidget {
  const _AboutCard();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppTheme.spaceMd),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        boxShadow: const [
          BoxShadow(
            color: AppTheme.shadow,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Baby Bump',
            style: textTheme.titleMedium?.copyWith(
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Version 1.0.0',
            style: textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppTheme.spaceXs),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              minimumSize: const Size(48, 48),
              padding: EdgeInsets.zero,
            ),
            child: Text(
              'Privacy policy',
              style: textTheme.labelLarge?.copyWith(
                color: colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomNavBar extends StatelessWidget {
  final ColorScheme colorScheme;

  const _BottomNavBar({required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(
          top: BorderSide(color: colorScheme.outline),
        ),
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _NavItem(
              icon: Icons.home_outlined,
              label: 'Home',
              isActive: false,
              colorScheme: colorScheme,
            ),
            _NavItem(
              icon: Icons.search,
              label: 'Browse',
              isActive: false,
              colorScheme: colorScheme,
            ),
            _NavItem(
              icon: Icons.bookmark_outline,
              label: 'Library',
              isActive: false,
              colorScheme: colorScheme,
            ),
            _NavItem(
              icon: Icons.person,
              label: 'Profile',
              isActive: true,
              colorScheme: colorScheme,
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final ColorScheme colorScheme;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spaceMd,
        vertical: AppTheme.spaceXs,
      ),
      decoration: isActive
          ? BoxDecoration(
              color: colorScheme.primary.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(AppTheme.radiusPill),
            )
          : null,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 24,
            color: isActive ? colorScheme.primary : colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: AppTheme.spaceXxs),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
              color: isActive ? colorScheme.primary : colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}