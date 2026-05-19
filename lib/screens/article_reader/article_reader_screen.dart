import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:folio/theme/app_theme.dart';
import 'package:folio/screens/article_reader/_widgets/quote_callout.dart';
import 'package:folio/screens/article_reader/_widgets/BulletItem.dart';
import 'package:folio/screens/article_reader/_widgets/RelatedArticleCard.dart';

class ArticleReaderScreen extends StatelessWidget {
  final String articleId;

  const ArticleReaderScreen({
    super.key,
    required this.articleId,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 240,
            pinned: true,
            stretch: true,
            backgroundColor: colorScheme.primaryContainer,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const [
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
              ],
              background: Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    imageUrl:
                        'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?w=750&q=80',
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: colorScheme.surfaceContainerLow,
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: colorScheme.surfaceContainerLow,
                      child: Icon(
                        Icons.image_outlined,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          colorScheme.onSurface.withValues(alpha: 0.7),
                          colorScheme.onSurface.withValues(alpha: 0.2),
                          colorScheme.onSurface.withValues(alpha: 0.0),
                        ],
                        stops: const [0.0, 0.5, 1.0],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    top: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: colorScheme.tertiary,
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Text(
                              'Nutrition',
                              style: textTheme.labelMedium?.copyWith(
                                color: colorScheme.onTertiary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Understanding Iron Needs During Pregnancy',
                            style: textTheme.headlineMedium?.copyWith(
                              color: colorScheme.surface,
                              fontWeight: FontWeight.w600,
                              height: 28 / 22,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Text(
                                'Dr. Sarah Chen',
                                style: textTheme.bodySmall?.copyWith(
                                  color: colorScheme.surface.withValues(alpha: 0.9),
                                ),
                              ),
                              Text(
                                ' • ',
                                style: textTheme.bodySmall?.copyWith(
                                  color: colorScheme.surface.withValues(alpha: 0.9),
                                ),
                              ),
                              Text(
                                'May 15, 2026',
                                style: textTheme.bodySmall?.copyWith(
                                  color: colorScheme.surface.withValues(alpha: 0.9),
                                ),
                              ),
                              Text(
                                ' • ',
                                style: textTheme.bodySmall?.copyWith(
                                  color: colorScheme.surface.withValues(alpha: 0.9),
                                ),
                              ),
                              Text(
                                '5 min read',
                                style: textTheme.bodySmall?.copyWith(
                                  color: colorScheme.surface.withValues(alpha: 0.9),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: colorScheme.surface.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.arrow_back,
                  color: colorScheme.surface,
                  size: 24,
                ),
              ),
              tooltip: 'Navigate back',
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: colorScheme.surface.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.bookmark_outline,
                    color: colorScheme.surface,
                    size: 20,
                  ),
                ),
                tooltip: 'Bookmark article',
              ),
              IconButton(
                onPressed: () {},
                icon: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: colorScheme.surface.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.share_outlined,
                    color: colorScheme.surface,
                    size: 20,
                  ),
                ),
                tooltip: 'Share article',
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Why Iron Matters More Than Ever',
                    style: textTheme.headlineMedium?.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.w600,
                      height: 28 / 22,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'During pregnancy, your body needs nearly twice as much iron as usual to support the growth of your baby and the expansion of your own blood supply. Iron is essential for making hemoglobin — the protein in red blood cells that carries oxygen to your tissues and your growing baby.',
                    style: textTheme.bodyLarge?.copyWith(
                      color: colorScheme.onSurface,
                      height: 24 / 16,
                      letterSpacing: 0.15,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const QuoteCallout(
                    quote: '"Your iron needs jump from 18mg to 27mg daily during pregnancy — that\'s a 50% increase in just nine months."',
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Signs of Iron Deficiency',
                    style: textTheme.headlineMedium?.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.w600,
                      height: 28 / 22,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Many pregnant people don\'t realize they\'re low in iron until a blood test reveals the issue. But paying attention to early signs can help you catch deficiency before it becomes problematic.',
                    style: textTheme.bodyLarge?.copyWith(
                      color: colorScheme.onSurface,
                      height: 24 / 16,
                      letterSpacing: 0.15,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const BulletItem(
                    text: 'Unusual fatigue or weakness that doesn\'t ease with rest',
                  ),
                  const BulletItem(
                    text: 'Pale skin, especially in the eyelids, nails, or gums',
                  ),
                  const BulletItem(
                    text: 'Shortness of breath during normal activities',
                  ),
                  const BulletItem(
                    text: 'Persistent headaches or difficulty concentrating',
                  ),
                  const BulletItem(
                    text: 'Dizziness or lightheadedness',
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Iron-Rich Foods to Include',
                    style: textTheme.headlineMedium?.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.w600,
                      height: 28 / 22,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'The best approach to getting enough iron is through a balanced diet. Both heme iron (from animal sources) and non-heme iron (from plant sources and supplements) contribute to your daily needs, but heme iron is absorbed more efficiently by your body.',
                    style: textTheme.bodyLarge?.copyWith(
                      color: colorScheme.onSurface,
                      height: 24 / 16,
                      letterSpacing: 0.15,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const QuoteCallout(
                    quote: '"Pairing iron-rich foods with vitamin C — like orange slices with your spinach salad — can boost absorption by up to 6 times."',
                  ),
                  const SizedBox(height: 24),
                  Divider(
                    color: colorScheme.outline,
                    thickness: 1,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Related Articles',
                    style: textTheme.titleLarge?.copyWith(
                      color: colorScheme.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 160,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 12),
                      itemBuilder: (context, index) {
                        return RelatedArticleCard(
                          index: index,
                          onTap: () {},
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}