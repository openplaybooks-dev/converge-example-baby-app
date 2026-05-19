import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../theme/app_theme.dart';

class WeightNutritionScreen extends StatelessWidget {
  const WeightNutritionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.primary,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colorScheme.onPrimary),
          onPressed: () => Navigator.of(context).pop(),
          tooltip: 'Back to Browse',
        ),
        title: Text(
          'Weight & Nutrition',
          style: textTheme.titleLarge?.copyWith(color: colorScheme.onPrimary),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppTheme.spaceMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(AppTheme.spaceLg),
                  _WeightProgressChart(),
                  const Gap(AppTheme.spaceLg),
                  _LatestEntryCard(),
                  const Gap(AppTheme.spaceLg),
                  _NutritionTipsCard(),
                  const Gap(AppTheme.spaceLg),
                  _WeightLogSection(),
                  const Gap(100),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddWeightSheet(context),
        backgroundColor: AppTheme.lavenderBloom,
        elevation: 4,
        child: Icon(Icons.add, color: colorScheme.onPrimary),
      ).animate().fade(duration: 200.ms).scale(
            begin: const Offset(0.95, 0.95),
            end: const Offset(1, 1),
            duration: 200.ms,
          ),
    );
  }

  void _showAddWeightSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppTheme.transparent,
      builder: (context) => const _AddWeightBottomSheet(),
    );
  }
}

// ============================================================================
// Section 1: Weight Progress Chart
// ============================================================================

class _WeightProgressChart extends StatefulWidget {
  @override
  State<_WeightProgressChart> createState() => _WeightProgressChartState();
}

class _WeightProgressChartState extends State<_WeightProgressChart> {
  String _selectedRange = '1W';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spaceMd),
      decoration: BoxDecoration(
        color: AppTheme.warmWhite,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        boxShadow: const [
          BoxShadow(color: AppTheme.shadow, blurRadius: 24, offset: Offset(0, 8)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Weight Progress',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const Gap(AppTheme.spaceSm),
          Row(
            children: [
              _buildChip('1W', '1W'),
              const Gap(AppTheme.spaceXs),
              _buildChip('1M', '1M'),
              const Gap(AppTheme.spaceXs),
              _buildChip('All', 'All'),
            ],
          ),
          const Gap(AppTheme.spaceMd),
          SizedBox(
            height: 192,
            child: _buildChart(),
          ),
        ],
      ),
    ).animate().fade(duration: 200.ms);
  }

  Widget _buildChip(String label, String value) {
    final isSelected = _selectedRange == value;
    return GestureDetector(
      onTap: () => setState(() => _selectedRange = value),
      child: AnimatedContainer(
        duration: 150.ms,
        padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.spaceSm,
          vertical: AppTheme.spaceXs,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.lavenderBloom.withValues(alpha: 0.15)
              : AppTheme.stoneGrey.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(AppTheme.radiusSm),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isSelected ? AppTheme.lavenderBloom : AppTheme.stoneGrey,
          ),
        ),
      ),
    );
  }

  Widget _buildChart() {
    return CustomPaint(
      size: const Size(double.infinity, 192),
      painter: _ChartPainter(),
    );
  }
}

class _ChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = AppTheme.lavenderBloom
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          AppTheme.lavenderBloom.withValues(alpha: 0.2),
          AppTheme.lavenderBloom.withValues(alpha: 0),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    final dotPaint = Paint()
      ..color = AppTheme.lavenderBloom
      ..style = PaintingStyle.fill;

    final gridPaint = Paint()
      ..color = AppTheme.mistyBorder.withValues(alpha: 0.5)
      ..strokeWidth = 1;

    // Draw grid lines
    for (var i = 0; i < 4; i++) {
      final y = size.height * (i / 3);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    // Chart data points
    final points = [
      Offset(0, size.height * 0.75),
      Offset(size.width * 0.25, size.height * 0.55),
      Offset(size.width * 0.5, size.height * 0.45),
      Offset(size.width * 0.75, size.height * 0.35),
      Offset(size.width, size.height * 0.2),
    ];

    // Draw fill
    final fillPath = Path()
      ..moveTo(0, size.height)
      ..lineTo(points.first.dx, points.first.dy);

    for (final point in points) {
      fillPath.lineTo(point.dx, point.dy);
    }
    fillPath.lineTo(size.width, size.height);
    fillPath.close();
    canvas.drawPath(fillPath, fillPaint);

    // Draw line
    final linePath = Path()..moveTo(points.first.dx, points.first.dy);
    for (final point in points) {
      linePath.lineTo(point.dx, point.dy);
    }
    canvas.drawPath(linePath, linePaint);

    // Draw dots
    for (final point in points) {
      canvas.drawCircle(point, 4, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ============================================================================
// Section 2: Latest Entry Card
// ============================================================================

class _LatestEntryCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spaceMd),
      decoration: BoxDecoration(
        color: AppTheme.morningMist,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        boxShadow: const [
          BoxShadow(color: AppTheme.shadow, blurRadius: 24, offset: Offset(0, 8)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Today's Weight",
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppTheme.stoneGrey,
                  letterSpacing: 0.5,
                ),
          ),
          const Gap(AppTheme.spaceXs),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                '64.5',
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const Gap(AppTheme.spaceXs),
              Text(
                'kg',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppTheme.stoneGrey,
                    ),
              ),
            ],
          ),
          const Gap(AppTheme.spaceXs),
          Row(
            children: [
              Icon(
                Icons.arrow_upward,
                size: 20,
                color: AppTheme.softCoral,
              ),
              const Gap(AppTheme.spaceXxs),
              Text(
                '+0.8',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: AppTheme.softCoral,
                    ),
              ),
              const Gap(AppTheme.spaceXs),
              Text(
                'from last entry',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          const Gap(AppTheme.spaceXs),
          Text(
            'Logged at 8:30 AM',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    ).animate().fade(delay: 50.ms, duration: 200.ms);
  }
}

