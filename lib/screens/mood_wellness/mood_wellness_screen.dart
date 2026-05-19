import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../theme/app_theme.dart';

class MoodWellnessScreen extends StatelessWidget {
  const MoodWellnessScreen({super.key});

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
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios, size: 24),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
          tooltip: 'Go back',
        ),
        title: Text(
          'Mood & Wellness',
          style: textTheme.headlineSmall?.copyWith(
            color: colorScheme.onSurface,
          ),
        ),
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppTheme.spaceMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: AppTheme.spaceXs),
                  _TodaysMoodCard(
                    textTheme: textTheme,
                    colorScheme: colorScheme,
                  ),
                  const SizedBox(height: AppTheme.spaceLg),
                  _MoodTrendChart(
                    textTheme: textTheme,
                    colorScheme: colorScheme,
                  ),
                  const SizedBox(height: AppTheme.spaceLg),
                  _EnergyTrendChart(
                    textTheme: textTheme,
                    colorScheme: colorScheme,
                  ),
                  const SizedBox(height: AppTheme.spaceLg),
                  _WellnessTipCard(
                    textTheme: textTheme,
                    colorScheme: colorScheme,
                  ),
                  const SizedBox(height: AppTheme.spaceLg),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TodaysMoodCard extends StatelessWidget {
  final TextTheme textTheme;
  final ColorScheme colorScheme;

  const _TodaysMoodCard({
    required this.textTheme,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: Integrate with MoodEntryProvider
    const selectedMood = 4; // 1-5 scale, null if not logged today

    return Container(
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
            // TODO: Focus note field if needed
          },
          borderRadius: BorderRadius.circular(AppTheme.radiusLg),
          child: Padding(
            padding: const EdgeInsets.all(AppTheme.spaceMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'How are you feeling today?',
                          style: textTheme.titleMedium?.copyWith(
                            color: colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: AppTheme.spaceXxs),
                        Text(
                          'May 19, 2026',
                          style: textTheme.bodyMedium?.copyWith(
                            color: AppTheme.stoneGrey,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.softMint.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(AppTheme.radiusPill),
                      ),
                      child: Text(
                        'Today',
                        style: textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppTheme.spaceMd),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _MoodEmoji(
                      emoji: '\u{1F614}', // 😔
                      score: 1,
                      label: 'Terrible',
                      isSelected: selectedMood == 1,
                      colorScheme: colorScheme,
                      textTheme: textTheme,
                    ),
                    _MoodEmoji(
                      emoji: '\u{1F615}', // 😕
                      score: 2,
                      label: 'Bad',
                      isSelected: selectedMood == 2,
                      colorScheme: colorScheme,
                      textTheme: textTheme,
                    ),
                    _MoodEmoji(
                      emoji: '\u{1F610}', // 😐
                      score: 3,
                      label: 'Okay',
                      isSelected: selectedMood == 3,
                      colorScheme: colorScheme,
                      textTheme: textTheme,
                    ),
                    _MoodEmoji(
                      emoji: '\u{1F642}', // 🙂
                      score: 4,
                      label: 'Good',
                      isSelected: selectedMood == 4,
                      colorScheme: colorScheme,
                      textTheme: textTheme,
                    ),
                    _MoodEmoji(
                      emoji: '\u{1F60A}', // 😊
                      score: 5,
                      label: 'Great',
                      isSelected: selectedMood == 5,
                      colorScheme: colorScheme,
                      textTheme: textTheme,
                    ),
                  ],
                ),
                const SizedBox(height: AppTheme.spaceMd),
                TextField(
                  maxLength: 200,
                  maxLines: 3,
                  minLines: 2,
                  decoration: InputDecoration(
                    hintText: 'Add a note (optional, max 200 characters)',
                    hintStyle: textTheme.bodyMedium?.copyWith(
                      color: AppTheme.stoneGrey,
                    ),
                    filled: true,
                    fillColor: AppTheme.mistyBorder.withValues(alpha: 0.5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                      borderSide: BorderSide(
                        color: colorScheme.primary.withValues(alpha: 0.3),
                        width: 2,
                      ),
                    ),
                    counterStyle: textTheme.labelSmall?.copyWith(
                      color: AppTheme.stoneGrey,
                    ),
                    contentPadding: const EdgeInsets.all(AppTheme.spaceSm),
                  ),
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ).animate().fadeIn(duration: 300.ms).slideY(begin: 0.1, end: 0);
  }
}

class _MoodEmoji extends StatelessWidget {
  final String emoji;
  final int score;
  final String label;
  final bool isSelected;
  final ColorScheme colorScheme;
  final TextTheme textTheme;

  const _MoodEmoji({
    required this.emoji,
    required this.score,
    required this.label,
    required this.isSelected,
    required this.colorScheme,
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '$label mood, tap to log',
      button: true,
      child: GestureDetector(
        onTap: () {
          // TODO: MoodEntryProvider.logMood(score)
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isSelected
                ? AppTheme.blushRose.withValues(alpha: 0.2)
                : AppTheme.morningMist,
            border: Border.all(
              color: isSelected ? AppTheme.blushRose : AppTheme.mistyBorder,
              width: isSelected ? 3 : 2,
            ),
          ),
          child: Center(
            child: Text(
              emoji,
              style: const TextStyle(fontSize: 28),
            ),
          ),
        ),
      ),
    );
  }
}

class _MoodTrendChart extends StatelessWidget {
  final TextTheme textTheme;
  final ColorScheme colorScheme;

  const _MoodTrendChart({
    required this.textTheme,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spaceMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Mood Trend',
                  style: textTheme.titleMedium?.copyWith(
                    color: colorScheme.onSurface,
                  ),
                ),
                Row(
                  children: [
                    _ChartChip(
                      label: '1W',
                      isSelected: true,
                      colorScheme: colorScheme,
                      textTheme: textTheme,
                    ),
                    const SizedBox(width: AppTheme.spaceXxs),
                    _ChartChip(
                      label: '1M',
                      isSelected: false,
                      colorScheme: colorScheme,
                      textTheme: textTheme,
                    ),
                    const SizedBox(width: AppTheme.spaceXxs),
                    _ChartChip(
                      label: 'All',
                      isSelected: false,
                      colorScheme: colorScheme,
                      textTheme: textTheme,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spaceSm),
            SizedBox(
              height: 160,
              child: Semantics(
                label: 'Mood trend chart showing 7 day history',
                child: CustomPaint(
                  size: const Size(double.infinity, 160),
                  painter: _MoodChartPainter(),
                ),
              ),
            ),
            const SizedBox(height: AppTheme.spaceXs),
            Row(
              children: [
                Text(
                  'Score',
                  style: textTheme.labelSmall?.copyWith(
                    color: AppTheme.stoneGrey,
                  ),
                ),
                const SizedBox(width: AppTheme.spaceXxs),
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppTheme.lavenderBloom,
                  ),
                ),
                const SizedBox(width: AppTheme.spaceXxs),
                Text(
                  'Mood',
                  style: textTheme.labelSmall?.copyWith(
                    color: AppTheme.stoneGrey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 300.ms, delay: 50.ms).slideY(begin: 0.1, end: 0);
  }
}

class _MoodChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = AppTheme.mistyBorder
      ..strokeWidth = 1;

    // Draw grid lines
    for (var i = 0; i < 4; i++) {
      final y = 20.0 + (i * 30);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    // Y-axis labels
    final labelStyle = TextStyle(
      fontSize: 10,
      color: AppTheme.stoneGrey,
      fontFamily: 'Nunito',
    );

    _drawText(canvas, '\u{1F60A}', Offset(4, 16), labelStyle); // 😊
    _drawText(canvas, '\u{1F642}', Offset(4, 46), labelStyle); // 🙂
    _drawText(canvas, '\u{1F610}', Offset(4, 76), labelStyle); // 😐
    _drawText(canvas, '\u{1F622}', Offset(4, 106), labelStyle); // 😢

    // Line paint
    final linePaint = Paint()
      ..color = AppTheme.lavenderBloom
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Data points
    final pointPaint = Paint()
      ..color = AppTheme.lavenderBloom
      ..style = PaintingStyle.fill;

    // Draw mood line (sample data)
    final points = [
      Offset(0, 85),
      Offset(50, 78),
      Offset(100, 65),
      Offset(150, 55),
      Offset(200, 48),
      Offset(250, 40),
      Offset(300, 35),
    ];

    final path = Path();
    path.moveTo(points[0].dx, points[0].dy);
    for (var i = 1; i < points.length; i++) {
      final p0 = points[i - 1];
      final p1 = points[i];
      final cpX = (p0.dx + p1.dx) / 2;
      path.quadraticBezierTo(cpX, p0.dy, cpX, (p0.dy + p1.dy) / 2);
      path.quadraticBezierTo(cpX, p1.dy, p1.dx, p1.dy);
    }
    canvas.drawPath(path, linePaint);

    // Draw data points
    for (final point in points) {
      canvas.drawCircle(point, 5, pointPaint);
    }

    // X-axis labels
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    for (var i = 0; i < days.length; i++) {
      _drawText(
        canvas,
        days[i],
        Offset(i * 50.0, 125),
        labelStyle,
      );
    }
  }

  void _drawText(Canvas canvas, String text, Offset offset, TextStyle style) {
    final textSpan = TextSpan(text: text, style: style);
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _EnergyTrendChart extends StatelessWidget {
  final TextTheme textTheme;
  final ColorScheme colorScheme;

  const _EnergyTrendChart({
    required this.textTheme,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spaceMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Energy Trend',
                  style: textTheme.titleMedium?.copyWith(
                    color: colorScheme.onSurface,
                  ),
                ),
                Row(
                  children: [
                    _ChartChip(
                      label: '1W',
                      isSelected: true,
                      colorScheme: colorScheme,
                      textTheme: textTheme,
                    ),
                    const SizedBox(width: AppTheme.spaceXxs),
                    _ChartChip(
                      label: '1M',
                      isSelected: false,
                      colorScheme: colorScheme,
                      textTheme: textTheme,
                    ),
                    const SizedBox(width: AppTheme.spaceXxs),
                    _ChartChip(
                      label: 'All',
                      isSelected: false,
                      colorScheme: colorScheme,
                      textTheme: textTheme,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spaceSm),
            SizedBox(
              height: 160,
              child: Semantics(
                label: 'Energy trend chart showing 7 day history',
                child: CustomPaint(
                  size: const Size(double.infinity, 160),
                  painter: _EnergyChartPainter(),
                ),
              ),
            ),
            const SizedBox(height: AppTheme.spaceXs),
            Row(
              children: [
                Text(
                  'Level',
                  style: textTheme.labelSmall?.copyWith(
                    color: AppTheme.stoneGrey,
                  ),
                ),
                const SizedBox(width: AppTheme.spaceXxs),
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppTheme.softMint,
                  ),
                ),
                const SizedBox(width: AppTheme.spaceXxs),
                Text(
                  'Energy',
                  style: textTheme.labelSmall?.copyWith(
                    color: AppTheme.stoneGrey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 300.ms, delay: 100.ms).slideY(begin: 0.1, end: 0);
  }
}

class _EnergyChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = AppTheme.mistyBorder
      ..strokeWidth = 1;

    // Draw grid lines
    for (var i = 0; i < 4; i++) {
      final y = 20.0 + (i * 30);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    // Y-axis labels
    final labelStyle = TextStyle(
      fontSize: 10,
      color: AppTheme.stoneGrey,
      fontFamily: 'Nunito',
    );

    _drawText(canvas, 'High', Offset(4, 16), labelStyle);
    _drawText(canvas, 'Med', Offset(4, 46), labelStyle);
    _drawText(canvas, 'Low', Offset(4, 76), labelStyle);
    _drawText(canvas, 'VLow', Offset(4, 106), labelStyle);

    // Line paint
    final linePaint = Paint()
      ..color = AppTheme.softMint
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Data points
    final pointPaint = Paint()
      ..color = AppTheme.softMint
      ..style = PaintingStyle.fill;

    // Draw energy line (sample data)
    final points = [
      Offset(0, 90),
      Offset(50, 80),
      Offset(100, 75),
      Offset(150, 60),
      Offset(200, 50),
      Offset(250, 55),
      Offset(300, 50),
    ];

    final path = Path();
    path.moveTo(points[0].dx, points[0].dy);
    for (var i = 1; i < points.length; i++) {
      final p0 = points[i - 1];
      final p1 = points[i];
      final cpX = (p0.dx + p1.dx) / 2;
      path.quadraticBezierTo(cpX, p0.dy, cpX, (p0.dy + p1.dy) / 2);
      path.quadraticBezierTo(cpX, p1.dy, p1.dx, p1.dy);
    }
    canvas.drawPath(path, linePaint);

    // Draw data points
    for (final point in points) {
      canvas.drawCircle(point, 5, pointPaint);
    }

    // X-axis labels
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    for (var i = 0; i < days.length; i++) {
      _drawText(
        canvas,
        days[i],
        Offset(i * 50.0, 125),
        labelStyle,
      );
    }
  }

  void _drawText(Canvas canvas, String text, Offset offset, TextStyle style) {
    final textSpan = TextSpan(text: text, style: style);
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _WellnessTipCard extends StatefulWidget {
  final TextTheme textTheme;
  final ColorScheme colorScheme;

  const _WellnessTipCard({
    required this.textTheme,
    required this.colorScheme,
  });

  @override
  State<_WellnessTipCard> createState() => _WellnessTipCardState();
}

class _WellnessTipCardState extends State<_WellnessTipCard> {
  bool _isExpanded = false;

  // TODO: Replace with MoodEntryProvider data
  String get _tipText {
    return 'Your energy is improving! Try adding a 10-minute walk after meals to maintain this positive trend.';
  }

  String get _tipCategory => 'Mood';

  @override
  Widget build(BuildContext context) {
    final colorScheme = widget.colorScheme;
    final textTheme = widget.textTheme;

    return Container(
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
          onTap: () => setState(() => _isExpanded = !_isExpanded),
          borderRadius: BorderRadius.circular(AppTheme.radiusLg),
          child: Semantics(
            label: 'Wellness tip: $_tipText',
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              padding: const EdgeInsets.all(AppTheme.spaceMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.lightbulb_outline,
                            size: 20,
                            color: colorScheme.primary,
                          ),
                          const SizedBox(width: AppTheme.spaceSm),
                          Text(
                            'Wellness Tip',
                            style: textTheme.titleMedium?.copyWith(
                              color: colorScheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: colorScheme.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(AppTheme.radiusPill),
                        ),
                        child: Text(
                          _tipCategory,
                          style: textTheme.labelSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: colorScheme.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppTheme.spaceXs),
                  AnimatedCrossFade(
                    firstChild: Text(
                      _tipText,
                      style: textTheme.bodyMedium?.copyWith(
                        color: AppTheme.stoneGrey,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    secondChild: Text(
                      _tipText,
                      style: textTheme.bodyMedium?.copyWith(
                        color: AppTheme.stoneGrey,
                      ),
                    ),
                    crossFadeState: _isExpanded
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    duration: const Duration(milliseconds: 250),
                  ),
                  const SizedBox(height: AppTheme.spaceXs),
                  Center(
                    child: AnimatedRotation(
                      turns: _isExpanded ? 0.5 : 0,
                      duration: const Duration(milliseconds: 200),
                      child: Icon(
                        Icons.expand_more,
                        size: 16,
                        color: AppTheme.stoneGrey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ).animate().fadeIn(duration: 300.ms, delay: 150.ms).slideY(begin: 0.1, end: 0);
  }
}

class _ChartChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final ColorScheme colorScheme;
  final TextTheme textTheme;

  const _ChartChip({
    required this.label,
    required this.isSelected,
    required this.colorScheme,
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO: Toggle chart time range
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 6,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? colorScheme.primary.withValues(alpha: 0.15)
              : AppTheme.mistyBorder,
          borderRadius: BorderRadius.circular(AppTheme.radiusPill),
        ),
        child: Text(
          label,
          style: textTheme.labelSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: isSelected ? colorScheme.primary : colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}