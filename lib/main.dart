import 'package:admob_flutter/admob_flutter.dart';
import 'package:bacomathiques/app/app.dart';
import 'package:bacomathiques/app/settings.dart';
import 'package:bacomathiques/screen/comments.dart';
import 'package:bacomathiques/screen/home.dart';
import 'package:bacomathiques/screen/html.dart';
import 'package:bacomathiques/screen/lessons.dart';
import 'package:bacomathiques/screen/levels.dart';
import 'package:bacomathiques/utils/server.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:pedantic/pedantic.dart';
import 'package:provider/provider.dart';

/// Hello world !
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Admob.initialize();
  unawaited(FlutterStatusbarcolor.setNavigationBarWhiteForeground(true));
  runApp(BacomathiquesApp());
}

/// The app main class.
class BacomathiquesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          Provider<Server>(
            create: (_) => Server()..start(),
            dispose: (_, server) => server.close(),
            lazy: false,
          ),
          ChangeNotifierProvider<SettingsModel>(
            create: (_) => SettingsModel()..load(context),
            lazy: false,
          ),
        ],
        child: Consumer<SettingsModel>(
          builder: (context, settings, _) => MaterialApp(
            title: App.APP_NAME,
            theme: settings.appTheme.flutterThemeData,
            initialRoute: '/',
            routes: {
              '/': (context) => HomePage(),
              '/levels': (context) => LevelsPage(),
              '/lessons': (context) {
                Map<String, dynamic> arguments = ModalRoute.of(context).settings.arguments;
                return LessonsPage(endpoint: arguments['endpoint']);
              },
              '/html': (context) {
                Map<String, dynamic> arguments = ModalRoute.of(context).settings.arguments;
                return AdMobHTMLPage(endpoint: arguments['endpoint'], anchor: arguments['anchor']);
              },
              '/comments': (context) {
                Map<String, dynamic> arguments = ModalRoute.of(context).settings.arguments;
                return CommentsPage(endpoint: arguments['endpoint']);
              },
            },
          ),
        ),
      );
}
