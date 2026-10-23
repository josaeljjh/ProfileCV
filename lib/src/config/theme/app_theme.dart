import 'package:flutter/material.dart';

import '../resources/colors.dart';
import '../tools/const.dart';

/// Semantic colors that every screen reads instead of hardcoding a light-only
/// shade from [colors.dart] (e.g. `black`/`white`/`athensGray`). Each one has
/// a light and a dark value, both drawn from the existing palette, so
/// `ThemeMode.system` keeps the same brand colors while staying legible on
/// either background.
class AppSemanticColors extends ThemeExtension<AppSemanticColors> {
  const AppSemanticColors({
    required this.surface,
    required this.surfaceVariant,
    required this.border,
    required this.divider,
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.iconMuted,
    required this.iconStrong,
  });

  /// Card/container background (e.g. portfolio cards).
  final Color surface;

  /// Chip/tag background (e.g. skill chips).
  final Color surfaceVariant;

  /// Hairline border around cards.
  final Color border;

  /// Divider lines between list sections.
  final Color divider;

  /// Headings and primary body text.
  final Color textPrimary;

  /// Subtitles (e.g. job title, location).
  final Color textSecondary;

  /// Least prominent text (e.g. the objective paragraph, date ranges).
  final Color textTertiary;

  /// Decorative/affordance icons (chevrons, tags, timeline dots).
  final Color iconMuted;

  /// Icons that act as the main visual of a card (e.g. portfolio icons).
  final Color iconStrong;

  static const light = AppSemanticColors(
    surface: white,
    surfaceVariant: athensGray,
    border: athensGray,
    divider: athensGray,
    textPrimary: black,
    textSecondary: slateGray,
    textTertiary: gray400,
    iconMuted: slateGray,
    iconStrong: carbon500,
  );

  static const dark = AppSemanticColors(
    surface: carbon700,
    surfaceVariant: carbon600,
    border: carbon600,
    divider: carbon600,
    textPrimary: white,
    textSecondary: ghost,
    textTertiary: cadetBlue,
    iconMuted: cadetBlue,
    iconStrong: ghost,
  );

  @override
  AppSemanticColors copyWith({
    Color? surface,
    Color? surfaceVariant,
    Color? border,
    Color? divider,
    Color? textPrimary,
    Color? textSecondary,
    Color? textTertiary,
    Color? iconMuted,
    Color? iconStrong,
  }) {
    return AppSemanticColors(
      surface: surface ?? this.surface,
      surfaceVariant: surfaceVariant ?? this.surfaceVariant,
      border: border ?? this.border,
      divider: divider ?? this.divider,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textTertiary: textTertiary ?? this.textTertiary,
      iconMuted: iconMuted ?? this.iconMuted,
      iconStrong: iconStrong ?? this.iconStrong,
    );
  }

  @override
  AppSemanticColors lerp(ThemeExtension<AppSemanticColors>? other, double t) {
    if (other is! AppSemanticColors) return this;
    return AppSemanticColors(
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceVariant: Color.lerp(surfaceVariant, other.surfaceVariant, t)!,
      border: Color.lerp(border, other.border, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textTertiary: Color.lerp(textTertiary, other.textTertiary, t)!,
      iconMuted: Color.lerp(iconMuted, other.iconMuted, t)!,
      iconStrong: Color.lerp(iconStrong, other.iconStrong, t)!,
    );
  }
}

/// Shorthand so widgets can write `context.colors.textPrimary` instead of
/// `Theme.of(context).extension<AppSemanticColors>()`. Falls back to
/// [AppSemanticColors.light] when the ambient [MaterialApp] wasn't built
/// with [lightTheme]/[darkTheme] (e.g. a widget test with a bare
/// `MaterialApp()`), so screens never crash for lack of the extension.
extension AppSemanticColorsContext on BuildContext {
  AppSemanticColors get colors =>
      Theme.of(this).extension<AppSemanticColors>() ?? AppSemanticColors.light;
}

ThemeData lightTheme() {
  return ThemeData(
    useMaterial3: true,
    fontFamily: gothamFontFamily,
    brightness: Brightness.light,
    scaffoldBackgroundColor: white,
    colorScheme: ColorScheme.fromSeed(
      seedColor: niagara,
      brightness: Brightness.light,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: white,
      foregroundColor: black,
      elevation: 0,
      centerTitle: true,
    ),
    extensions: const [AppSemanticColors.light],
  );
}

ThemeData darkTheme() {
  return ThemeData(
    useMaterial3: true,
    fontFamily: gothamFontFamily,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: carbon800,
    colorScheme: ColorScheme.fromSeed(
      seedColor: niagara,
      brightness: Brightness.dark,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: carbon800,
      foregroundColor: white,
      elevation: 0,
      centerTitle: true,
    ),
    extensions: const [AppSemanticColors.dark],
  );
}
