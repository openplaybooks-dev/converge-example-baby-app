import 'package:flutter/material.dart';

class QuoteCallout extends StatelessWidget {
  final String quote;

  const QuoteCallout({
    super.key,
    required this.quote,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.tertiaryContainer.withValues(alpha: 0.1),
        border: Border(
          left: BorderSide(
            color: colorScheme.tertiary,
            width: 4,
          ),
        ),
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: Text(
        quote,
        style: theme.textTheme.bodyLarge?.copyWith(
          color: colorScheme.onSurface,
          fontStyle: FontStyle.italic,
          height: 24 / 16,
        ),
      ),
    );
  }
}