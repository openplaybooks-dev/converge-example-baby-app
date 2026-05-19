import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:folio/theme/app_theme.dart';

class EducationScreen extends StatelessWidget {
  const EducationScreen({super.key});

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
          'Education',
          style: textTheme.titleLarge,
        ),
        actions: [
          IconButton(
            onPressed: () => _showSearchOverlay(context),
            icon: const Icon(Icons.search, size: 24),
            padding: EdgeInsets.zero,
            visualDensity: VisualDensity.compact,
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          // Featured Article Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppTheme.spaceMd),
              child: _FeaturedArticleCard(
                title: 'Understanding Baby Growth: Week by Week',
                topic: 'Maternal Care',
                readTime: '8 min read',
                onTap: () => context.push('/article-reader/featured-1'),
              ),
            ),
          ),

          // Topics Section Header
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppTheme.spaceMd,
                vertical: AppTheme.spaceXs,
              ),
              child: Text(
                'Topics',
                style: textTheme.headlineMedium,
              ),
            ),
          ),

          // Topics Grid (2 columns)
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: AppTheme.spaceMd),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: AppTheme.spaceSm,
                crossAxisSpacing: AppTheme.spaceSm,
                childAspectRatio: 1.3,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final topics = [
                    _TopicData(
                      name: 'Nutrition',
                      icon: Icons.restaurant_outlined,
                      color: AppTheme.lavenderBloom,
                    ),
                    _TopicData(
                      name: 'Body Changes',
                      icon: Icons.pregnant_woman_outlined,
                      color: AppTheme.blushRose,
                    ),
                    _TopicData(
                      name: 'Maternal Care',
                      icon: Icons.medical_services_outlined,
                      color: AppTheme.lavenderBloom,
                    ),
                    _TopicData(
                      name: 'Exercise',
                      icon: Icons.fitness_center_outlined,
                      color: AppTheme.softMint,
                    ),
                    _TopicData(
                      name: 'Mental Health',
                      icon: Icons.psychology_outlined,
                      color: AppTheme.blushRose,
                    ),
                  ];
                  final topic = topics[index];
                  return _TopicCard(data: topic).animate().fadeIn(
                        duration: 200.ms,
                        delay: Duration(milliseconds: index * 50),
                      );
                },
                childCount: 5,
              ),
            ),
          ),

          // Recent Articles Section Header
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(
                left: AppTheme.spaceMd,
                right: AppTheme.spaceMd,
                top: AppTheme.spaceLg,
                bottom: AppTheme.spaceXs,
              ),
              child: Text(
                'Recent Articles',
                style: textTheme.headlineMedium,
              ),
            ),
          ),

          // Recent Articles Horizontal List
          SliverToBoxAdapter(
            child: SizedBox(
              height: 220,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: AppTheme.spaceMd),
                itemCount: 3,
                itemBuilder: (context, index) {
                  final articles = [
                    _ArticlePreviewData(
                      title: 'Best Foods for Morning Sickness',
                      topic: 'Nutrition',
                      readTime: '5 min',
                    ),
                    _ArticlePreviewData(
                      title: 'Managing Fatigue in First Trimester',
                      topic: 'Body Changes',
                      readTime: '4 min',
                    ),
                    _ArticlePreviewData(
                      title: 'Prenatal Vitamins: What You Need',
                      topic: 'Maternal Care',
                      readTime: '6 min',
                    ),
                  ];
                  final article = articles[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: AppTheme.spaceSm),
                    child: _RecentArticleCard(
                      data: article,
                      onTap: () => context.push('/article-reader/recent-$index'),
                    ),
                  ).animate().fadeIn(
                        duration: 200.ms,
                        delay: Duration(milliseconds: 250 + (index * 50)),
                      );
                },
              ),
            ),
          ),

          // Bottom padding for safe area
          const SliverToBoxAdapter(
            child: SizedBox(height: AppTheme.spaceLg),
          ),
        ],
      ),
    );
  }

  void _showSearchOverlay(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppTheme.transparent,
      builder: (context) => const _SearchOverlay(),
    );
  }
}

class _FeaturedArticleCard extends StatefulWidget {
  final String title;
  final String topic;
  final String readTime;
  final VoidCallback onTap;

  const _FeaturedArticleCard({
    required this.title,
    required this.topic,
    required this.readTime,
    required this.onTap,
  });

  @override
  State<_FeaturedArticleCard> createState() => _FeaturedArticleCardState();
}