// ============================================================================
// Section 3: Nutrition Tips Card
// ============================================================================

class _NutritionTipsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final tips = [
      'Focus on iron-rich foods like spinach, lentils, and lean red meat to support increased blood volume',
      'Stay hydrated with 8-10 glasses of water daily',
      'Include calcium-rich foods for baby\'s bone development',
      'Small, frequent meals can help with digestion and energy levels',
    ];

    return Container(
      padding: const EdgeInsets.all(AppTheme.spaceMd),
      decoration: BoxDecoration(
        color: AppTheme.lavenderTint,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        boxShadow: const [
          BoxShadow(color: AppTheme.shadow, blurRadius: 24, offset: Offset(0, 8)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Nutrition Tips',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spaceSm,
                  vertical: AppTheme.spaceXxs + 2,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.lavenderBloom,
                  borderRadius: BorderRadius.circular(AppTheme.radiusPill),
                ),
                child: Text(
                  'Week 24',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: colorScheme.onPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            ],
          ),
          const Gap(AppTheme.spaceSm),
          ...tips.map((tip) => Padding(
                padding: const EdgeInsets.only(bottom: AppTheme.spaceSm),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      margin: const EdgeInsets.only(top: 6),
                      decoration: const BoxDecoration(
                        color: AppTheme.blushRose,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const Gap(AppTheme.spaceXs),
                    Expanded(
                      child: Text(
                        tip,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    ).animate().fade(delay: 100.ms, duration: 200.ms);
  }
}

// ============================================================================
// Section 4: Weight Log List
// ============================================================================

class _WeightLogSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Weight Log',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const Gap(AppTheme.spaceSm),
        _WeightLogItem(
          date: 'Mon, Jan 15, 2024',
          weight: '64.5 kg',
          note: 'Feeling great today!',
          time: '8:30 AM',
        ),
        _WeightLogItem(
          date: 'Sun, Jan 14, 2024',
          weight: '63.7 kg',
          note: null,
          time: '7:45 AM',
        ),
        _WeightLogItem(
          date: 'Sat, Jan 13, 2024',
          weight: '64.2 kg',
          note: 'After weekend brunch',
          time: '9:15 AM',
        ),
      ],
    );
  }
}

class _WeightLogItem extends StatelessWidget {
  final String date;
  final String weight;
  final String? note;
  final String time;

  const _WeightLogItem({
    required this.date,
    required this.weight,
    this.note,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showEntryDetailSheet(context),
      onLongPress: () => _showEditSheet(context),
      child: Container(
        margin: const EdgeInsets.only(bottom: AppTheme.spaceSm),
        padding: const EdgeInsets.all(AppTheme.spaceMd),
        decoration: BoxDecoration(
          color: AppTheme.warmWhite,
          borderRadius: BorderRadius.circular(AppTheme.radiusLg),
          boxShadow: const [
            BoxShadow(color: AppTheme.shadow, blurRadius: 24, offset: Offset(0, 8)),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    date,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const Gap(AppTheme.spaceXxs),
                  Text(
                    weight,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  if (note != null) ...[
                    const Gap(AppTheme.spaceXxs),
                    Text(
                      note!,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppTheme.spaceXs,
                vertical: 2,
              ),
              decoration: BoxDecoration(
                color: AppTheme.stoneGrey.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppTheme.radiusSm),
              ),
              child: Text(
                time,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ],
        ),
      ).animate().fade(duration: 200.ms).slideX(
            begin: 0.1,
            end: 0,
            duration: 200.ms,
            curve: Curves.easeOut,
          ),
    );
  }

  void _showEntryDetailSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.transparent,
      builder: (context) => _EntryDetailBottomSheet(date: date, weight: weight),
    );
  }

  void _showEditSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppTheme.transparent,
      builder: (context) => _AddWeightBottomSheet(
        initialWeight: weight.split(' ').first,
        initialDate: date,
      ),
    );
  }
}

// ============================================================================
// Section 5: Add Weight Bottom Sheet
// ============================================================================

