import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:folio/theme/app_theme.dart';

class HealthLogScreen extends StatelessWidget {
  const HealthLogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios, size: 24),
          padding: EdgeInsets.zero,
          visualDensity: VisualDensity.compact,
        ),
        title: Text(
          'Health Log',
          style: textTheme.titleLarge,
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Filter bottom sheet would open here
            },
            icon: const Icon(Icons.filter_list, size: 24),
            padding: EdgeInsets.zero,
            visualDensity: VisualDensity.compact,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.spaceMd,
          vertical: AppTheme.spaceLg,
        ),
        children: [
          // Summary Stats Banner
          _SummaryStatsCard(),
          const SizedBox(height: AppTheme.spaceLg),

          // Timeline Section Header
          Text(
            'Today',
            style: textTheme.labelSmall?.copyWith(
              color: AppTheme.stoneGrey,
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: AppTheme.spaceSm),

          // Today entries
          _HealthEntryCard(
            title: 'Headache',
            subtitle: 'Felt dizzy after standing up quickly',
            time: '2:30 PM',
            severity: 2,
            entryType: _EntryType.symptom,
          ),
          const SizedBox(height: AppTheme.spaceSm),
          _HealthEntryCard(
            title: 'Dr. Sarah Chen',
            subtitle: 'Regular prenatal checkup, everything looks good',
            time: '10:00 AM',
            badgeText: 'Next: May 29',
            badgeColor: AppTheme.softMint.withValues(alpha: 0.2),
            entryType: _EntryType.doctorVisit,
          ),

          const SizedBox(height: AppTheme.spaceLg),

          // Yesterday header
          Text(
            'Yesterday',
            style: textTheme.labelSmall?.copyWith(
              color: AppTheme.stoneGrey,
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: AppTheme.spaceSm),

          _HealthEntryCard(
            title: 'Nausea',
            subtitle: 'Morning sickness, took ginger tea',
            time: '8:15 AM',
            severity: 1,
            entryType: _EntryType.symptom,
          ),
          const SizedBox(height: AppTheme.spaceSm),
          _HealthEntryCard(
            title: 'Take Prenatal Vitamins',
            subtitle: null,
            time: '7:00 AM',
            badgeText: 'Medication',
            badgeColor: AppTheme.blushRose.withValues(alpha: 0.2),
            enabledText: 'Enabled',
            enabledColor: AppTheme.softMint,
            entryType: _EntryType.reminder,
          ),

          const SizedBox(height: AppTheme.spaceLg),

          // May 15, 2026 header
          Text(
            'May 15, 2026',
            style: textTheme.labelSmall?.copyWith(
              color: AppTheme.stoneGrey,
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: AppTheme.spaceSm),

          _HealthEntryCard(
            title: 'Dr. Emily Watson',
            subtitle: '22-week ultrasound scan',
            time: '11:30 AM',
            badgeText: 'Next: Jun 12',
            badgeColor: AppTheme.softMint.withValues(alpha: 0.2),
            entryType: _EntryType.doctorVisit,
          ),

          // Bottom padding for FAB
          const SizedBox(height: 100),
        ],
      ),
      floatingActionButton: _AddEntryFab(),
    );
  }
}

enum _EntryType { symptom, doctorVisit, reminder }

class _SummaryStatsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Card(
      color: AppTheme.morningMist,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spaceMd),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Symptom count
            Row(
              spacing: AppTheme.spaceXs,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppTheme.lavenderBloom.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.checklist,
                    size: 20,
                    color: AppTheme.lavenderBloom,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '3',
                      style: textTheme.titleMedium,
                    ),
                    Text(
                      'symptoms this week',
                      style: textTheme.labelSmall,
                    ),
                  ],
                ),
              ],
            ),
            // Divider
            Container(
              width: 1,
              height: 40,
              color: AppTheme.mistyBorder,
            ),
            // Next reminder
            Row(
              spacing: AppTheme.spaceXs,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppTheme.softMint.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.calendar_today,
                    size: 20,
                    color: AppTheme.softMint,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Next',
                      style: textTheme.labelSmall,
                    ),
                    Text(
                      'Prenatal on May 22',
                      style: textTheme.titleSmall,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 200.ms);
  }
}

class _HealthEntryCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String time;
  final int? severity;
  final String? badgeText;
  final Color? badgeColor;
  final String? enabledText;
  final Color? enabledColor;
  final _EntryType entryType;

  const _HealthEntryCard({
    required this.title,
    required this.subtitle,
    required this.time,
    this.severity,
    this.badgeText,
    this.badgeColor,
    this.enabledText,
    this.enabledColor,
    required this.entryType,
  });

  Color get _borderColor {
    switch (entryType) {
      case _EntryType.symptom:
        return AppTheme.lavenderBloom;
      case _EntryType.doctorVisit:
        return AppTheme.blushRose;
      case _EntryType.reminder:
        return AppTheme.softMint;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Container(
      decoration: BoxDecoration(
        color: AppTheme.morningMist,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        border: Border(
          left: BorderSide(color: _borderColor, width: 4),
        ),
      ),
      child: Material(
        color: AppTheme.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppTheme.radiusLg),
          onTap: () {
            // Entry detail bottom sheet
          },
          child: Padding(
            padding: const EdgeInsets.all(AppTheme.spaceMd),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: textTheme.titleMedium,
                      ),
                      if (severity != null) ...[
                        const SizedBox(height: AppTheme.spaceXxs),
                        Row(
                          spacing: AppTheme.spaceXxs,
                          children: [
                            ...List.generate(
                              3,
                              (index) => Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: index < severity!
                                      ? AppTheme.lavenderBloom
                                      : AppTheme.stoneGrey.withValues(alpha: 0.3),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                            const SizedBox(width: AppTheme.spaceXxs),
                            Text(
                              severity == 1
                                  ? 'Mild'
                                  : severity == 2
                                      ? 'Moderate'
                                      : 'Severe',
                              style: textTheme.labelSmall,
                            ),
                          ],
                        ),
                      ],
                      if (subtitle != null) ...[
                        const SizedBox(height: AppTheme.spaceXxs),
                        Text(
                          subtitle!,
                          style: textTheme.bodyMedium,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                      if (badgeText != null) ...[
                        const SizedBox(height: AppTheme.spaceXs),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppTheme.spaceXs,
                            vertical: AppTheme.spaceXxs,
                          ),
                          decoration: BoxDecoration(
                            color: badgeColor,
                            borderRadius: BorderRadius.circular(AppTheme.radiusPill),
                          ),
                          child: Text(
                            badgeText!,
                            style: textTheme.labelSmall,
                          ),
                        ),
                      ],
                      if (enabledText != null) ...[
                        const SizedBox(height: AppTheme.spaceXs),
                        Row(
                          spacing: AppTheme.spaceXxs,
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: enabledColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                            Text(
                              enabledText!,
                              style: textTheme.labelSmall?.copyWith(
                                color: enabledColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(width: AppTheme.spaceSm),
                Text(
                  time,
                  style: textTheme.labelSmall,
                ),
              ],
            ),
          ),
        ),
      ),
    ).animate().fadeIn(duration: 200.ms).slideY(begin: 0.05, end: 0);
  }
}

class _AddEntryFab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        // Add entry bottom sheet
      },
      backgroundColor: AppTheme.lavenderBloom,
      elevation: 4,
      child: Icon(Icons.add, color: AppTheme.warmWhite, size: 24),
    )
        .animate()
        .fadeIn(duration: 200.ms, delay: 300.ms)
        .scale(begin: const Offset(0.95, 0.95), end: const Offset(1, 1));
  }
}
