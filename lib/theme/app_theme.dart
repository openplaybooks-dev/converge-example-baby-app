import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  // Spacing tokens (8pt base)
  static const double spaceXxs = 4;
  static const double spaceXs = 8;
  static const double spaceSm = 12;
  static const double spaceMd = 16;
  static const double spaceLg = 24;
  static const double spaceXl = 32;
  static const double spaceXxl = 48;

  // Corner radius tokens
  static const double radiusSm = 8;
  static const double radiusMd = 12;
  static const double radiusLg = 16;
  static const double radiusPill = 999;

  // Elevation
  static const double elevationLevel0 = 0;
  static const double elevationLevel1 = 1;
  static const double elevationLevel2 = 2;

  // Semantic colors
  static const Color success = Color(0xFF6EE7B7); // Soft Mint - success states, completed items
  static const Color successContainer = Color(0xFF6EE7B7);
  static const Color shadow = Color(0x14000000); // 8% opacity black for card shadows
  static const Color transparent = Color(0x00000000);

  // Cycle tracking semantic colors
  static const Color lavenderBloom = Color(0xFF7C3AED); // Primary brand
  static const Color lavenderTint = Color(0xFFF5F3FF); // Scaffold background
  static const Color blushRose = Color(0xFFF9A8D4); // Secondary accent, fertility
  static const Color softMint = Color(0xFF6EE7B7); // Success states
  static const Color morningMist = Color(0xFFFAFAFA); // Card backgrounds
  static const Color deepGraphite = Color(0xFF1F2937); // Primary text
  static const Color stoneGrey = Color(0xFF6B7280); // Secondary text
  static const Color mistyBorder = Color(0xFFE5E7EB); // Borders, dividers
  static const Color softCoral = Color(0xFFEF4444); // Error states, delete
  static const Color warmWhite = Color(0xFFFFFFFF); // Bottom sheets, FAB
  static const Color deepTwilight = Color(0xFF1E1B2E); // Card backgrounds in dark mode
  static const Color nightSky = Color(0xFF13111C); // Scaffold background in dark mode

  static ThemeData get lightTheme {
    const primary = Color(0xFF7C3AED);
    const onPrimary = Color(0xFFFFFFFF);
    const secondary = Color(0xFFA78BFA);
    const onSecondary = Color(0xFFFFFFFF);
    const tertiary = Color(0xFFF9A8D4);
    const onTertiary = Color(0xFFFFFFFF);
    const error = Color(0xFFEF4444);
    const onError = Color(0xFFFFFFFF);
    const surface = Color(0xFFFFFFFF);
    const onSurface = Color(0xFF1F2937);
    const surfaceContainerLowest = Color(0xFFFFFFFF);
    const surfaceContainerLow = Color(0xFFFAFAFA);
    const scaffoldBackground = Color(0xFFF5F3FF);
    const outline = Color(0xFFE5E7EB);
    const outlineVariant = Color(0xFFE5E7EB);

    final colorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: const Color(0xFFF5F3FF),
      onPrimaryContainer: primary,
      secondary: secondary,
      onSecondary: onSecondary,
      secondaryContainer: const Color(0xFFF5F3FF),
      onSecondaryContainer: secondary,
      tertiary: tertiary,
      onTertiary: onTertiary,
      tertiaryContainer: tertiary.withValues(alpha: 0.2),
      onTertiaryContainer: onSurface,
      error: error,
      onError: onError,
      errorContainer: error.withValues(alpha: 0.1),
      onErrorContainer: error,
      surface: surface,
      onSurface: onSurface,
      surfaceContainerLowest: surfaceContainerLowest,
      surfaceContainerLow: surfaceContainerLow,
      surfaceContainer: const Color(0xFFF5F3FF),
      surfaceContainerHigh: const Color(0xFFF5F3FF),
      onSurfaceVariant: const Color(0xFF6B7280),
      outline: outline,
      outlineVariant: outlineVariant,
      shadow: Colors.black,
      scrim: Colors.black,
      inverseSurface: const Color(0xFF1F2937),
      onInverseSurface: const Color(0xFFF5F3FF),
      inversePrimary: secondary,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: const Color(0xFFF5F3FF),
      fontFamily: 'Nunito',
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          height: 40 / 32,
          letterSpacing: 0,
          color: Color(0xFF1F2937),
        ),
        displayMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          height: 36 / 28,
          color: Color(0xFF1F2937),
        ),
        displaySmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          height: 32 / 24,
          color: Color(0xFF1F2937),
        ),
        headlineLarge: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          height: 32 / 24,
          color: Color(0xFF1F2937),
        ),
        headlineMedium: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          height: 28 / 22,
          color: Color(0xFF1F2937),
        ),
        headlineSmall: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          height: 28 / 20,
          color: Color(0xFF1F2937),
        ),
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          height: 28 / 20,
          color: Color(0xFF1F2937),
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          height: 24 / 16,
          color: Color(0xFF1F2937),
        ),
        titleSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          height: 20 / 14,
          color: Color(0xFF1F2937),
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          height: 24 / 16,
          letterSpacing: 0.15,
          color: Color(0xFF1F2937),
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          height: 20 / 14,
          letterSpacing: 0.15,
          color: Color(0xFF6B7280),
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          height: 16 / 12,
          letterSpacing: 0.4,
          color: Color(0xFF6B7280),
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          height: 20 / 14,
          letterSpacing: 0.1,
          color: Color(0xFF1F2937),
        ),
        labelMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          height: 16 / 12,
          letterSpacing: 0.5,
          color: Color(0xFF1F2937),
        ),
        labelSmall: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          height: 16 / 11,
          letterSpacing: 0.4,
          color: Color(0xFF6B7280),
        ),
      ),
      cardTheme: CardThemeData(
        color: const Color(0xFFFFFFFF),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFFF5F3FF),
        foregroundColor: Color(0xFF1F2937),
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Color(0xFF1F2937),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: const Color(0xFFF5F5F4),
        selectedColor: const Color(0xFF7C3AED).withValues(alpha: 0.15),
        labelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Color(0xFF1F2937),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        side: const BorderSide(color: Color(0xFFE5E7EB)),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: const Color(0xFFFFFFFF),
        indicatorColor: const Color(0xFF7C3AED).withValues(alpha: 0.15),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Color(0xFF7C3AED),
            );
          }
          return const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w400,
            color: Color(0xFF6B7280),
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(
              size: 24,
              color: Color(0xFF7C3AED),
            );
          }
          return const IconThemeData(
            size: 24,
            color: Color(0xFF6B7280),
          );
        }),
      ),
    );
  }

  static ThemeData get darkTheme {
    const primary = Color(0xFF9F67FF);
    const onPrimary = Color(0xFFFFFFFF);
    const secondary = Color(0xFFC4B5FD);
    const onSecondary = Color(0xFFFFFFFF);
    const tertiary = Color(0xFFFBC4E0);
    const onTertiary = Color(0xFF1F2937);
    const error = Color(0xFFF87171);
    const onError = Color(0xFFFFFFFF);
    const surface = Color(0xFF252336);
    const onSurface = Color(0xFFF3F4F6);
    const surfaceContainerLowest = Color(0xFF13111C);
    const surfaceContainerLow = Color(0xFF1E1B2E);
    const scaffoldBackground = Color(0xFF13111C);
    const outline = Color(0xFF2D2B3A);
    const outlineVariant = Color(0xFF2D2B3A);

    final colorScheme = ColorScheme(
      brightness: Brightness.dark,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: const Color(0xFF4C1D95),
      onPrimaryContainer: primary,
      secondary: secondary,
      onSecondary: onSecondary,
      secondaryContainer: const Color(0xFF4C1D95),
      onSecondaryContainer: secondary,
      tertiary: tertiary,
      onTertiary: onTertiary,
      tertiaryContainer: tertiary.withValues(alpha: 0.2),
      onTertiaryContainer: onSurface,
      error: error,
      onError: onError,
      errorContainer: error.withValues(alpha: 0.1),
      onErrorContainer: error,
      surface: surface,
      onSurface: onSurface,
      surfaceContainerLowest: surfaceContainerLowest,
      surfaceContainerLow: surfaceContainerLow,
      surfaceContainer: const Color(0xFF252336),
      surfaceContainerHigh: const Color(0xFF2D2B3A),
      onSurfaceVariant: const Color(0xFF9CA3AF),
      outline: outline,
      outlineVariant: outlineVariant,
      shadow: Colors.black,
      scrim: Colors.black,
      inverseSurface: const Color(0xFFF3F4F6),
      onInverseSurface: const Color(0xFF1F2937),
      inversePrimary: const Color(0xFF7C3AED),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: scaffoldBackground,
      fontFamily: 'Nunito',
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          height: 40 / 32,
          letterSpacing: 0,
          color: onSurface,
        ),
        displayMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          height: 36 / 28,
          color: onSurface,
        ),
        displaySmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          height: 32 / 24,
          color: onSurface,
        ),
        headlineLarge: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          height: 32 / 24,
          color: onSurface,
        ),
        headlineMedium: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          height: 28 / 22,
          color: onSurface,
        ),
        headlineSmall: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          height: 28 / 20,
          color: onSurface,
        ),
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          height: 28 / 20,
          color: onSurface,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          height: 24 / 16,
          color: onSurface,
        ),
        titleSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          height: 20 / 14,
          color: onSurface,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          height: 24 / 16,
          letterSpacing: 0.15,
          color: onSurface,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          height: 20 / 14,
          letterSpacing: 0.15,
          color: const Color(0xFF9CA3AF),
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          height: 16 / 12,
          letterSpacing: 0.4,
          color: const Color(0xFF9CA3AF),
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          height: 20 / 14,
          letterSpacing: 0.1,
          color: onSurface,
        ),
        labelMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          height: 16 / 12,
          letterSpacing: 0.5,
          color: onSurface,
        ),
        labelSmall: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          height: 16 / 11,
          letterSpacing: 0.4,
          color: const Color(0xFF9CA3AF),
        ),
      ),
      cardTheme: CardThemeData(
        color: const Color(0xFF1E1B2E),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: scaffoldBackground,
        foregroundColor: onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: onSurface,
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: const Color(0xFF2D2B3A),
        selectedColor: primary.withValues(alpha: 0.15),
        labelStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: onSurface,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        side: const BorderSide(color: Color(0xFF2D2B3A)),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: const Color(0xFF252336),
        indicatorColor: primary.withValues(alpha: 0.15),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: primary,
            );
          }
          return const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w400,
            color: Color(0xFF9CA3AF),
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return IconThemeData(
              size: 24,
              color: primary,
            );
          }
          return const IconThemeData(
            size: 24,
            color: Color(0xFF9CA3AF),
          );
        }),
      ),
    );
  }
}
