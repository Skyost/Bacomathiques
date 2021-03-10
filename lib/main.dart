import 'dart:io';

import 'package:bacomathiques/app/app.dart';
import 'package:bacomathiques/app/settings.dart';
import 'package:bacomathiques/app/theme/theme.dart';
import 'package:bacomathiques/credentials.dart';
import 'package:bacomathiques/pages/comments.dart';
import 'package:bacomathiques/pages/home.dart';
import 'package:bacomathiques/pages/html/page.dart';
import 'package:bacomathiques/pages/lessons.dart';
import 'package:bacomathiques/pages/levels.dart';
import 'package:catcher/catcher.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

/// Hello world !
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();

  Widget main = BacomathiquesApp();
  if(kDebugMode) {
    runApp(main);
  }
  else {
    CatcherOptions releaseConfig = CatcherOptions(
      SilentReportMode(),
      [
        DiscordHandler(
          Credentials.DISCORD_WEBHOOK,
          printLogs: true,
          enableDeviceParameters: false,
          enableApplicationParameters: true,
          enableCustomParameters: true,
          enableStackTrace: true,
        ),
      ],
      customParameters: {'platform': Platform.isAndroid ? 'Android' : 'iOS'},
    );

    Catcher(rootWidget: main, releaseConfig: releaseConfig);
  }
}

/// The app main class.
class BacomathiquesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ChangeNotifierProvider<SettingsModel>(
            create: (_) => SettingsModel()..load(context),
            lazy: false,
          ),
        ],
        child: Consumer<SettingsModel>(
          builder: (context, settings, _) => AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light.copyWith(systemNavigationBarColor: settings.resolveTheme(context).actionBarColor),
            child: MaterialApp(
              title: App.APP_NAME,
              initialRoute: '/',
              navigatorKey: Catcher.navigatorKey,
              theme: AppTheme.LIGHT.flutterThemeData,
              darkTheme: AppTheme.DARK.flutterThemeData,
              themeMode: settings.themeMode,
              routes: {
                '/': (context) => HomePage(),
                '/levels': (context) => LevelsPage(),
                '/lessons': (context) {
                  Map<String, dynamic> arguments = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
                  return LessonsPage(endpoint: arguments['endpoint']);
                },
                '/html': (context) {
                  Map<String, dynamic> arguments = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
                  return AdMobHTMLPage(endpoint: arguments['endpoint'], anchor: arguments['anchor']);
                },
                '/comments': (context) {
                  Map<String, dynamic> arguments = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
                  return CommentsPage(endpoint: arguments['endpoint']);
                },
              },
            ),
          ),
        ),
      );
}
