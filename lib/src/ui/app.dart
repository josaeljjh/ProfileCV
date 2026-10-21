import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:localization/localization.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../config/di/service_locator.dart';
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
      localizationsDelegates: const [
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
        scaffoldBackgroundColor: Colors.white,
      ),
    );
  }
}
