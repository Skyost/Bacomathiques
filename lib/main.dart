import 'package:bacomathiques/model/app.dart';
import 'package:bacomathiques/model/settings.dart';
import 'package:bacomathiques/widgets/theme/theme.dart';
import 'package:bacomathiques/pages/comments.dart';
import 'package:bacomathiques/pages/home.dart';
import 'package:bacomathiques/pages/html/page.dart';
import 'package:bacomathiques/pages/lessons.dart';
import 'package:bacomathiques/pages/levels.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

/// Hello world !
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (defaultTargetPlatform == TargetPlatform.android || defaultTargetPlatform == TargetPlatform.iOS) {
    await MobileAds.instance.initialize();
  }

  runApp(ProviderScope(child: BacomathiquesApp()));
}

/// The app main class.
class BacomathiquesApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SettingsModel settingsModel = ref.watch(settingsModelProvider);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(systemNavigationBarColor: settingsModel.resolveTheme(context).actionBarColor),
      child: MaterialApp(
        title: App.appName,
        initialRoute: '/',
        theme: AppTheme.light.flutterThemeData,
        darkTheme: AppTheme.dark.flutterThemeData,
        themeMode: settingsModel.themeMode,
        routes: {
          '/': (context) => const HomePage(),
          '/levels': (context) => const LevelsPage(),
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
    );
  }
}
