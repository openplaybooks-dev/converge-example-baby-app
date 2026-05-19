import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:folio/theme/app_theme.dart';

class RelatedArticleCard extends StatelessWidget {
  final int index;
  final VoidCallback onTap;

  const RelatedArticleCard({
    super.key,
    required this.index,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final cards = [
      _RelatedArticleData(
        bgColor: colorScheme.primary.withValues(alpha: 0.1),
        iconColor: colorScheme.primary.withValues(alpha: 0.4),
        title: 'Best Prenatal Vitamins for Morning Sickness',
        readTime: '4 min',
      ),
      _RelatedArticleData(
        bgColor: colorScheme.tertiaryContainer.withValues(alpha: 0.3),
        iconColor: colorScheme.tertiary.withValues(alpha: 0.4),
        title: 'Managing Pregnancy Fatigue Naturally',
        readTime: '5 min',
      ),
      _RelatedArticleData(
        bgColor: AppTheme.softMint.withValues(alpha: 0.1),
        iconColor: AppTheme.softMint.withValues(alpha: 0.4),
        title: 'Second Trimester Meal Planning',
        readTime: '6 min',
      ),
    ];

    final data = cards[index];

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 140,
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(16),
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
            Container(
              height: 80,
              decoration: BoxDecoration(
                color: data.bgColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.auto_stories_outlined,
                  size: 32,
                  color: data.iconColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.title,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurface,
                      fontWeight: FontWeight.w600,
                      height: 18 / 14,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 12,
                        color: colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        data.readTime,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
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
    )
        .animate(delay: Duration(milliseconds: index * 50))
        .fadeIn(duration: 300.ms)
        .slideX(begin: 0.2, end: 0, duration: 300.ms);
  }
}

class _RelatedArticleData {
  final Color bgColor;
  final Color iconColor;
  final String title;
  final String readTime;

  _RelatedArticleData({
    required this.bgColor,
    required this.iconColor,
    required this.title,
    required this.readTime,
  });
}