import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

class CycleTrackingScreen extends StatelessWidget {
  const CycleTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surfaceContainerLow,
      appBar: AppBar(
        backgroundColor: colorScheme.primary,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colorScheme.onPrimary),
          onPressed: () => Navigator.of(context).pop(),
          tooltip: 'Back to Browse',
        ),
        title: Text(
          'Cycle Tracking',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: colorScheme.onPrimary,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        children: [
          _buildCurrentCycleCard(context),
          const SizedBox(height: 24),
          _buildCycleHistorySection(context),
          const SizedBox(height: 100),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showLogCycleBottomSheet(context),
        backgroundColor: colorScheme.primary,
        child: Icon(Icons.add, color: colorScheme.onPrimary),
      ),
    );
  }

  Widget _buildCurrentCycleCard(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Container(
      padding: const EdgeInsets.all(AppTheme.spaceMd),
      decoration: BoxDecoration(
        color: AppTheme.morningMist,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        boxShadow: const [
          BoxShadow(
              color: AppTheme.shadow, blurRadius: 24, offset: Offset(0, 8)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.spaceSm,
              vertical: AppTheme.spaceXxs + 2,
            ),
            decoration: BoxDecoration(
              color: colorScheme.primary,
              borderRadius: BorderRadius.circular(AppTheme.radiusPill),
            ),
            child: Text(
              'Day 14',
              style: textTheme.labelLarge?.copyWith(color: colorScheme.onPrimary),
            ),
          ),
          const SizedBox(height: AppTheme.spaceXs),
          Text(
            '14',
            style: textTheme.displayLarge,
          ),
          Text(
            'days since last period',
            style: textTheme.bodyMedium?.copyWith(color: AppTheme.stoneGrey),
          ),
          const SizedBox(height: AppTheme.spaceSm),
          Row(
            children: [
              Icon(Icons.calendar_today,
                  size: 16, color: AppTheme.lavenderBloom),
              const SizedBox(width: AppTheme.spaceXs),
              Text(
                'Next period expected: May 28, 2026',
                style: textTheme.bodySmall?.copyWith(color: AppTheme.stoneGrey),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spaceSm),
          GestureDetector(
            onTap: () => _showFertileWindowSheet(context),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppTheme.spaceSm,
                vertical: AppTheme.spaceXs,
              ),
              decoration: BoxDecoration(
                color: AppTheme.blushRose.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(AppTheme.radiusSm),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.egg_alt, size: 16, color: AppTheme.blushRose),
                  const SizedBox(width: AppTheme.spaceXs),
                  Text(
                    'Fertile window: May 19 - May 23',
                    style: textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppTheme.deepGraphite,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppTheme.spaceMd),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppTheme.radiusPill),
            child: SizedBox(
              height: 8,
              child: LinearProgressIndicator(
                value: 0.5,
                backgroundColor: AppTheme.mistyBorder,
                valueColor:
                    const AlwaysStoppedAnimation(AppTheme.lavenderBloom),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCycleHistorySection(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Cycle History',
          style: textTheme.headlineMedium,
        ),
        const SizedBox(height: AppTheme.spaceSm),
        _buildHistoryItem(
          context,
          'Apr 1 - Apr 28, 2026',
          '28 days',
          1.0,
          'Regular cycle this month',
          false,
        ),
        _buildHistoryItem(
          context,
          'Mar 4 - Mar 31, 2026',
          '27 days',
          0.96,
          'Shorter than usual',
          false,
        ),
        _buildHistoryItem(
          context,
          'Feb 5 - Mar 4, 2026',
          '27 days',
          0.96,
          'Had stress this month',
          true,
        ),
      ],
    );
  }

  Widget _buildHistoryItem(
    BuildContext context,
    String dateRange,
    String length,
    double progress,
    String note,
    bool isIrregular,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return GestureDetector(
      onTap: () => _showEntryDetailSheet(context),
      child: Container(
        margin: const EdgeInsets.only(bottom: AppTheme.spaceSm),
        padding: const EdgeInsets.all(AppTheme.spaceMd),
        decoration: BoxDecoration(
          color: AppTheme.morningMist,
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
          boxShadow: const [
            BoxShadow(
                color: AppTheme.shadow, blurRadius: 24, offset: Offset(0, 8)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(dateRange, style: textTheme.titleMedium),
                Row(
                  children: [
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
                        length,
                        style: textTheme.labelSmall?.copyWith(
                          color: colorScheme.primary,
                        ),
                      ),
                    ),
                    if (isIrregular) ...[
                      const SizedBox(width: AppTheme.spaceXs),
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: AppTheme.blushRose,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spaceXs),
            ClipRRect(
              borderRadius: BorderRadius.circular(AppTheme.radiusPill),
              child: SizedBox(
                height: 6,
                child: LinearProgressIndicator(
                  value: progress,
                  backgroundColor: AppTheme.mistyBorder,
                  valueColor:
                      const AlwaysStoppedAnimation(AppTheme.lavenderBloom),
                ),
              ),
            ),
            const SizedBox(height: AppTheme.spaceXs),
            Text(note, style: textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }

  void _showLogCycleBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppTheme.transparent,
      builder: (context) => _LogCycleBottomSheet(),
    );
  }

  void _showFertileWindowSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.transparent,
      builder: (context) => _FertileWindowBottomSheet(),
    );
  }

  void _showEntryDetailSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.transparent,
      builder: (context) => _EntryDetailBottomSheet(),
    );
  }
}

class _LogCycleBottomSheet extends StatefulWidget {
  @override
  State<_LogCycleBottomSheet> createState() => _LogCycleBottomSheetState();
}

class _LogCycleBottomSheetState extends State<_LogCycleBottomSheet> {
  final _selectedDate = DateTime(2026, 5, 15);
  final _cycleLengthController = TextEditingController(text: '28');
  final _notesController = TextEditingController();
  bool _isIrregular = false;

  @override
  void dispose() {
    _cycleLengthController.dispose();
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
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: const EdgeInsets.all(AppTheme.spaceMd),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: colorScheme.outline,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: AppTheme.spaceMd),
          Text('Log Cycle', style: textTheme.titleLarge),
          const SizedBox(height: AppTheme.spaceMd),
          TextField(
            controller: _cycleLengthController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Period Started',
              hintText: '2026-05-15',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppTheme.radiusMd),
              ),
            ),
          ),
          const SizedBox(height: AppTheme.spaceMd),
          TextField(
            controller: _cycleLengthController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Cycle Length (days)',
              hintText: '28',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppTheme.radiusMd),
              ),
            ),
          ),
          const SizedBox(height: AppTheme.spaceMd),
          TextField(
            controller: _notesController,
            maxLines: 3,
            decoration: InputDecoration(
              labelText: 'Notes',
              hintText: 'Add notes...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppTheme.radiusMd),
              ),
            ),
          ),
          const SizedBox(height: AppTheme.spaceMd),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Irregular cycle', style: textTheme.bodyLarge),
              Switch(
                value: _isIrregular,
                onChanged: (v) => setState(() => _isIrregular = v),
                activeTrackColor: colorScheme.primary,
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spaceMd),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
              ),
              const SizedBox(width: AppTheme.spaceSm),
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.primary,
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
}

