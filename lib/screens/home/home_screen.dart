import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: colorScheme.surfaceContainer,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            backgroundColor: colorScheme.surfaceContainer,
            surfaceTintColor: AppTheme.transparent,
            flexibleSpace: FlexibleSpaceBar(
              background: _buildSliverAppBarContent(context),
            ),
            title: Text(
              'Baby Bump',
              style: textTheme.titleLarge?.copyWith(
                color: colorScheme.onSurface,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: IconButton(
                  onPressed: () {},
                  tooltip: 'Profile',
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(
                    minWidth: 48,
                    minHeight: 48,
                  ),
                  icon: Container(
                    width: 32,
                    height: 32,
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
                  ),
                ),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: AppTheme.spaceLg),
                _buildMoodCard(context),
                SizedBox(height: AppTheme.spaceLg),
                _buildChecklistSection(context),
                SizedBox(height: AppTheme.spaceLg),
                _buildQuickActionsSection(context),
                SizedBox(height: AppTheme.spaceLg),
                _buildWeeklyTipCard(context),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildSliverAppBarContent(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  colorScheme.surfaceContainer,
                  colorScheme.surfaceContainer,
                ],
              ),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 60,
                  bottom: 16,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppTheme.spaceMd,
                        vertical: AppTheme.spaceXxs + 2,
                      ),
                      decoration: BoxDecoration(
                        color: colorScheme.primary,
                        borderRadius: BorderRadius.circular(AppTheme.radiusPill),
                      ),
                      child: Text(
                        'Week 24',
                        style: textTheme.labelLarge?.copyWith(
                          color: colorScheme.onPrimary,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppTheme.spaceMd),
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: AppTheme.spaceMd,
                      ),
                      padding: const EdgeInsets.all(AppTheme.spaceLg),
                      decoration: BoxDecoration(
                        color: colorScheme.surface,
                        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.shadow,
                            blurRadius: 24,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: 96,
                            height: 96,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  colorScheme.tertiary,
                                  colorScheme.secondary,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                '🍈',
                                style: const TextStyle(fontSize: 48),
                              ),
                            ),
                          ),
                          const SizedBox(height: AppTheme.spaceMd),
                          Text(
                            'Week 24',
                            style: textTheme.displayLarge?.copyWith(
                              color: colorScheme.onSurface,
                            ),
                          ),
                          const SizedBox(height: AppTheme.spaceXxs),
                          Text(
                            'Due date: Dec 15, 2026',
                            style: textTheme.bodyMedium?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: AppTheme.spaceXxs),
                          Text(
                            '112 days to go',
                            style: textTheme.titleMedium?.copyWith(
                              color: colorScheme.primary,
                            ),
                          ),
                          const SizedBox(height: AppTheme.spaceMd),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Baby is the size of',
                                style: textTheme.bodySmall?.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                ),
                              ),
                              const SizedBox(width: AppTheme.spaceXs),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppTheme.spaceSm,
                                  vertical: AppTheme.spaceXxs,
                                ),
                                decoration: BoxDecoration(
                                  color: colorScheme.tertiary.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(AppTheme.radiusPill),
                                ),
                                child: Text(
                                  'Papaya',
                                  style: textTheme.labelLarge?.copyWith(
                                    color: colorScheme.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMoodCard(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppTheme.spaceMd),
      padding: const EdgeInsets.all(AppTheme.spaceLg - 4),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        boxShadow: [
          BoxShadow(
            color: AppTheme.shadow,
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'How are you feeling today?',
                style: textTheme.titleMedium?.copyWith(
                  color: colorScheme.onSurface,
                ),
              ),
              Text(
                'May 18',
                style: textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spaceMd),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildMoodButton(context, '😢', 'Terrible', false),
              _buildMoodButton(context, '😔', 'Bad', false),
              _buildMoodButton(context, '😐', 'Okay', false),
              _buildMoodButton(context, '🙂', 'Good', true),
              _buildMoodButton(context, '😊', 'Great', false),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMoodButton(
    BuildContext context,
    String emoji,
    String label,
    bool isSelected,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Container(
      padding: const EdgeInsets.all(AppTheme.spaceXs),
      decoration: BoxDecoration(
        color: isSelected
            ? colorScheme.primary.withValues(alpha: 0.1)
            : AppTheme.transparent,
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        border: isSelected
            ? Border.all(color: colorScheme.primary, width: 2)
            : null,
      ),
      child: Column(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 32)),
          const SizedBox(height: AppTheme.spaceXxs),
          Text(
            label,
            style: textTheme.bodySmall?.copyWith(
              color: isSelected
                  ? colorScheme.primary
                  : colorScheme.onSurfaceVariant,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChecklistSection(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    final checklistItems = [
      _ChecklistItem('Weight logged', true),
      _ChecklistItem('Mood checked', true),
      _ChecklistItem('Log symptoms', false),
      _ChecklistItem('Drink water', false),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppTheme.spaceMd),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Today's Checklist",
                style: textTheme.titleMedium?.copyWith(
                  color: colorScheme.onSurface,
                ),
              ),
              Text(
                '2 of 4 done',
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppTheme.spaceSm),
        SizedBox(
          height: 48,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: AppTheme.spaceMd),
            children: checklistItems.map((item) {
              return Padding(
                padding: const EdgeInsets.only(right: AppTheme.spaceSm),
                child: _buildChecklistChip(context, item),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildChecklistChip(BuildContext context, _ChecklistItem item) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final isCompleted = item.isCompleted;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spaceMd,
        vertical: AppTheme.spaceSm + 2,
      ),
      decoration: BoxDecoration(
        color: isCompleted
            ? AppTheme.success.withValues(alpha: 0.2)
            : colorScheme.onSurface.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(AppTheme.radiusPill),
        border: Border.all(
          color: isCompleted
              ? AppTheme.success.withValues(alpha: 0.3)
              : colorScheme.outline,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isCompleted)
            Icon(
              Icons.check,
              size: 20,
              color: AppTheme.success,
            )
          else
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: colorScheme.onSurface.withValues(alpha: 0.3),
                  width: 2,
                ),
              ),
            ),
          const SizedBox(width: AppTheme.spaceXs),
          Text(
            item.label,
            style: textTheme.labelLarge?.copyWith(
              color: isCompleted
                  ? colorScheme.onSurface
                  : colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionsSection(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.spaceMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Actions',
            style: textTheme.titleMedium?.copyWith(
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: AppTheme.spaceSm),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: AppTheme.spaceSm,
            mainAxisSpacing: AppTheme.spaceSm,
            childAspectRatio: 1.3,
            children: [
              _buildQuickActionButton(
                context,
                'Log Weight',
                Icons.monitor_weight_outlined,
                colorScheme.primary,
                colorScheme.onPrimary,
              ),
              _buildQuickActionButton(
                context,
                'Log Mood',
                Icons.mood_outlined,
                colorScheme.tertiary,
                colorScheme.onTertiary,
              ),
              _buildQuickActionButton(
                context,
                'Log Symptoms',
                Icons.note_add_outlined,
                colorScheme.surface,
                colorScheme.onSurface,
                isOutlined: true,
              ),
              _buildQuickActionButton(
                context,
                'View Education',
                Icons.menu_book_outlined,
                colorScheme.surface,
                colorScheme.onSurface,
                isOutlined: true,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionButton(
    BuildContext context,
    String label,
    IconData icon,
    Color backgroundColor,
    Color foregroundColor, {
    bool isOutlined = false,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        border: isOutlined
            ? Border.all(color: colorScheme.outline, width: 2)
            : null,
      ),
      child: Material(
        color: AppTheme.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(AppTheme.radiusLg),
          child: Container(
            padding: const EdgeInsets.all(AppTheme.spaceMd),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 32, color: foregroundColor),
                const SizedBox(height: AppTheme.spaceXs),
                Text(
                  label,
                  style: textTheme.labelLarge?.copyWith(
                    color: foregroundColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWeeklyTipCard(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppTheme.spaceMd),
      padding: const EdgeInsets.all(AppTheme.spaceLg - 4),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colorScheme.primary,
            colorScheme.secondary,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: colorScheme.onPrimary.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.info_outline,
              size: 20,
              color: colorScheme.onPrimary,
            ),
          ),
          const SizedBox(width: AppTheme.spaceSm + 4),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Weekly Tip',
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.onPrimary.withValues(alpha: 0.7),
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: AppTheme.spaceXxs),
                Text(
                  'Stay Hydrated',
                  style: textTheme.titleMedium?.copyWith(
                    color: colorScheme.onPrimary,
                  ),
                ),
                const SizedBox(height: AppTheme.spaceXxs),
                Text(
                  'Aim for 8-10 glasses of water daily. Staying hydrated helps prevent UTIs and constipation, common during pregnancy.',
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onPrimary.withValues(alpha: 0.8),
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

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
            _buildNavDestination(context, Icons.home, 'Home', true),
            _buildNavDestination(context, Icons.search, 'Browse', false),
            _buildNavDestination(context, Icons.bookmark_outline, 'Library', false),
            _buildNavDestination(context, Icons.person_outline, 'Profile', false),
          ],
        ),
      ),
    );
  }

  Widget _buildNavDestination(
    BuildContext context,
    IconData icon,
    String label,
    bool isActive,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

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
              fontSize: 12,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
              color: isActive ? colorScheme.primary : colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _ChecklistItem {
  final String label;
  final bool isCompleted;

  const _ChecklistItem(this.label, this.isCompleted);
}
