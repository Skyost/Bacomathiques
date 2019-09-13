import 'package:bacomathiques/app/api/common.dart';
import 'package:bacomathiques/app/api/index.dart';
import 'package:bacomathiques/app/app.dart';
import 'package:bacomathiques/util/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// The page that allows the user to show his level.
class LevelsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LevelsPageState(APIIndexEndpoint());
}

/// The levels page state.
class _LevelsPageState extends RequestScaffold<LevelsPage, APIIndex> {
  /// Creates a new levels page state instance.
  _LevelsPageState(
    APIIndexEndpoint endpoint,
  ) : super(
          endpoint: endpoint,
          failMessage: 'Impossible de récupérer la liste des classes.',
          failDialogOptions: FailDialogOptions(
            show: false,
          ),
        );

  @override
  Widget createBody(BuildContext context) => ListView.builder(
        itemBuilder: (context, index) => _LevelWidget(result.levels[index]),
        itemCount: result.levels.length,
        semanticChildCount: result.levels.length,
      );

  @override
  Widget createNoObjectBody(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: Text(
                'Impossible de charger la liste des classes et aucune sauvegarde n\'est disponible.\nVeuillez vérifier votre connexion internet et réessayer plus tard.',
                textAlign: TextAlign.center,
              ),
            ),
            RaisedButton(
              child: Text('Réessayer'.toUpperCase()),
              onPressed: () {
                loading = true;
                triggerRequest();
              },
            ),
          ],
        ),
      );
}

/// A level widget.
class _LevelWidget extends StatelessWidget {
  /// The level.
  final Level _level;

  /// Creates a new level widget instance.
  _LevelWidget(this._level);

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.all(10),
        child: Material(
          color: App.PRIMARY_COLOR,
          child: InkWell(
            hoverColor: Colors.black12,
            highlightColor: Colors.black12,
            focusColor: Colors.black12,
            splashColor: Colors.black12,
            onTap: () {
              SharedPreferences.getInstance().then((preferences) {
                preferences.setString('preferences.lesson-list', _level.lessons.path);
              });
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/lessons',
                (route) => false,
                arguments: {
                  'endpoint': _level.lessons,
                },
              );
            },
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  SvgPicture.network(
                    API.BASE_URL + _level.image,
                    height: 60,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 5,
                      bottom: 5,
                    ),
                    child: Text(
                      _level.name.toUpperCase(),
                      style: TextStyle(
                        fontSize: 30,
                        fontFamily: 'handlee-regular',
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Text(
                    _level.description,
                    style: Theme.of(context).textTheme.body1.copyWith(
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                          color: Colors.white,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
