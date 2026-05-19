import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../theme/app_theme.dart';

class PregnancyProgressScreen extends StatefulWidget {
  const PregnancyProgressScreen({super.key});

  @override
  State<PregnancyProgressScreen> createState() => _PregnancyProgressScreenState();
}

class _PregnancyProgressScreenState extends State<PregnancyProgressScreen> {
  late PageController _pageController;
  int _currentWeek = 12;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentWeek - 1);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

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
        ),
        title: Text(
          'My Pregnancy',
          style: textTheme.headlineSmall?.copyWith(
            color: colorScheme.onSurface,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: 40,
            onPageChanged: (index) {
              setState(() {
                _currentWeek = index + 1;
              });
            },
            itemBuilder: (context, index) {
              final week = index + 1;
              return _WeekPage(week: week);
            },
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _DueDateSummaryCard(currentWeek: _currentWeek),
          ),
        ],
      ),
    );
  }
}

class _WeekPage extends StatelessWidget {
  final int week;

  const _WeekPage({required this.week});

  @override
  Widget build(BuildContext context) {
    final trimester = _getTrimester(week);
    final weeksRemaining = 40 - week;
    final dueDate = DateTime(2026, 1, 15);
    final fruitEmoji = _getFruitEmoji(week);

    return SingleChildScrollView(
      padding: const EdgeInsets.only(
        left: AppTheme.spaceMd,
        right: AppTheme.spaceMd,
        top: AppTheme.spaceXs,
        bottom: 160,
      ),
      child: Column(
        children: [
          _WeekHeroCard(
            week: week,
            trimester: trimester,
            weeksRemaining: weeksRemaining,
            dueDate: dueDate,
            fruitEmoji: fruitEmoji,
          ),
          const SizedBox(height: AppTheme.spaceMd),
          _BodyChangesCard(week: week),
          const SizedBox(height: AppTheme.spaceMd),
          _BabyDevelopmentCard(week: week),
          const SizedBox(height: AppTheme.spaceMd),
          _SelfCareTipsCard(week: week),
        ],
      ),
    );
  }

  String _getTrimester(int week) {
    if (week <= 13) return 'First Trimester';
    if (week <= 26) return 'Second Trimester';
    return 'Third Trimester';
  }

  String _getFruitEmoji(int week) {
    const fruits = [
      ' poppy seed', // 4
      ' sesame seed', // 5
      '🫐 blueberry', // 6
      '🫐 blueberry', // 7
      '🫐 blueberry', // 8
      '🫐 blueberry', // 9
      '🫐 blueberry', // 10
      '🍒 cherry', // 11
      '🍒 cherry', // 12
      '🍒 cherry', // 12
      '🍅 tomato', // 12
    ];
    if (week < 4) return '🌱 seed';
    if (week > 12) return '🍅 tomato';
    return fruits[week - 4];
  }
}

class _WeekHeroCard extends StatelessWidget {
  final int week;
  final String trimester;
  final int weeksRemaining;
  final DateTime dueDate;
  final String fruitEmoji;

