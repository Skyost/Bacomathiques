import 'package:bacomathiques/app/api/common.dart';
import 'package:bacomathiques/app/api/index.dart';
import 'package:bacomathiques/app/settings.dart';
import 'package:bacomathiques/app/theme/theme.dart';
import 'package:bacomathiques/utils/request_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pedantic/pedantic.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// The page that allows the user to show his level.
class LevelsPage extends RequestScaffold<APIIndex> {
  /// Creates a new levels page instance.
  const LevelsPage()
      : super(
          endpoint: const APIIndexEndpoint(),
        );

  @override
  _LevelsPageState createState() => _LevelsPageState();
}

/// The levels page state.
class _LevelsPageState extends RequestScaffoldState<APIIndex, LevelsPage> {
  /// Creates a new levels page state instance.
  _LevelsPageState()
      : super(
          failMessage: 'Impossible de récupérer la liste des classes.',
          failDialogOptions: const FailDialogOptions(show: false),
        );

  @override
  Widget createBody(BuildContext context, APIIndex result) {
    AppTheme theme = ref.watch(settingsModelProvider).resolveTheme(context);
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemBuilder: (context, index) => _LevelWidget(
        color: theme.primaryColor,
        level: result.levels[index],
      ),
      itemCount: result.levels.length,
      semanticChildCount: result.levels.length,
    );
  }

  @override
  Widget createNoObjectBody(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: Text(
                'Impossible de charger la liste des classes et aucune sauvegarde n\'est disponible.\nVeuillez vérifier votre connexion internet et réessayer plus tard.',
                textAlign: TextAlign.center,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                loading = true;
                triggerRequest();
              },
              child: Text(
                'Réessayer'.toUpperCase(),
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      );
}

/// A level widget.
class _LevelWidget extends StatelessWidget {
  /// The color.
  final Color color;

  /// The level.
  final Level level;

  /// Creates a new level widget instance.
  const _LevelWidget({
    required this.color,
    required this.level,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(10),
        child: Material(
          color: color,
          child: InkWell(
            onTap: () async {
              SharedPreferences preferences = await SharedPreferences.getInstance();
              await preferences.setString('preferences.level-image', level.image);
              await preferences.setString('preferences.lesson-list', level.lessons.path);
              unawaited(Navigator.pushNamedAndRemoveUntil(
                context,
                '/lessons',
                (route) => false,
                arguments: {
                  'endpoint': level.lessons,
                },
              ));
            },
            child: buildMainWidget(context),
          ),
        ),
      );

  /// Builds the main widget.
  Widget buildMainWidget(BuildContext context) => Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            SvgPicture.network(
              API.BASE_URL + level.image,
              height: 60,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 15),
              child: Text(
                level.name,
                style: const TextStyle(
                  fontFamily: 'FuturaBT',
                  fontSize: 40,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Text(
              level.description,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
}
