import 'dart:ui';

/// Resolves the app's current locale the same way `app.dart`'s
/// `localeResolutionCallback` does (English if the device is 'en',
/// Spanish otherwise), but by reading the platform dispatcher directly
/// instead of `Localizations.localeOf(context)`.
///
/// This exists specifically so it's safe to call from a `BlocProvider`'s
/// `create:` callback: `Localizations.localeOf(context)` subscribes to
/// InheritedWidget updates, which throws ("Tried to listen to an
/// InheritedWidget in a life-cycle that will never be called again")
/// when called from a one-time lifecycle like `create`. Reading the
/// platform locale directly has no such dependency.
Locale resolveAppLocale() {
  final deviceLocale = PlatformDispatcher.instance.locale;
  if (deviceLocale.languageCode == 'en') {
    return const Locale('en', 'US');
  }
  return const Locale('es', 'ES');
}
