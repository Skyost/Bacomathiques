import 'package:bacomathiques/firebase_options.dart';
import 'package:bacomathiques/model/app.dart';
import 'package:bacomathiques/model/settings.dart';
import 'package:bacomathiques/navigation/app_routes.dart';
import 'package:bacomathiques/pages/comments.dart';
import 'package:bacomathiques/pages/home.dart';
import 'package:bacomathiques/pages/html/page.dart';
import 'package:bacomathiques/pages/lessons.dart';
import 'package:bacomathiques/pages/levels.dart';
import 'package:bacomathiques/widgets/centered_circular_progress_indicator.dart';
import 'package:bacomathiques/widgets/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syntax_highlight/syntax_highlight.dart';

/// Python syntax highlighting file path.
const String pythonSyntaxHighlightingFilePath = '../../../assets/languages/python';

/// Hello world !
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Highlighter.initialize([pythonSyntaxHighlightingFilePath]);
  if (defaultTargetPlatform == TargetPlatform.android || defaultTargetPlatform == TargetPlatform.iOS) {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }

  runApp(const ProviderScope(child: BacomathiquesApp()));
}

/// The app main class.
class BacomathiquesApp extends ConsumerWidget {
  const BacomathiquesApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<AppSettings> settings = ref.watch(settingsModelProvider);
    AppSettings settingsModel = switch (settings) {
      AsyncData(:final value) => value,
      _ => const AppSettings(),
    };
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(systemNavigationBarColor: settingsModel.resolveTheme(context).actionBarColor),
      child: MaterialApp(
        title: App.appName,
        initialRoute: '/',
        theme: AppTheme.light.flutterThemeData,
        darkTheme: AppTheme.dark.flutterThemeData,
        themeMode: settingsModel.themeMode,
        onGenerateRoute: _generateRoute,
        builder: (context, child) => settings.when(
          data: (_) => child ?? const SizedBox.shrink(),
          loading: () => const Scaffold(
            body: CenteredCircularProgressIndicator(message: 'Chargement des préférences…'),
          ),
          error: (error, stackTrace) => const Scaffold(
            body: Center(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  'Impossible de charger les préférences.',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Route<void> _generateRoute(RouteSettings settings) => MaterialPageRoute(
    settings: settings,
    builder: (context) => switch (settings.name) {
      AppRoutes.home => const HomePage(),
      AppRoutes.levels => const LevelsPage(),
      AppRoutes.lessons => switch (settings.arguments) {
        LessonsRouteArguments(:final endpoint) => LessonsPage(endpoint: endpoint),
        _ => const _InvalidRoutePage(),
      },
      AppRoutes.html => switch (settings.arguments) {
        HtmlRouteArguments(:final endpoint, :final anchor) => HTMLPage(endpoint: endpoint, anchor: anchor),
        _ => const _InvalidRoutePage(),
      },
      AppRoutes.comments => switch (settings.arguments) {
        CommentsRouteArguments(:final endpoint) => CommentsPage(endpoint: endpoint),
        _ => const _InvalidRoutePage(),
      },
      _ => const _InvalidRoutePage(),
    },
  );
}

class _InvalidRoutePage extends StatelessWidget {
  const _InvalidRoutePage();

  @override
  Widget build(BuildContext context) => const Scaffold(
    body: Center(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Text(
          'Impossible d\'ouvrir cette page.',
          textAlign: TextAlign.center,
        ),
      ),
    ),
  );
}
