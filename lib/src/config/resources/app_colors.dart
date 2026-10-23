import 'package:flutter/material.dart';

import 'colors.dart';

/// Resolves the right color token for the current brightness, so widgets
/// don't hardcode a single (light-only) color from colors.dart. Scoped to
/// what Home currently needs; extend with more roles as other screens
/// adopt dark mode too.
class AppColors {
  const AppColors(this.isDark);

  factory AppColors.of(BuildContext context) =>
      AppColors(Theme.of(context).brightness == Brightness.dark);

  final bool isDark;

  /// Page background.
  Color get background => isDark ? carbon800 : white;

  /// Card/chip surface, one step up from [background] so it's still
  /// visibly distinct on a dark page.
  Color get cardSurface => isDark ? carbon700 : white;

  /// Primary text (headings, names).
  Color get textPrimary => isDark ? white : black;

  /// Secondary text (titles, subtitles, company names).
  Color get textSecondary => isDark ? gray100 : slateGray;

  /// Tertiary/muted text (dates, objective paragraph).
  Color get textTertiary => isDark ? gray200 : gray400;

  /// Dividers, card borders.
  Color get divider => isDark ? carbon600 : athensGray;

  /// Muted icons (e.g. a portfolio card's placeholder icon).
  Color get iconMuted => isDark ? gray100 : carbon500;
}