class _FeaturedArticleCardState extends State<_FeaturedArticleCard> {
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTapDown: (_) => setState(() => _scale = 0.98),
      onTapUp: (_) => setState(() => _scale = 1.0),
      onTapCancel: () => setState(() => _scale = 1.0),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 200),
        child: Card(
          color: isDark ? AppTheme.deepTwilight : AppTheme.morningMist,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.radiusLg),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hero image placeholder
              Container(
                height: 180,
                decoration: BoxDecoration(
                  color: AppTheme.lavenderTint.withValues(alpha: 0.5),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(AppTheme.radiusLg),
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.article_outlined,
                    size: 48,
                    color: AppTheme.lavenderBloom.withValues(alpha: 0.5),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(AppTheme.spaceMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Topic badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppTheme.spaceSm,
                        vertical: AppTheme.spaceXxs,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.lavenderBloom,
                        borderRadius: BorderRadius.circular(AppTheme.radiusPill),
                      ),
                      child: Text(
                        widget.topic,
                        style: textTheme.labelSmall?.copyWith(
                          color: AppTheme.warmWhite,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppTheme.spaceSm),
                    // Title
                    Text(
                      widget.title,
                      style: textTheme.displayLarge?.copyWith(
                        fontSize: 24,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppTheme.spaceXs),
                    // Read time
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 14,
                          color: AppTheme.stoneGrey,
                        ),
                        const SizedBox(width: AppTheme.spaceXxs),
                        Text(
                          widget.readTime,
                          style: textTheme.labelSmall,
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
    ).animate().fadeIn(duration: 200.ms);
  }
}

class _TopicData {
  final String name;
  final IconData icon;
  final Color color;

  const _TopicData({
    required this.name,
    required this.icon,
    required this.color,
  });
}

class _TopicCard extends StatefulWidget {
  final _TopicData data;

  const _TopicCard({required this.data});

  @override
  State<_TopicCard> createState() => _TopicCardState();
}

class _TopicCardState extends State<_TopicCard> {
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTapDown: (_) => setState(() => _scale = 0.98),
      onTapUp: (_) => setState(() => _scale = 1.0),
      onTapCancel: () => setState(() => _scale = 1.0),
      onTap: () => context.push('/education/${widget.data.name.toLowerCase().replaceAll(' ', '-')}'),
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 200),
        child: Card(
          color: isDark ? AppTheme.deepTwilight : AppTheme.morningMist,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.radiusLg),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppTheme.spaceMd),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon container
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: widget.data.color.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    widget.data.icon,
                    size: 24,
                    color: widget.data.color,
                  ),
                ),
                const SizedBox(height: AppTheme.spaceSm),
                Text(
                  widget.data.name,
                  style: textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ArticlePreviewData {
  final String title;
  final String topic;
  final String readTime;

  const _ArticlePreviewData({
    required this.title,
    required this.topic,
    required this.readTime,
  });
}

class _RecentArticleCard extends StatefulWidget {
  final _ArticlePreviewData data;
  final VoidCallback onTap;

  const _RecentArticleCard({
    required this.data,
    required this.onTap,
  });

  @override
  State<_RecentArticleCard> createState() => _RecentArticleCardState();
}

class _RecentArticleCardState extends State<_RecentArticleCard> {
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTapDown: (_) => setState(() => _scale = 0.98),
      onTapUp: (_) => setState(() => _scale = 1.0),
      onTapCancel: () => setState(() => _scale = 1.0),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 200),
        child: SizedBox(
          width: 160,
          child: Card(
            color: isDark ? AppTheme.deepTwilight : AppTheme.morningMist,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppTheme.radiusLg),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image placeholder
                Container(
                  height: 80,
                  decoration: BoxDecoration(
                    color: AppTheme.lavenderTint.withValues(alpha: 0.5),
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(AppTheme.radiusSm),
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.article_outlined,
                      size: 32,
                      color: AppTheme.lavenderBloom.withValues(alpha: 0.5),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(AppTheme.spaceSm),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.data.title,
                        style: textTheme.titleMedium,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: AppTheme.spaceXxs),
                      // Topic badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppTheme.spaceXs,
                          vertical: AppTheme.spaceXxs,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.lavenderBloom.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(AppTheme.radiusPill),
                        ),
                        child: Text(
                          widget.data.topic,
                          style: textTheme.labelSmall?.copyWith(
                            color: AppTheme.lavenderBloom,
                          ),
                        ),
                      ),
                      const SizedBox(height: AppTheme.spaceXxs),
                      // Read time
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 12,
                            color: AppTheme.stoneGrey,
                          ),
                          const SizedBox(width: AppTheme.spaceXxs),
                          Text(
                            widget.data.readTime,
                            style: textTheme.labelSmall,
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
    );
  }
}

class _SearchOverlay extends StatefulWidget {
  const _SearchOverlay();

  @override
  State<_SearchOverlay> createState() => _SearchOverlayState();
}

class _SearchOverlayState extends State<_SearchOverlay> {
  final _searchController = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        color: isDark ? AppTheme.deepTwilight : AppTheme.warmWhite,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppTheme.radiusLg),
        ),
      ),
      child: Column(
        children: [
          // Drag handle
          Padding(
            padding: const EdgeInsets.only(top: AppTheme.spaceSm),
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppTheme.mistyBorder,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          // Search input
          Padding(
            padding: const EdgeInsets.all(AppTheme.spaceMd),
            child: TextField(
              controller: _searchController,
              focusNode: _focusNode,
              decoration: InputDecoration(
                hintText: 'Search articles...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                  borderSide: BorderSide(color: AppTheme.mistyBorder),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                  borderSide: BorderSide(color: AppTheme.mistyBorder),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                  borderSide: BorderSide(color: AppTheme.lavenderBloom, width: 2),
                ),
                filled: true,
                fillColor: isDark ? AppTheme.nightSky : AppTheme.morningMist,
              ),
              onSubmitted: (value) {
                // Search logic would go here
              },
            ),
          ),
          // Recent searches
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppTheme.spaceMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Recent Searches',
                  style: textTheme.titleMedium,
                ),
                const SizedBox(height: AppTheme.spaceSm),
                Wrap(
                  spacing: AppTheme.spaceXs,
                  runSpacing: AppTheme.spaceXs,
                  children: [
                    'Morning sickness',
                    'Prenatal vitamins',
                    'Exercise tips',
                  ]
                      .map((term) => ActionChip(
                            label: Text(term),
                            onPressed: () {
                              _searchController.text = term;
                            },
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppTheme.spaceMd),
          // Search results placeholder
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.search,
                    size: 64,
                    color: AppTheme.stoneGrey.withValues(alpha: 0.5),
                  ),
                  const SizedBox(height: AppTheme.spaceSm),
                  Text(
                    'Search for articles by keyword',
                    style: textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}