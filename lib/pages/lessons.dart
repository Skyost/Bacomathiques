import 'package:bacomathiques/model/api/common.dart';
import 'package:bacomathiques/model/api/list.dart';
import 'package:bacomathiques/model/settings.dart';
import 'package:bacomathiques/utils/utils.dart';
import 'package:bacomathiques/widgets/app_bar/app_bar.dart';
import 'package:bacomathiques/widgets/dialogs/message.dart';
import 'package:bacomathiques/widgets/fade_stack_widget.dart';
import 'package:bacomathiques/widgets/level_icon_button.dart';
import 'package:bacomathiques/widgets/request_scaffold.dart';
import 'package:bacomathiques/widgets/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:rate_my_app/rate_my_app.dart';

/// The home screen, where previews are shown.
class LessonsPage extends RequestScaffold<LessonList> {
  /// Creates a new lessons page instance.
  const LessonsPage({
    required super.endpoint,
  });

  @override
  RequestScaffoldState createState() => _LessonsPageState();
}

/// The home screen state.
class _LessonsPageState extends RequestScaffoldState<LessonList, LessonsPage> {
  /// Creates a new home screen state instance.
  _LessonsPageState()
      : super(
          failMessage: 'Impossible de charger la liste des cours et aucune sauvegarde n\'est disponible.',
          failDialogOptions: const FailDialogOptions(show: false),
        );

  @override
  void initState() {
    super.initState();

    RateMyApp rateMyApp = RateMyApp(appStoreIdentifier: '1458503418');
    rateMyApp.init().then((_) {
      if (rateMyApp.shouldOpenDialog) {
        WidgetsBinding.instance.addPostFrameCallback(
          (_) => rateMyApp.showRateDialog(
            context,
            title: 'Noter l\'application',
            message:
                'Si vous aimez cette application, n\'hésitez pas à prendre un peu de votre temps pour la noter !\nCe serait d\'une grande aide et cela ne devrait pas vous prendre plus d\'une minute.',
            rateButton: 'Noter',
            noButton: 'Non merci',
            laterButton: 'Plus tard',
            ignoreNativeDialog: false,
          ),
        );
      }
    });
  }

  @override
  AppBar? createAppBar(BuildContext context) => BacomathiquesAppBar(
        actions: [LevelIconButton()],
      );

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
              child: const Text(
                'Liste des classes',
                style: TextStyle(color: Colors.white),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                loading = true;
                triggerRequest();
              },
              child: const Text(
                'Réessayer',
                style: TextStyle(color: Colors.white),
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
      bool shown = preferences.getBool('preferences.api-warn-v${result.api.version}') ?? false;
      if (shown) {
        return;
      }

      preferences.setBool('preferences.api-warn-v${result.api.version}', true);
      if (mounted) {
        MessageDialog.show(
          context,
          title: 'Mise à jour',
          message: 'Une mise à jour de l\'application est disponible. Vous pouvez dès maintenant aller la télécharger.',
        );
      }
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
          children: [
            for (LessonListItem item in items)
              _PreviewWidget(
                item: item,
                tablet: true,
              ),
          ],
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
class _PreviewWidget extends ConsumerWidget {
  /// The lesson to preview.
  final LessonListItem item;

  /// Whether it's tablet.
  final bool tablet;

  /// Creates a new preview widget instance.
  const _PreviewWidget({
    required this.item,
    this.tablet = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AppTheme theme = ref.watch(settingsModelProvider).resolveTheme(context);
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Card(
        shape: const BeveledRectangleBorder(),
        color: theme.lessonBackgroundColor,
        surfaceTintColor: theme.lessonBackgroundColor,
        elevation: 10,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _PreviewWidgetImage(item: item),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, right: 20, left: 20),
              child: Text(
                'Chapitre ${item.lesson.chapter.romanize()}'.toUpperCase(),
                style: TextStyle(color: theme.lessonChapterColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8, right: 20, left: 20),
              child: Text(
                item.lesson.title,
                style: const TextStyle(
                  fontFamily: 'FuturaBT',
                  fontSize: 26,
                ),
              ),
            ),
            createDescriptionWidget(),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
              child: createActionButton(
                context,
                buttonText: 'Lire le cours',
                backgroundColor: theme.blueButtonColor,
                endpoint: item.lesson.content,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: createActionButton(
                context,
                buttonText: 'Lire le résumé',
                backgroundColor: theme.greenButtonColor,
                endpoint: item.lesson.summary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Creates a new description widget.
  Widget createDescriptionWidget() {
    Widget description = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 21),
      child: HtmlWidget(item.excerpt),
    );

    return tablet ? Expanded(child: description) : description;
  }

  /// Creates the lesson button.
  Widget createActionButton(
    BuildContext context, {
    required String buttonText,
    required Color backgroundColor,
    required APIEndpoint<APIEndpointResultHTML> endpoint,
  }) =>
      TextButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(backgroundColor),
          overlayColor: WidgetStateProperty.all(Colors.white12),
          shape: WidgetStateProperty.all(const RoundedRectangleBorder()),
          padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: 5)),
        ),
        onPressed: () => Navigator.pushNamed(
          context,
          '/html',
          arguments: {
            'endpoint': endpoint,
          },
        ),
        child: Text(
          buttonText,
          style: const TextStyle(fontSize: 14, color: Colors.white),
        ),
      );
}

/// A widget that allows to show the preview image.
class _PreviewWidgetImage extends StatelessWidget {
  /// The lesson to show the preview image.
  final LessonListItem item;

  /// Creates a new preview image widget instance.
  const _PreviewWidgetImage({required this.item});

  @override
  Widget build(BuildContext context) => AboveWidgetFade(
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
            image: API.baseUrl + item.preview,
            placeholder: kTransparentImage,
            height: 100,
            fit: BoxFit.cover,
          ),
        ),
      );
}
