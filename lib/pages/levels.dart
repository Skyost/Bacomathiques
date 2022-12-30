import 'package:bacomathiques/model/api/common.dart';
import 'package:bacomathiques/model/api/index.dart';
import 'package:bacomathiques/model/settings.dart';
import 'package:bacomathiques/widgets/app_bar/app_bar.dart';
import 'package:bacomathiques/widgets/theme/theme.dart';
import 'package:bacomathiques/widgets/request_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// The page that allows the user to show his level.
class LevelsPage extends RequestScaffold<APIIndex> {
  /// Creates a new levels page instance.
  const LevelsPage()
      : super(
          endpoint: const APIIndexEndpoint(),
        );

  @override
  RequestScaffoldState createState() => _LevelsPageState();
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
  AppBar? createAppBar(BuildContext context) => BacomathiquesAppBar(
        title: const Text('Choix de la classe'),
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
class _LevelWidget extends StatefulWidget {
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
  State<StatefulWidget> createState() => _LevelWidgetState();
}

/// A level widget state.
class _LevelWidgetState extends State<_LevelWidget> {
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(10),
        child: Material(
          color: widget.color,
          child: InkWell(
            onTap: () async {
              SharedPreferences preferences = await SharedPreferences.getInstance();
              await preferences.setString('preferences.level-image', widget.level.image);
              await preferences.setString('preferences.lesson-list', widget.level.lessons.path);
              if (mounted) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/lessons',
                  (route) => false,
                  arguments: {
                    'endpoint': widget.level.lessons,
                  },
                );
              }
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
              API.baseUrl + widget.level.image,
              height: 60,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 15),
              child: Text(
                widget.level.name,
                style: const TextStyle(
                  fontFamily: 'FuturaBT',
                  fontSize: 40,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Text(
              widget.level.description,
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
