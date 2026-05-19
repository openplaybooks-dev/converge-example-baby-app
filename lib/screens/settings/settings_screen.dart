import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../theme/app_theme.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: colorScheme.surfaceContainer,
      appBar: AppBar(
        backgroundColor: colorScheme.surfaceContainer,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(
            Icons.arrow_back,
            color: colorScheme.onSurface,
          ),
          padding: const EdgeInsets.all(AppTheme.spaceXs),
          constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
        ),
        title: Text(
          'Settings',
          style: textTheme.titleLarge?.copyWith(
            color: colorScheme.onSurface,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: AppTheme.spaceMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: AppTheme.spaceMd),
            _SectionProfile(colorScheme: colorScheme, textTheme: textTheme),
            const SizedBox(height: AppTheme.spaceLg),
            _SectionNotifications(colorScheme: colorScheme, textTheme: textTheme),
            const SizedBox(height: AppTheme.spaceLg),
            _SectionData(colorScheme: colorScheme, textTheme: textTheme),
            const SizedBox(height: AppTheme.spaceLg),
            _SectionAbout(colorScheme: colorScheme, textTheme: textTheme),
            const SizedBox(height: 100),
          ],
        ),
      ).animate().fadeIn(duration: 300.ms, curve: Curves.easeOut),
    );
  }
}

class _SectionProfile extends StatelessWidget {
  final ColorScheme colorScheme;
  final TextTheme textTheme;

