import 'package:go_router/go_router.dart';

import '../screens/home/home_screen.dart';
import '../screens/browse/browse_screen.dart';
import '../screens/library/library_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/cycle_tracking/cycle_tracking_screen.dart';
import '../screens/weight_nutrition/weight_nutrition_screen.dart';
import '../screens/pregnancy_progress/pregnancy_progress_screen.dart';
import '../screens/mindfulness/mindfulness_screen.dart';
import '../screens/health_log/health_log_screen.dart';
import '../screens/mood_wellness/mood_wellness_screen.dart';
import '../screens/education/education_screen.dart';
import '../screens/article_reader/article_reader_screen.dart';
import '../screens/settings/settings_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/browse',
      builder: (context, state) => const BrowseScreen(),
    ),
    GoRoute(
      path: '/library',
      builder: (context, state) => const LibraryScreen(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: '/cycle-tracking',
      builder: (context, state) => const CycleTrackingScreen(),
    ),
    GoRoute(
      path: '/weight-nutrition',
      builder: (context, state) => const WeightNutritionScreen(),
    ),
    GoRoute(
      path: '/pregnancy-progress',
      builder: (context, state) => const PregnancyProgressScreen(),
    ),
    GoRoute(
      path: '/mindfulness',
      builder: (context, state) => const MindfulnessScreen(),
    ),
    GoRoute(
      path: '/health-log',
      builder: (context, state) => const HealthLogScreen(),
    ),
    GoRoute(
      path: '/mood-wellness',
      builder: (context, state) => const MoodWellnessScreen(),
    ),
    GoRoute(
      path: '/education',
      builder: (context, state) => const EducationScreen(),
    ),
    GoRoute(
      path: '/article-reader/:id',
      builder: (context, state) {
        final id = state.pathParameters['id'] ?? '';
        return ArticleReaderScreen(articleId: id);
      },
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
  ],
);
