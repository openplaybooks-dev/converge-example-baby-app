import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surfaceContainer,
      appBar: AppBar(
        title: const Text('Library'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 24),
            _LinkCard(
              icon: Icons.favorite_outline,
              iconContainerColor: const Color(0xFF7C3AED).withValues(alpha: 0.15),
              iconColor: const Color(0xFF7C3AED),
              title: 'Health Log',
              description: 'Track symptoms, doctor visits, reminders',
              route: '/health-log',
            ),
            const SizedBox(height: 24),
            _LinkCard(
              icon: Icons.mood_outlined,
              iconContainerColor: const Color(0xFFF9A8D4).withValues(alpha: 0.20),
              iconColor: const Color(0xFFF9A8D4),
              title: 'Mood & Wellness',
              description: 'Log moods, track energy levels',
              route: '/mood-wellness',
            ),
            const SizedBox(height: 24),
            _LinkCard(
              icon: Icons.school_outlined,
              iconContainerColor: const Color(0xFF6EE7B7).withValues(alpha: 0.20),
              iconColor: const Color(0xFF6EE7B7),
              title: 'Education',
              description: 'Browse articles and trusted health info',
              route: '/education',
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(
          top: BorderSide(color: colorScheme.outline),
        ),
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavDestination(context, Icons.home_outlined, 'Home', false),
            _buildNavDestination(context, Icons.search, 'Browse', false),
            _buildNavDestination(context, Icons.bookmark, 'Library', true),
            _buildNavDestination(context, Icons.person_outline, 'Profile', false),
          ],
        ),
      ),
    );
  }

  Widget _buildNavDestination(
    BuildContext context,
    IconData icon,
    String label,
    bool isActive,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      decoration: isActive
          ? BoxDecoration(
              color: colorScheme.primary.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(999),
            )
          : null,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 24,
            color: isActive ? colorScheme.primary : colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
              color: isActive ? colorScheme.primary : colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _LinkCard extends StatefulWidget {
  const _LinkCard({
    required this.icon,
    required this.iconContainerColor,
    required this.iconColor,
    required this.title,
    required this.description,
    required this.route,
  });

  final IconData icon;
  final Color iconContainerColor;
  final Color iconColor;
  final String title;
  final String description;
  final String route;

  @override
  State<_LinkCard> createState() => _LinkCardState();
}

class _LinkCardState extends State<_LinkCard> {
  double _scale = 1.0;

  void _onTapDown(TapDownDetails details) {
    setState(() => _scale = 0.98);
  }

  void _onTapUp(TapUpDetails details) {
    setState(() => _scale = 1.0);
    context.push(widget.route);
  }

  void _onTapCancel() {
    setState(() => _scale = 1.0);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        child: Semantics(
          label: '${widget.title}, double tap to open ${widget.title.toLowerCase()} screen',
          button: true,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: widget.iconContainerColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      widget.icon,
                      color: widget.iconColor,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: textTheme.titleMedium,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.description,
                          style: textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: theme.colorScheme.onSurfaceVariant,
                    size: 24,
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