class _FertileWindowBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Container(
      margin: const EdgeInsets.only(top: 200),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: const EdgeInsets.all(AppTheme.spaceLg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: colorScheme.outline,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: AppTheme.spaceMd),
          Row(
            children: [
              Icon(Icons.egg_alt, color: AppTheme.blushRose),
              const SizedBox(width: AppTheme.spaceXs),
              Text('Ovulation Prediction', style: textTheme.titleLarge),
            ],
          ),
          const SizedBox(height: AppTheme.spaceMd),
          Text(
            'May 21, 2026',
            style: textTheme.displayMedium
                ?.copyWith(color: AppTheme.lavenderBloom),
          ),
          const SizedBox(height: AppTheme.spaceSm),
          Text(
            'Based on your cycle history, ovulation is expected around May 21. Your fertile window is May 19 - May 23.',
            textAlign: TextAlign.center,
            style: textTheme.bodyMedium,
          ),
          const SizedBox(height: AppTheme.spaceSm),
          Text(
            'Track your cycles consistently for more accurate predictions',
            style: textTheme.bodySmall?.copyWith(fontStyle: FontStyle.italic),
          ),
          const SizedBox(height: AppTheme.spaceMd),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

class _EntryDetailBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Container(
      margin: const EdgeInsets.only(top: 150),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: const EdgeInsets.all(AppTheme.spaceMd),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: colorScheme.outline,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: AppTheme.spaceMd),
          Text('Cycle Entry', style: textTheme.titleLarge),
          const SizedBox(height: AppTheme.spaceMd),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Apr 1 - Apr 28, 2026', style: textTheme.titleMedium),
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
                  '28 days',
                  style: textTheme.labelSmall?.copyWith(
                    color: colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spaceMd),
          TextField(
            maxLines: 3,
            decoration: InputDecoration(
              labelText: 'Notes',
              hintText: 'Add notes...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppTheme.radiusMd),
              ),
            ),
          ),
          const SizedBox(height: AppTheme.spaceMd),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Irregular cycle', style: textTheme.bodyLarge),
              Switch(
                value: false,
                onChanged: (v) {},
                activeTrackColor: AppTheme.lavenderBloom,
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spaceMd),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Delete',
                    style: TextStyle(color: AppTheme.softCoral),
                  ),
                ),
              ),
              const SizedBox(width: AppTheme.spaceSm),
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.primary,
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
}