  const _SectionProfile({
    required this.colorScheme,
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context) {
    return _SettingsCard(
      colorScheme: colorScheme,
      textTheme: textTheme,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Profile',
            style: textTheme.titleMedium?.copyWith(
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: AppTheme.spaceSm),
          _ListItemRow(
            colorScheme: colorScheme,
            textTheme: textTheme,
            icon: Icons.person_outline,
            iconColor: colorScheme.primary,
            iconBackgroundColor: colorScheme.primary.withValues(alpha: 0.1),
            title: 'Name',
            description: 'Sarah',
            onTap: () {},
          ),
          _ListItemRow(
            colorScheme: colorScheme,
            textTheme: textTheme,
            icon: Icons.calendar_today_outlined,
            iconColor: colorScheme.primary,
            iconBackgroundColor: colorScheme.primary.withValues(alpha: 0.1),
            title: 'Due Date',
            description: 'December 15, 2026',
            showChevron: true,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class _SectionNotifications extends StatefulWidget {
  final ColorScheme colorScheme;
  final TextTheme textTheme;

  const _SectionNotifications({
    required this.colorScheme,
    required this.textTheme,
  });

  @override
  State<_SectionNotifications> createState() => _SectionNotificationsState();
}

class _SectionNotificationsState extends State<_SectionNotifications> {
  bool _dailyReminders = true;
  bool _symptomAlerts = true;
  bool _appointmentReminders = false;
  bool _weeklyDigest = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = widget.colorScheme;
    final textTheme = widget.textTheme;

    return _SettingsCard(
      colorScheme: colorScheme,
      textTheme: textTheme,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Notifications',
            style: textTheme.titleMedium?.copyWith(
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: AppTheme.spaceSm),
          _SwitchRow(
            colorScheme: colorScheme,
            textTheme: textTheme,
            title: 'Daily Reminders',
            description: 'Morning check-in and daily tips',
            value: _dailyReminders,
            onChanged: (value) => setState(() => _dailyReminders = value),
          ),
          _SwitchRow(
            colorScheme: colorScheme,
            textTheme: textTheme,
            title: 'Symptom Alerts',
            description: 'Track and log symptom changes',
            value: _symptomAlerts,
            onChanged: (value) => setState(() => _symptomAlerts = value),
          ),
          _SwitchRow(
            colorScheme: colorScheme,
            textTheme: textTheme,
            title: 'Appointment Reminders',
            description: 'Upcoming prenatal visit alerts',
            value: _appointmentReminders,
            onChanged: (value) => setState(() => _appointmentReminders = value),
          ),
          _SwitchRow(
            colorScheme: colorScheme,
            textTheme: textTheme,
            title: 'Weekly Digest',
            description: 'Summary of your pregnancy journey',
            value: _weeklyDigest,
            onChanged: (value) => setState(() => _weeklyDigest = value),
            showDivider: false,
          ),
        ],
      ),
    );
  }
}

class _SectionData extends StatelessWidget {
  final ColorScheme colorScheme;
  final TextTheme textTheme;

  const _SectionData({
    required this.colorScheme,
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context) {
    return _SettingsCard(
      colorScheme: colorScheme,
      textTheme: textTheme,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Data',
            style: textTheme.titleMedium?.copyWith(
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: AppTheme.spaceSm),
          _ActionRow(
            colorScheme: colorScheme,
            textTheme: textTheme,
            icon: Icons.arrow_upward,
            iconColor: colorScheme.tertiary,
            iconBackgroundColor: colorScheme.tertiary.withValues(alpha: 0.2),
            label: 'Export Data',
            description: 'Save and share your data as JSON',
            isDestructive: false,
            onTap: () {},
          ),
          _ActionRow(
            colorScheme: colorScheme,
            textTheme: textTheme,
            icon: Icons.delete_outline,
            iconColor: colorScheme.error,
            iconBackgroundColor: colorScheme.error.withValues(alpha: 0.1),
            label: 'Clear All Data',
            description: 'Delete all app data permanently',
            isDestructive: true,
            showDivider: false,
            onTap: () => _showClearDataDialog(context),
          ),
        ],
      ),
    );
  }

  void _showClearDataDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        ),
        title: Text(
          'Clear All Data',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        content: Text(
          'Are you sure? This action cannot be undone.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            style: TextButton.styleFrom(
              minimumSize: const Size(48, 48),
              padding: const EdgeInsets.symmetric(
                horizontal: AppTheme.spaceMd,
                vertical: AppTheme.spaceXs,
              ),
            ),
            child: Text(
              'Cancel',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              final snackBarColorScheme = Theme.of(context).colorScheme;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('All data cleared'),
                  backgroundColor: snackBarColorScheme.error,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                  ),
                ),
              );
            },
            style: TextButton.styleFrom(
              minimumSize: const Size(48, 48),
              padding: const EdgeInsets.symmetric(
                horizontal: AppTheme.spaceMd,
                vertical: AppTheme.spaceXs,
              ),
            ),
            child: Text(
              'Delete',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionAbout extends StatelessWidget {
  final ColorScheme colorScheme;
  final TextTheme textTheme;

  const _SectionAbout({
    required this.colorScheme,
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context) {
    return _SettingsCard(
      colorScheme: colorScheme,
      textTheme: textTheme,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'About',
            style: textTheme.titleMedium?.copyWith(
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: AppTheme.spaceSm),
          _AboutRow(
            colorScheme: colorScheme,
            textTheme: textTheme,
            label: 'Version',
            value: '1.0.0',
          ),
          _LinkRow(
            colorScheme: colorScheme,
            textTheme: textTheme,
            icon: Icons.shield_outlined,
            label: 'Privacy Policy',
            onTap: () {},
          ),
          _LinkRow(
            colorScheme: colorScheme,
            textTheme: textTheme,
            icon: Icons.description_outlined,
            label: 'Terms of Service',
            showDivider: false,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class _SettingsCard extends StatefulWidget {
  final ColorScheme colorScheme;
  final TextTheme textTheme;
  final Widget child;

  const _SettingsCard({
    required this.colorScheme,
    required this.textTheme,
    required this.child,
  });

  @override
  State<_SettingsCard> createState() => _SettingsCardState();
}

class _SettingsCardState extends State<_SettingsCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedScale(
        scale: _isPressed ? 0.98 : 1.0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        child: Container(
          width: double.infinity,
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
          child: widget.child,
        ),
      ),
    );
  }
}

class _ListItemRow extends StatelessWidget {
  final ColorScheme colorScheme;
  final TextTheme textTheme;
  final IconData icon;
  final Color iconColor;
  final Color iconBackgroundColor;
  final String title;
  final String description;
  final bool showChevron;
  final VoidCallback onTap;

  const _ListItemRow({
    required this.colorScheme,
    required this.textTheme,
    required this.icon,
    required this.iconColor,
    required this.iconBackgroundColor,
    required this.title,
    required this.description,
    this.showChevron = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return _InkWellScale(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppTheme.spaceXs),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: colorScheme.outline,
            ),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: iconBackgroundColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 20,
                color: iconColor,
              ),
            ),
            const SizedBox(width: AppTheme.spaceSm + 4),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: textTheme.titleSmall?.copyWith(
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    description,
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            if (showChevron)
              Icon(
                Icons.chevron_right,
                size: 20,
                color: colorScheme.onSurfaceVariant,
              ),
          ],
        ),
      ),
    );
  }
}

