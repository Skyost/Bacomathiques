import 'package:bacomathiques/app/api/common.dart';
import 'package:bacomathiques/app/api/list.dart';
import 'package:bacomathiques/app/app.dart';
import 'package:bacomathiques/app/dialogs.dart';
import 'package:bacomathiques/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transparent_image/transparent_image.dart';

/// The home screen, where previews are shown.
class LessonsPage extends StatefulWidget {
  /// The endpoint.
  final APIEndpoint<LessonList> _endpoint;

  /// Creates a new lessons page instance.
  LessonsPage(this._endpoint);

  @override
  _LessonsPageState createState() => _LessonsPageState(_endpoint);
}

/// The home screen state.
class _LessonsPageState extends RequestScaffold<LessonsPage, LessonList> {
  /// Creates a new home screen state instance.
  _LessonsPageState(
    APIEndpoint<LessonList> endpoint,
  ) : super(
          endpoint: endpoint,
          failMessage: 'Impossible de charger la liste des cours et aucune sauvegarde n\'est disponible.',
          failDialogOptions: const FailDialogOptions(
            show: false,
          ),
        ) {
    successCallback = showMessageIfOutdated;
  }

  @override
  void initState() {
    RateMyApp rateMyApp = RateMyApp();
    rateMyApp.init().then((_) {
      if (rateMyApp.shouldOpenDialog) {
        WidgetsBinding.instance.addPostFrameCallback((duration) => rateMyApp.showRateDialog(
              context,
              title: 'Noter l\'application',
              message: 'Si vous aimez cette application, n\'hésitez pas à prendre un peu de votre temps pour la noter !\nCe serait d\'une grande aide et cela ne devrait pas vous prendre plus d\'une minute.',
              rateButton: 'Noter'.toUpperCase(),
              noButton: 'Non merci'.toUpperCase(),
              laterButton: 'Plus tard'.toUpperCase(),
            ));
      }
    });

    super.initState();
  }

  @override
  Widget createBody(BuildContext context) => _PreviewsList(result.list);

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
                'Impossible de charger la liste des cours et aucune sauvegarde n\'est disponible.\nVeuillez vérifier votre connexion internet et réessayer plus tard.',
                textAlign: TextAlign.center,
              ),
            ),
            RaisedButton(
              child: Text('Liste des classes'.toUpperCase()),
              onPressed: () => Navigator.pushNamed(context, '/levels'),
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

  /// Shows a message if the API is outdated.
  void showMessageIfOutdated() {
    if (result.api.isUpToDate) {
      return;
    }

    SharedPreferences.getInstance().then((preferences) {
      bool shown = preferences.getBool('preferences.api-warn-v' + result.api.version.toString()) ?? false;
      if (shown) {
        return;
      }

      preferences.setBool('preferences.api-warn-v' + result.api.version.toString(), true);
      WidgetsBinding.instance.scheduleFrameCallback((duration) {
        MessageDialog.show(context, 'Une mise à jour de l\'application est disponible. Vous pouvez dès maintenant aller sur le Store pour la télécharger.');
      });
    });
  }
}

/// A widget to show a list of previews.
class _PreviewsList extends StatelessWidget {
  /// The lessons to preview.
  final List<LessonListItem> _items;

  /// Creates a new previews list widget instance.
  _PreviewsList(this._items);

  @override
  Widget build(BuildContext context) {
    int columnCount = _getColumnCount(context);
    if (columnCount > 1) {
      Size size = MediaQuery.of(context).size;
      return GridView.count(
        crossAxisCount: columnCount,
        childAspectRatio: _getCoefficient(context) * (size.width / size.height),
        children: _items.map((item) {
          return _PreviewWidget(item, true);
        }).toList(),
        semanticChildCount: _items.length,
      );
    }

    return ListView.builder(
      semanticChildCount: _items.length,
      itemCount: _items.length,
      itemBuilder: (context, position) => _PreviewWidget(_items[position]),
    );
  }

  /// Returns the size coefficient.
  double _getCoefficient(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    if(height < 600) {
      return 0.4;
    }

    if(height < 800) {
      return 0.5;
    }

    if(height < 1000) {
      return 0.6;
    }

    return 0.7;
  }

  /// Returns the column count.
  int _getColumnCount(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (width < 600) {
      return 1;
    }

    if (width < 800) {
      return 2;
    }

    return 3;
  }
}

