import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:localization/localization.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../config/di/service_locator.dart';
import '../config/resources/colors.dart';
import '../config/resources/sizes.dart';
import '../config/routes/navigation_service.dart';
import '../config/routes/routes.dart';
import '../config/tools/const.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);


  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    if (Platform.isAndroid) {
      setOptimalDisplayMode();
    }
    super.initState();
  }

  Future<void> setOptimalDisplayMode() async {
    final List<DisplayMode> supported = await FlutterDisplayMode.supported;
    final DisplayMode active = await FlutterDisplayMode.active;

    final List<DisplayMode> sameResolution = supported
        .where((DisplayMode m) =>
            m.width == active.width && m.height == active.height)
        .toList()
      ..sort((DisplayMode a, DisplayMode b) =>
          b.refreshRate.compareTo(a.refreshRate));

    final DisplayMode mostOptimalMode =
        sameResolution.isNotEmpty ? sameResolution.first : active;

    await FlutterDisplayMode.setPreferredMode(mostOptimalMode);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    LocalJsonLocalization.delegate.directories = ['res/i18n'];
    return MaterialApp(
      title: "ProfileCV",
      debugShowCheckedModeBanner: kDebugMode ? true : false,
      onGenerateRoute: (settings) => Routes().routes(settings),
      navigatorKey: sl.get<NavigationService>().navigatorKey,
      localeResolutionCallback: (locale, supportedLocales) {
        if (locale?.languageCode == 'en') {
          return const Locale('en', 'US');
        }
        return const Locale('es', 'ES');
      },
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        LocalJsonLocalization.delegate,
      ],
      supportedLocales: const [
        Locale('es', 'ES'),
        Locale('en', 'US'),
      ],
      builder: (context, widget) => ResponsiveBreakpoints.builder(
        child: widget!,
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
      ),
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: gothamFontFamily,
        brightness: Brightness.light,
        scaffoldBackgroundColor: white,
        // Material 3's default color scheme (no seed given) tints
        // "white" surfaces - AppBar, Card, NavigationBar - with its
        // default purple surfaceTint, which reads as a pinkish white.
        // This app uses its own flat color tokens (colors.dart), not a
        // Material color scheme, so the tint is switched off and every
        // surface pinned to the real white/niagara tokens.
        colorScheme: ColorScheme.fromSeed(seedColor: niagara, brightness: Brightness.light)
            .copyWith(surface: white, surfaceTint: Colors.transparent),
        appBarTheme: const AppBarTheme(backgroundColor: white, surfaceTintColor: Colors.transparent),
        cardTheme: const CardThemeData(color: white, surfaceTintColor: Colors.transparent),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: white,
          surfaceTintColor: Colors.transparent,
          // No pill behind the selected tab - tapping just shows the
          // ordinary ripple/splash instead of a lingering highlight.
          indicatorColor: Colors.transparent,
          iconTheme: WidgetStateProperty.resolveWith(
            (states) => IconThemeData(
              color: states.contains(WidgetState.selected) ? niagara : carbon500,
              size: states.contains(WidgetState.selected) ? navIconSizeSelected : navIconSize,
            ),
          ),
          labelTextStyle: WidgetStateProperty.resolveWith(
            (states) => TextStyle(
              fontSize: fontSize12,
              color: states.contains(WidgetState.selected) ? niagara : carbon500,
            ),
          ),
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        fontFamily: gothamFontFamily,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: carbon800,
        colorScheme: ColorScheme.fromSeed(seedColor: niagara, brightness: Brightness.dark)
            .copyWith(surface: carbon800, surfaceTint: Colors.transparent),
        appBarTheme: const AppBarTheme(backgroundColor: carbon800, surfaceTintColor: Colors.transparent),
        cardTheme: const CardThemeData(color: carbon700, surfaceTintColor: Colors.transparent),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: carbon800,
          surfaceTintColor: Colors.transparent,
          indicatorColor: Colors.transparent,
          iconTheme: WidgetStateProperty.resolveWith(
            (states) => IconThemeData(
              color: states.contains(WidgetState.selected) ? niagara : gray100,
              size: states.contains(WidgetState.selected) ? navIconSizeSelected : navIconSize,
            ),
          ),
          labelTextStyle: WidgetStateProperty.resolveWith(
            (states) => TextStyle(
              fontSize: fontSize12,
              color: states.contains(WidgetState.selected) ? niagara : gray100,
            ),
          ),
        ),
      ),
      themeMode: ThemeMode.system,
    );
  }
}