  const _WeekHeroCard({
    required this.week,
    required this.trimester,
    required this.weeksRemaining,
    required this.dueDate,
    required this.fruitEmoji,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppTheme.spaceLg),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            colorScheme.tertiary,
            colorScheme.surface,
          ],
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: colorScheme.tertiary.withValues(alpha: 0.5),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                fruitEmoji.split(' ').first,
                style: const TextStyle(fontSize: 40),
              ),
            ),
          ),
          const SizedBox(height: AppTheme.spaceSm),
          Text(
            'Week $week',
            style: TextStyle(
              fontSize: 57,
              fontWeight: FontWeight.w700,
              height: 64 / 57,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(height: AppTheme.spaceXs),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.spaceSm,
              vertical: AppTheme.spaceXxs,
            ),
            decoration: BoxDecoration(
              color: colorScheme.tertiary.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(AppTheme.radiusPill),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  trimester,
                  style: textTheme.labelLarge?.copyWith(
                    color: colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppTheme.spaceXs),
          Text(
            '$weeksRemaining weeks to go',
            style: textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppTheme.spaceXxs),
          Text(
            'Due ${dueDate.month}/${dueDate.day}/${dueDate.year}',
            style: textTheme.labelSmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _BodyChangesCard extends StatelessWidget {
  final int week;

  const _BodyChangesCard({required this.week});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    final bodyChanges = _getBodyChanges(week);

    return Container(
      padding: const EdgeInsets.all(AppTheme.spaceMd),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        boxShadow: const [
          BoxShadow(
            color: AppTheme.shadow,
            blurRadius: 24,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Body Changes',
            style: textTheme.titleLarge?.copyWith(
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: AppTheme.spaceSm),
          ...bodyChanges.map(
            (change) => Padding(
              padding: const EdgeInsets.only(bottom: AppTheme.spaceSm),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    margin: const EdgeInsets.only(top: 6),
                    decoration: BoxDecoration(
                      color: colorScheme.tertiary,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: AppTheme.spaceSm),
                  Expanded(
                    child: Text(
                      change,
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<String> _getBodyChanges(int week) {
    const changes = {
      12: [
        'Your uterus is now about the size of a grapefruit',
        'You may experience mild cramping or round ligament pain',
        'Fatigue may continue, but energy often improves this trimester',
      ],
      24: [
        'Your belly is growing noticeably',
        'You may feel the baby move soon (quickening)',
        'Leg cramps and swelling may occur',
      ],
    };
    return changes[week] ??
        [
          'Your body is adapting to pregnancy',
          'Hormonal changes may affect your mood',
          'Stay hydrated and rest when needed',
        ];
  }
}

class _BabyDevelopmentCard extends StatelessWidget {
  final int week;

  const _BabyDevelopmentCard({required this.week});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Container(
      padding: const EdgeInsets.all(AppTheme.spaceMd),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        boxShadow: const [
          BoxShadow(
            color: AppTheme.shadow,
            blurRadius: 24,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Baby\'s Development',
            style: textTheme.titleLarge?.copyWith(
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: AppTheme.spaceSm),
          Text(
            _getBabyDevelopment(week),
            style: textTheme.bodyLarge?.copyWith(
              color: colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  String _getBabyDevelopment(int week) {
    const developments = {
      12:
          'Your baby is now about 2 inches long — the size of a plum! Fingers and toes are fully formed, and tooth buds are appearing beneath the gums. The brain continues to develop rapidly, and your baby may start making small movements you can\'t feel yet.',
      24:
          'Your baby is about 12 inches long — the size of a papaya! The brain is developing rapidly, and the baby can hear your voice. Fat is beginning to accumulate, giving the skin a smoother appearance.',
    };
    return developments[week] ??
        'Your baby is growing and developing. Each week brings new milestones.';
  }
}

class _SelfCareTipsCard extends StatefulWidget {
  final int week;

  const _SelfCareTipsCard({required this.week});

  @override
  State<_SelfCareTipsCard> createState() => _SelfCareTipsCardState();
}

class _SelfCareTipsCardState extends State<_SelfCareTipsCard> {
  int _expandedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    final tips = _getSelfCareTips(widget.week);

    return Container(
      padding: const EdgeInsets.all(AppTheme.spaceMd),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        boxShadow: const [
          BoxShadow(
            color: AppTheme.shadow,
            blurRadius: 24,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Self-Care Tips',
            style: textTheme.titleLarge?.copyWith(
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: AppTheme.spaceSm),
          ...List.generate(tips.length, (index) {
            final tip = tips[index];
            final isExpanded = _expandedIndex == index;
            return Padding(
              padding: const EdgeInsets.only(bottom: AppTheme.spaceSm),
              child: _ExpandableTipTile(
                number: index + 1,
                title: tip['title']!,
                detail: tip['detail']!,
                isExpanded: isExpanded,
                onTap: () {
                  setState(() {
                    _expandedIndex = isExpanded ? -1 : index;
                  });
                },
              ),
            );
          }),
        ],
      ),
    );
  }

  List<Map<String, String>> _getSelfCareTips(int week) {
    const tips = {
      12: [
        {
          'title': 'Stay hydrated',
          'detail':
              'Aim for 8-10 glasses of water daily. Staying hydrated helps prevent UTIs and constipation, common during pregnancy.',
        },
        {
          'title': 'Try gentle exercise',
          'detail':
              'Walking or prenatal yoga can help with energy levels and prepare your body for labor.',
        },
        {
          'title': 'Schedule your anatomy scan',
          'detail':
              'Your 20-week anatomy scan is approaching. This detailed ultrasound checks baby\'s development and is often covered by insurance.',
        },
      ],
      24: [
        {
          'title': 'Practice good posture',
          'detail':
              'As your belly grows, focus on standing and sitting with good alignment to reduce back pain.',
        },
        {
          'title': 'Continue staying active',
          'detail':
              'Regular low-impact exercise like swimming or walking can help with circulation and energy.',
        },
        {
          'title': 'Start planning the nursery',
          'detail':
              'This is a great time to start thinking about nursery themes and gathering essential items.',
        },
      ],
    };
    return tips[week] ??
        [
          {
            'title': 'Stay hydrated',
            'detail': 'Drink plenty of water throughout the day.',
          },
          {
            'title': 'Rest when needed',
            'detail': 'Listen to your body and rest when you feel tired.',
          },
          {
            'title': 'Attend prenatal appointments',
            'detail': 'Regular check-ups help monitor your pregnancy progress.',
          },
        ];
  }
}

class _ExpandableTipTile extends StatelessWidget {
  final int number;
  final String title;
  final String detail;
  final bool isExpanded;
  final VoidCallback onTap;

  const _ExpandableTipTile({
    required this.number,
    required this.title,
    required this.detail,
    required this.isExpanded,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppTheme.spaceSm),
        decoration: BoxDecoration(
          border: Border.all(color: colorScheme.outline),
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: colorScheme.tertiary,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '$number',
                      style: textTheme.labelLarge?.copyWith(
                        color: colorScheme.surface,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppTheme.spaceSm),
                Expanded(
                  child: Text(
                    title,
                    style: textTheme.titleMedium?.copyWith(
                      color: colorScheme.onSurface,
                    ),
                  ),
                ),
                Icon(
                  isExpanded ? Icons.expand_less : Icons.expand_more,
                  size: 20,
                  color: colorScheme.onSurfaceVariant,
                ),
              ],
            ),
            if (isExpanded) ...[
              const SizedBox(height: AppTheme.spaceXs),
              Padding(
                padding: const EdgeInsets.only(left: 44),
                child: Text(
                  detail,
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurface,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _DueDateSummaryCard extends StatelessWidget {
  final int currentWeek;

  const _DueDateSummaryCard({required this.currentWeek});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    final trimester = _getTrimester(currentWeek);
    final dueDate = DateTime(2026, 1, 15);
    final daysRemaining = dueDate.difference(DateTime.now()).inDays;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
        boxShadow: const [
          BoxShadow(
            color: AppTheme.shadow,
            blurRadius: 24,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppTheme.spaceLg,
            vertical: AppTheme.spaceMd,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.spaceSm,
                      vertical: AppTheme.spaceXxs,
                    ),
                    decoration: BoxDecoration(
                      color: colorScheme.primary,
                      borderRadius: BorderRadius.circular(AppTheme.radiusPill),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.star,
                          size: 16,
                          color: colorScheme.onPrimary,
                        ),
                        const SizedBox(width: AppTheme.spaceXxs),
                        Text(
                          trimester,
                          style: textTheme.labelMedium?.copyWith(
                            color: colorScheme.onPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppTheme.spaceXs),
                  Text(
                    'Due Date',
                    style: textTheme.labelSmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  Text(
                    '${dueDate.month}/${dueDate.day}/${dueDate.year}',
                    style: textTheme.titleMedium?.copyWith(
                      color: colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '$daysRemaining',
                    style: textTheme.headlineLarge?.copyWith(
                      color: AppTheme.success,
                    ),
                  ),
                  Text(
                    'days to go',
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getTrimester(int week) {
    if (week <= 13) return 'First Trimester';
    if (week <= 26) return 'Second Trimester';
    return 'Third Trimester';
  }
}