/// A widget which shows a lesson preview.
class _PreviewWidget extends StatefulWidget {
  /// The lesson to preview.
  final LessonListItem _item;

  /// Whether it's tablet.
  final bool _tablet;

  /// Creates a new preview widget instance.
  _PreviewWidget(this._item, [this._tablet = false]);

  @override
  State<StatefulWidget> createState() => _PreviewWidgetState();
}

/// The state of preview widgets.
class _PreviewWidgetState extends State<_PreviewWidget> {
  /// Whether this state is currently showing a caption.
  bool _showCaption;

  /// Creates a new preview widget state instance.
  _PreviewWidgetState() : _showCaption = false;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(10),
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(App.CARD_BORDER_RADIUS),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _createTitleWidget(),
                _createPreviewWidget(),
                _createDescriptionWidget(),
                _createActionsWidget(),
              ],
            )),
      );

  /// Toggles the current caption.
  void _toggleCaption() => setState(() {
        _showCaption = !_showCaption;
      });

  /// Creates a new title widget.
  Widget _createTitleWidget() => Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Text(
          widget._item.lesson.title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 26,
            fontFamily: 'handlee-regular',
            color: Colors.white,
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(App.CARD_BORDER_RADIUS),
            topRight: Radius.circular(App.CARD_BORDER_RADIUS),
          ),
          color: widget._item.lesson.specialty ? App.SPECIALITY_COLOR : App.PRIMARY_COLOR,
        ),
      );

  /// Creates a new preview widget.
  Widget _createPreviewWidget() => GestureDetector(
        onTap: _toggleCaption,
        child: Stack(
          children: [
            Positioned.fill(
                child: Container(
              alignment: const Alignment(0, 0),
              foregroundDecoration: BoxDecoration(
                color: Colors.black.withAlpha(30),
              ),
            )),
            FadeInImage.memoryNetwork(
              image: API.BASE_URL + widget._item.preview,
              placeholder: kTransparentImage,
              height: 100,
              fit: BoxFit.cover,
            ),
            Positioned.fill(
                child: AnimatedOpacity(
              opacity: _showCaption ? 1 : 0,
              duration: const Duration(milliseconds: 200),
              child: Container(
                alignment: const Alignment(0, 0),
                decoration: BoxDecoration(color: Colors.black.withAlpha(175)),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  widget._item.caption,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ))
          ],
        ),
      );

  /// Creates a new description widget.
  Widget _createDescriptionWidget() {
    Widget description = Padding(
      padding: const EdgeInsets.all(12),
      child: Html(
        data: widget._item.excerpt,
        defaultTextStyle: Theme.of(context).textTheme.body1.copyWith(
              fontSize: 14,
            ),
      ),
    );

    return widget._tablet
        ? Expanded(
            child: SingleChildScrollView(
              child: description,
            ),
          )
        : description;
  }

  /// Creates a new preview actions widget.
  Widget _createActionsWidget() {
    BoxDecoration decoration = widget._tablet
        ? BoxDecoration(
            border: Border(
              top: BorderSide(
                color: App.ACCENT_COLOR.withAlpha(100),
              ),
            ),
          )
        : null;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: decoration,
      child: Wrap(
        alignment: WrapAlignment.end,
        children: [
          FlatButton.icon(
            icon: Icon(
              Icons.assignment,
              color: App.ACCENT_COLOR,
            ),
            label: Text(
              'Lire le résumé'.toUpperCase(),
              style: Theme.of(context).textTheme.button.copyWith(fontSize: 14),
            ),
            onPressed: () => Navigator.pushNamed(
              context,
              '/html',
              arguments: {
                'endpoint': widget._item.lesson.summary,
              },
            ),
            padding: const EdgeInsets.symmetric(horizontal: 5),
          ),
          FlatButton.icon(
            icon: Icon(
              Icons.book,
              color: App.ACCENT_COLOR,
            ),
            label: Text(
              'Lire le cours'.toUpperCase(),
              style: Theme.of(context).textTheme.button.copyWith(fontSize: 14),
            ),
            onPressed: () => Navigator.pushNamed(
              context,
              '/html',
              arguments: {
                'endpoint': widget._item.lesson.content,
              },
            ),
            padding: const EdgeInsets.symmetric(horizontal: 5),
          )
        ],
      ),
    );
  }
}