class _AddWeightBottomSheet extends StatefulWidget {
  final String? initialWeight;
  final String? initialDate;

  const _AddWeightBottomSheet({
    this.initialWeight,
    this.initialDate,
  });

  @override
  State<_AddWeightBottomSheet> createState() => _AddWeightBottomSheetState();
}

class _AddWeightBottomSheetState extends State<_AddWeightBottomSheet> {
  final _weightController = TextEditingController();
  final _notesController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    if (widget.initialWeight != null) {
      _weightController.text = widget.initialWeight!;
    }
  }

  @override
  void dispose() {
    _weightController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Container(
      margin: const EdgeInsets.only(top: 100),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: const EdgeInsets.all(AppTheme.spaceMd),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppTheme.mistyBorder,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const Gap(AppTheme.spaceMd),
          Text('Log Weight', style: textTheme.titleLarge),
          const Gap(AppTheme.spaceMd),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: TextField(
                  controller: _weightController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    labelText: 'Weight',
                    hintText: '0.0',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.spaceMd,
                      vertical: AppTheme.spaceSm,
                    ),
                  ),
                ),
              ),
              const Gap(AppTheme.spaceSm),
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppTheme.spaceMd,
                    vertical: AppTheme.spaceMd,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.lavenderTint,
                    borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                    border: Border.all(color: AppTheme.mistyBorder),
                  ),
                  child: Text(
                    'kg',
                    style: textTheme.bodyLarge?.copyWith(
                      color: AppTheme.stoneGrey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
          const Gap(AppTheme.spaceMd),
          GestureDetector(
            onTap: () => _selectDate(context),
            child: Container(
              padding: const EdgeInsets.all(AppTheme.spaceMd),
              decoration: BoxDecoration(
                border: Border.all(color: AppTheme.mistyBorder),
                borderRadius: BorderRadius.circular(AppTheme.radiusMd),
              ),
              child: Row(
                children: [
                  Text(
                    'Date',
                    style: textTheme.bodyMedium,
                  ),
                  const Spacer(),
                  Text(
                    _formatDate(_selectedDate),
                    style: textTheme.bodyLarge,
                  ),
                  const Gap(AppTheme.spaceXs),
                  const Icon(
                    Icons.calendar_today,
                    size: 20,
                    color: AppTheme.stoneGrey,
                  ),
                ],
              ),
            ),
          ),
          const Gap(AppTheme.spaceMd),
          TextField(
            controller: _notesController,
            maxLines: 3,
            minLines: 3,
            decoration: InputDecoration(
              labelText: 'Notes (optional)',
              hintText: 'Add notes...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppTheme.radiusMd),
              ),
              contentPadding: const EdgeInsets.all(AppTheme.spaceMd),
            ),
          ),
          const Gap(AppTheme.spaceMd),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: AppTheme.stoneGrey),
                  ),
                ),
              ),
              const Gap(AppTheme.spaceSm),
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Weight entry saved'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.lavenderBloom,
                    foregroundColor: colorScheme.onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppTheme.radiusPill),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text('Save'),
                ),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  String _formatDate(DateTime date) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}

// ============================================================================
// Section 6: Entry Detail Bottom Sheet
// ============================================================================

class _EntryDetailBottomSheet extends StatelessWidget {
  final String date;
  final String weight;

  const _EntryDetailBottomSheet({
    required this.date,
    required this.weight,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Container(
      margin: const EdgeInsets.only(top: 150),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: const EdgeInsets.all(AppTheme.spaceMd),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppTheme.mistyBorder,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const Gap(AppTheme.spaceMd),
          Text('Weight Entry', style: textTheme.titleLarge),
          const Gap(AppTheme.spaceMd),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(date, style: textTheme.titleMedium),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spaceXs,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.lavenderTint,
                  borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                ),
                child: Text(
                  weight,
                  style: textTheme.labelSmall?.copyWith(
                    color: AppTheme.lavenderBloom,
                  ),
                ),
              ),
            ],
          ),
          const Gap(AppTheme.spaceMd),
          Container(
            padding: const EdgeInsets.all(AppTheme.spaceMd),
            decoration: BoxDecoration(
              color: AppTheme.morningMist,
              borderRadius: BorderRadius.circular(AppTheme.radiusMd),
            ),
            child: Text(
              'Feeling great today!',
              style: textTheme.bodyMedium,
            ),
          ),
          const Gap(AppTheme.spaceMd),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _showDeleteConfirmation(context);
                  },
                  child: Text(
                    'Delete',
                    style: TextStyle(color: AppTheme.softCoral),
                  ),
                ),
              ),
              const Gap(AppTheme.spaceSm),
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.lavenderBloom,
                    foregroundColor: colorScheme.onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppTheme.radiusPill),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text('Save Changes'),
                ),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Entry'),
        content: const Text('Are you sure you want to delete this weight entry?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Weight entry deleted'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: Text(
              'Delete',
              style: TextStyle(color: AppTheme.softCoral),
            ),
          ),
        ],
      ),
    );
  }
}