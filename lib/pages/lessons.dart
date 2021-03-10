import 'package:bacomathiques/app/api/common.dart';
import 'package:bacomathiques/app/api/list.dart';
import 'package:bacomathiques/app/dialogs/message.dart';
import 'package:bacomathiques/app/theme/theme.dart';
import 'package:bacomathiques/utils/fade_stack_widget.dart';
import 'package:bacomathiques/utils/request_scaffold.dart';
import 'package:bacomathiques/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// The home screen, where previews are shown.
class LessonsPage extends StatefulWidget {
  /// The endpoint.
  final APIEndpoint<LessonList> endpoint;

  /// Creates a new lessons page instance.
  LessonsPage({
    required this.endpoint,
  });

  @override
  _LessonsPageState createState() => _LessonsPageState(endpoint: endpoint);
}

/// The home screen state.
class _LessonsPageState extends RequestScaffold<LessonsPage, LessonList> {
  /// Creates a new home screen state instance.
  _LessonsPageState({
    required APIEndpoint<LessonList> endpoint,
  }) : super(
          endpoint: endpoint,
          failMessage: 'Impossible de charger la liste des cours et aucune sauvegarde n\'est disponible.',
          failDialogOptions: const FailDialogOptions(show: false),
        );

  @override
  void initState() {
    super.initState();

    RateMyApp rateMyApp = RateMyApp(appStoreIdentifier: '1458503418');
    rateMyApp.init().then((_) {
      if (rateMyApp.shouldOpenDialog) {
        WidgetsBinding.instance?.addPostFrameCallback(
          (_) => rateMyApp.showRateDialog(
            context,
            title: 'Noter l\'application',
            message: 'Si vous aimez cette application, n\'hésitez pas à prendre un peu de votre temps pour la noter !\nCe serait d\'une grande aide et cela ne devrait pas vous prendre plus d\'une minute.',
            rateButton: 'Noter'.toUpperCase(),
            noButton: 'Non merci'.toUpperCase(),
            laterButton: 'Plus tard'.toUpperCase(),
            ignoreNativeDialog: false,
          ),
        );
      }
    });
  }

  @override
  Widget createBody(BuildContext context, LessonList result) => _PreviewsList(items: result.list);

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
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/levels'),
              child: Text(
                'Liste des classes'.toUpperCase(),
                style: const TextStyle(color: Colors.white),
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

  /// Shows a message if the API is outdated.
  @override
  void onSuccess(LessonList result) {
    if (result.api.isUpToDate) {
      return;
    }

    SharedPreferences.getInstance().then((preferences) {
      bool shown = preferences.getBool('preferences.api-warn-v' + result.api.version.toString()) ?? false;
      if (shown) {
        return;
      }

      preferences.setBool('preferences.api-warn-v' + result.api.version.toString(), true);
      WidgetsBinding.instance?.scheduleFrameCallback((duration) {
        MessageDialog.show(context, message: 'Une mise à jour de l\'application est disponible. Vous pouvez dès maintenant aller la télécharger.');
      });
    });
  }
}

/// A widget to show a list of previews.
class _PreviewsList extends StatelessWidget {
  /// The lessons to preview.
  final List<LessonListItem> items;

  /// Creates a new previews list widget instance.
  const _PreviewsList({
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    int columnCount = _getColumnCount(context);
    if (columnCount > 1) {
      int rowCount = (items.length / columnCount).ceil();
      return SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: LayoutGrid(
          gridFit: GridFit.passthrough,
          columnSizes: [
            for (int i = 0; i < columnCount; i++) //
              const FlexibleTrackSize(1),
          ],
          rowSizes: [
            for (int i = 0; i < rowCount; i++) //
              const IntrinsicContentTrackSize(),
          ],
          children: items.map((item) {
            return _PreviewWidget(
              item: item,
              tablet: true,
            );
          }).toList(),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(15),
      semanticChildCount: items.length,
      itemCount: items.length,
      itemBuilder: (context, position) => _PreviewWidget(item: items[position]),
    );
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
class _PreviewWidget extends StatelessWidget {
  /// The lesson to preview.
  final LessonListItem item;

  /// Whether it's tablet.
  final bool tablet;

  /// Creates a new preview widget instance.
  _PreviewWidget({
    required this.item,
    this.tablet = false,
  });

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.resolveTheme();
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Card(
        shape: const BeveledRectangleBorder(),
        color: theme.lessonBackgroundColor,
        elevation: 10,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _createPreviewWidget(),
            _createTitleWidget(theme),
            _createDescriptionWidget(),
            _createLessonButton(context, theme),
            _createSummaryButton(context, theme),
          ],
        ),
      ),
    );
  }

  /// Creates a new preview widget.
  Widget _createPreviewWidget() => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: AboveWidgetFade(
          above: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(color: Colors.black.withAlpha(175)),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              item.caption,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          under: Container(
            width: double.infinity,
            color: Colors.black.withAlpha(30),
            child: FadeInImage.memoryNetwork(
              image: API.BASE_URL + item.preview,
              placeholder: kTransparentImage,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
        ),
      );

  /// Creates a new title widget.
  Widget _createTitleWidget(AppTheme theme) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: Text(
          item.lesson.title,
          style: const TextStyle(
            fontFamily: 'FuturaBT',
            fontSize: 26,
          ),
        ),
      );

  /// Creates a new description widget.
  Widget _createDescriptionWidget() {
    Widget description = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 21),
      child: HtmlWidget(item.excerpt),
    );

    return tablet ? Expanded(child: description) : description;
  }

  /// Creates the lesson button.
  Widget _createLessonButton(BuildContext context, AppTheme theme) => Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(theme.blueButtonColor),
            overlayColor: MaterialStateProperty.all(Colors.white12),
            shape: MaterialStateProperty.all(const RoundedRectangleBorder()),
            padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 5)),
          ),
          onPressed: () => Navigator.pushNamed(
            context,
            '/html',
            arguments: {
              'endpoint': item.lesson.content,
            },
          ),
          child: Text(
            'Lire le cours'.toUpperCase(),
            style: const TextStyle(fontSize: 14, color: Colors.white),
          ),
        ),
      );

  /// Creates the summary button.
  Widget _createSummaryButton(BuildContext context, AppTheme theme) => Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(theme.greenButtonColor),
            overlayColor: MaterialStateProperty.all(Colors.white12),
            shape: MaterialStateProperty.all(const RoundedRectangleBorder()),
            padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 5)),
          ),
          onPressed: () => Navigator.pushNamed(
            context,
            '/html',
            arguments: {
              'endpoint': item.lesson.summary,
            },
          ),
          child: Text(
            'Lire le résumé'.toUpperCase(),
            style: const TextStyle(fontSize: 14, color: Colors.white),
          ),
        ),
      );
}
