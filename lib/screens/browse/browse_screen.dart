import 'package:flutter/material.dart';
import '_widgets/LinkCard.dart';

class BrowseScreen extends StatelessWidget {
  const BrowseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Browse'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 24),
            LinkCard(
              icon: Icons.calendar_month_outlined,
              iconContainerColor: colorScheme.primary.withValues(alpha: 0.15),
              iconColor: colorScheme.primary,
              title: 'Cycle Tracking',
              description: 'Log cycles, view ovulation predictions',
              route: '/cycle-tracking',
            ),
            const SizedBox(height: 24),
            LinkCard(
              icon: Icons.monitor_weight_outlined,
              iconContainerColor: colorScheme.tertiary.withValues(alpha: 0.2),
              iconColor: colorScheme.tertiary,
              title: 'Weight & Nutrition',
              description: 'Log weight, view progress, nutrition tips',
              route: '/weight-nutrition',
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}