import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../theme/app_theme.dart';

class MindfulnessScreen extends StatelessWidget {
  const MindfulnessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: colorScheme.surfaceContainer,
      appBar: AppBar(
        backgroundColor: colorScheme.surfaceContainer,
        elevation: 0,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios, size: 24),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
          tooltip: 'Go back',
        ),
        title: Text(
          'Mindfulness',
          style: textTheme.headlineSmall?.copyWith(
            color: colorScheme.onSurface,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.spaceMd,
          vertical: AppTheme.spaceXs,
        ),
        children: [
          const SizedBox(height: AppTheme.spaceSm),
          _BreathingSection(textTheme: textTheme, colorScheme: colorScheme),
          const SizedBox(height: AppTheme.spaceLg),
          _StretchingSection(textTheme: textTheme, colorScheme: colorScheme),
          const SizedBox(height: AppTheme.spaceMd),
        ],
      ),
    );
  }
}

class _BreathingSection extends StatelessWidget {
  final TextTheme textTheme;
  final ColorScheme colorScheme;

  const _BreathingSection({
    required this.textTheme,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Breathing Exercises',
          style: textTheme.headlineMedium?.copyWith(
            color: colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: AppTheme.spaceSm),
        ..._breathingExercises.map(
          (exercise) => Padding(
            padding: const EdgeInsets.only(bottom: AppTheme.spaceSm),
            child: _BreathingExerciseCard(
              name: exercise['name']!,
              duration: exercise['duration']!,
              difficulty: exercise['difficulty']!,
              colorScheme: colorScheme,
              textTheme: textTheme,
            ),
          ),
        ),
      ],
    );
  }

  static const _breathingExercises = [
    {'name': 'Box Breathing', 'duration': '2 min', 'difficulty': 'Beginner'},
    {'name': 'Deep Breathing', 'duration': '3 min', 'difficulty': 'Beginner'},
    {'name': '4-7-8 Technique', 'duration': '4 min', 'difficulty': 'Intermediate'},
    {'name': 'Energizing Breath', 'duration': '2 min', 'difficulty': 'Intermediate'},
  ];
}

class _BreathingExerciseCard extends StatelessWidget {
  final String name;
  final String duration;
  final String difficulty;
  final ColorScheme colorScheme;
  final TextTheme textTheme;

  const _BreathingExerciseCard({
    required this.name,
    required this.duration,
    required this.difficulty,
    required this.colorScheme,
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context) {
    final isBeginner = difficulty == 'Beginner';
    final badgeColor = isBeginner
        ? AppTheme.softMint.withValues(alpha: 0.2)
        : AppTheme.blushRose.withValues(alpha: 0.3);
    final badgeTextColor = isBeginner ? AppTheme.lavenderBloom : colorScheme.onSurface;

    return Semantics(
      label: '$name breathing exercise, $duration, $difficulty, tap to start',
      button: true,
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.morningMist,
          borderRadius: BorderRadius.circular(AppTheme.radiusLg),
          boxShadow: const [
            BoxShadow(
              color: AppTheme.shadow,
              blurRadius: 16,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: AppTheme.transparent,
          child: InkWell(
            onTap: () {
              // TODO: Navigate to breathing exercise overlay
            },
            borderRadius: BorderRadius.circular(AppTheme.radiusLg),
            child: Padding(
              padding: const EdgeInsets.all(AppTheme.spaceMd),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: textTheme.titleMedium?.copyWith(
                            color: colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: AppTheme.spaceXxs),
                        Text(
                          duration,
                          style: textTheme.bodyMedium?.copyWith(
                            color: AppTheme.stoneGrey,
                          ),
                        ),
                        const SizedBox(height: AppTheme.spaceXs),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: badgeColor,
                            borderRadius: BorderRadius.circular(AppTheme.radiusPill),
                          ),
                          child: Text(
                            difficulty,
                            style: textTheme.labelSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: badgeTextColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ExcludeSemantics(
                    child: Icon(
                      Icons.chevron_right,
                      size: 20,
                      color: AppTheme.stoneGrey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _StretchingSection extends StatelessWidget {
  final TextTheme textTheme;
  final ColorScheme colorScheme;

  const _StretchingSection({
    required this.textTheme,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Stretching & Self-Care',
          style: textTheme.headlineMedium?.copyWith(
            color: colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: AppTheme.spaceSm),
        ..._stretchingRoutines.map(
          (routine) => Padding(
            padding: const EdgeInsets.only(bottom: AppTheme.spaceSm),
            child: _StretchingRoutineCard(
              name: routine['name']!,
              duration: routine['duration']!,
              trimester: routine['trimester']!,
              colorScheme: colorScheme,
              textTheme: textTheme,
            ),
          ),
        ),
      ],
    );
  }

  static const _stretchingRoutines = [
    {'name': 'Neck & Shoulders', 'duration': '5 min', 'trimester': 'All Trimester'},
    {'name': 'Hip Opener', 'duration': '10 min', 'trimester': '2nd/3rd Tri'},
    {'name': 'Standing Stretch', 'duration': '8 min', 'trimester': '1st/2nd Tri'},
    {'name': 'Floor Relaxation', 'duration': '15 min', 'trimester': 'All Trimester'},
  ];
}

class _StretchingRoutineCard extends StatelessWidget {
  final String name;
  final String duration;
  final String trimester;
  final ColorScheme colorScheme;
  final TextTheme textTheme;

  const _StretchingRoutineCard({
    required this.name,
    required this.duration,
    required this.trimester,
    required this.colorScheme,
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '$name stretching routine, $duration, tap to view guide',
      button: true,
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.morningMist,
          borderRadius: BorderRadius.circular(AppTheme.radiusLg),
          boxShadow: const [
            BoxShadow(
              color: AppTheme.shadow,
              blurRadius: 16,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: AppTheme.transparent,
          child: InkWell(
            onTap: () {
              // TODO: Navigate to stretching guide sheet
            },
            borderRadius: BorderRadius.circular(AppTheme.radiusLg),
            child: Padding(
              padding: const EdgeInsets.all(AppTheme.spaceMd),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: textTheme.titleMedium?.copyWith(
                            color: colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: AppTheme.spaceXxs),
                        Text(
                          duration,
                          style: textTheme.bodyMedium?.copyWith(
                            color: AppTheme.stoneGrey,
                          ),
                        ),
                        const SizedBox(height: AppTheme.spaceXs),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.blushRose,
                            borderRadius: BorderRadius.circular(AppTheme.radiusPill),
                          ),
                          child: Text(
                            trimester,
                            style: textTheme.labelSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: colorScheme.onSurface,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ExcludeSemantics(
                    child: Icon(
                      Icons.chevron_right,
                      size: 20,
                      color: AppTheme.stoneGrey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}