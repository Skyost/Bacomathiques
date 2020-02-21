import 'package:bacomathiques/app/api/common.dart';
import 'package:bacomathiques/app/api/list.dart';
import 'package:bacomathiques/app/app.dart';
import 'package:bacomathiques/app/dialogs.dart';
import 'package:bacomathiques/app/settings.dart';
import 'package:bacomathiques/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
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
          return _PreviewWidget(
            item: item,
            tablet: true,
          );
        }).toList(),
        semanticChildCount: _items.length,
      );
    }

    return ListView.builder(
      semanticChildCount: _items.length,
      itemCount: _items.length,
      itemBuilder: (context, position) => _PreviewWidget(item: _items[position]),
    );
  }

  /// Returns the size coefficient.
  double _getCoefficient(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    if (height < 600) {
      return 0.4;
    }

    if (height < 800) {
      return 0.5;
    }

    if (height < 1000) {
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
  final LessonListItem item;

  /// Whether it's tablet.
  final bool tablet;

  /// Creates a new preview widget instance.
  _PreviewWidget({
    this.item,
    this.tablet = false,
  });

  @override
  State<StatefulWidget> createState() => _PreviewWidgetState();
}

/// The state of preview widgets.
class _PreviewWidgetState extends State<_PreviewWidget> {
  /// Whether this state is currently showing a caption.
  bool showCaption;

  /// Creates a new preview widget state instance.
  _PreviewWidgetState() : showCaption = false;

  @override
  Widget build(BuildContext context) => Consumer<SettingsModel>(
        builder: (context, settings, _) => Padding(
          padding: const EdgeInsets.all(10),
          child: Card(
            color: settings.appTheme.themeData.lessonBackgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(settings.appTheme.themeData.cardBorderRadius),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _createTitleWidget(settings.appTheme),
                _createPreviewWidget(),
                _createDescriptionWidget(),
                _createActionsWidget(settings.appTheme),
              ],
            ),
          ),
        ),
      );

  /// Toggles the current caption.
  void _toggleCaption() => setState(() {
        showCaption = !showCaption;
      });

  /// Creates a new title widget.
  Widget _createTitleWidget(AppTheme theme) => Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Text(
          widget.item.lesson.title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 26,
            fontFamily: 'handlee-regular',
            color: Colors.white,
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(theme.themeData.cardBorderRadius),
            topRight: Radius.circular(theme.themeData.cardBorderRadius),
          ),
          color: widget.item.lesson.specialty ? theme.themeData.specialityColor : theme.themeData.primaryColor,
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
              ),
            ),
            FadeInImage.memoryNetwork(
              image: API.BASE_URL + widget.item.preview,
              placeholder: kTransparentImage,
              height: 100,
              fit: BoxFit.cover,
            ),
            Positioned.fill(
              child: AnimatedOpacity(
                opacity: showCaption ? 1 : 0,
                duration: const Duration(milliseconds: 200),
                child: Container(
                  alignment: const Alignment(0, 0),
                  decoration: BoxDecoration(color: Colors.black.withAlpha(175)),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    widget.item.caption,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  /// Creates a new description widget.
  Widget _createDescriptionWidget() {
    Widget description = Padding(
      padding: const EdgeInsets.all(12),
      child: Html(
        data: widget.item.excerpt,
        defaultTextStyle: Theme.of(context).textTheme.body1.copyWith(
              fontSize: 14,
            ),
      ),
    );

    return widget.tablet
        ? Expanded(
            child: SingleChildScrollView(
              child: description,
            ),
          )
        : description;
  }

  /// Creates a new preview actions widget.
  Widget _createActionsWidget(AppTheme theme) {
    BoxDecoration decoration = widget.tablet
        ? BoxDecoration(
            border: Border(
              top: BorderSide(
                color: theme.themeData.accentColor.withAlpha(100),
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
              color: theme.themeData.accentColor,
            ),
            label: Text(
              'Lire le résumé'.toUpperCase(),
              style: Theme.of(context).textTheme.button.copyWith(fontSize: 14),
            ),
            onPressed: () => Navigator.pushNamed(
              context,
              '/html',
              arguments: {
                'endpoint': widget.item.lesson.summary,
              },
            ),
            padding: const EdgeInsets.symmetric(horizontal: 5),
          ),
          FlatButton.icon(
            icon: Icon(
              Icons.book,
              color: theme.themeData.accentColor,
            ),
            label: Text(
              'Lire le cours'.toUpperCase(),
              style: Theme.of(context).textTheme.button.copyWith(fontSize: 14),
            ),
            onPressed: () => Navigator.pushNamed(
              context,
              '/html',
              arguments: {
                'endpoint': widget.item.lesson.content,
              },
            ),
            padding: const EdgeInsets.symmetric(horizontal: 5),
          )
        ],
      ),
    );
  }
}