class _SwitchRow extends StatelessWidget {
  final ColorScheme colorScheme;
  final TextTheme textTheme;
  final String title;
  final String description;
  final bool value;
  final ValueChanged<bool> onChanged;
  final bool showDivider;

  const _SwitchRow({
    required this.colorScheme,
    required this.textTheme,
    required this.title,
    required this.description,
    required this.value,
    required this.onChanged,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppTheme.spaceXs),
      decoration: showDivider
          ? BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: colorScheme.outline,
                ),
              ),
            )
          : null,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: textTheme.titleSmall?.copyWith(
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Switch.adaptive(
            value: value,
            onChanged: onChanged,
            activeTrackColor: colorScheme.primary,
            inactiveTrackColor: colorScheme.outline,
          ),
        ],
      ),
    );
  }
}

class _ActionRow extends StatelessWidget {
  final ColorScheme colorScheme;
  final TextTheme textTheme;
  final IconData icon;
  final Color iconColor;
  final Color iconBackgroundColor;
  final String label;
  final String description;
  final bool isDestructive;
  final bool showDivider;
  final VoidCallback onTap;

  const _ActionRow({
    required this.colorScheme,
    required this.textTheme,
    required this.icon,
    required this.iconColor,
    required this.iconBackgroundColor,
    required this.label,
    required this.description,
    this.isDestructive = false,
    this.showDivider = true,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return _InkWellScale(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppTheme.spaceXs),
        decoration: showDivider
            ? BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: colorScheme.outline,
                  ),
                ),
              )
            : null,
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: iconBackgroundColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 20,
                color: iconColor,
              ),
            ),
            const SizedBox(width: AppTheme.spaceSm + 4),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    label,
                    style: textTheme.titleSmall?.copyWith(
                      color: isDestructive
                          ? colorScheme.error
                          : colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    description,
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              size: 20,
              color: colorScheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }
}

class _AboutRow extends StatelessWidget {
  final ColorScheme colorScheme;
  final TextTheme textTheme;
  final String label;
  final String value;

  const _AboutRow({
    required this.colorScheme,
    required this.textTheme,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppTheme.spaceXs),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: colorScheme.outline,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Text(
            value,
            style: textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}

class _LinkRow extends StatelessWidget {
  final ColorScheme colorScheme;
  final TextTheme textTheme;
  final IconData icon;
  final String label;
  final bool showDivider;
  final VoidCallback onTap;

  const _LinkRow({
    required this.colorScheme,
    required this.textTheme,
    required this.icon,
    required this.label,
    this.showDivider = true,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return _InkWellScale(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppTheme.spaceXs),
        decoration: showDivider
            ? BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: colorScheme.outline,
                  ),
                ),
              )
            : null,
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: colorScheme.primary,
            ),
            const SizedBox(width: AppTheme.spaceSm),
            Expanded(
              child: Text(
                label,
                style: textTheme.titleSmall?.copyWith(
                  color: colorScheme.primary,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              size: 20,
              color: colorScheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }
}

class _InkWellScale extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;

  const _InkWellScale({
    required this.child,
    required this.onTap,
  });

  @override
  State<_InkWellScale> createState() => _InkWellScaleState();
}

class _InkWellScaleState extends State<_InkWellScale> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _isPressed ? 0.98 : 1.0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        child: widget.child,
      ),
    );
  }
}