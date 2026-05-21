import 'package:bacomathiques/model/api/common.dart';
import 'package:bacomathiques/model/api/content.dart';
import 'package:bacomathiques/model/settings.dart';
import 'package:bacomathiques/navigation/app_routes.dart';
import 'package:bacomathiques/pages/html/html_document_formatter.dart';
import 'package:bacomathiques/pages/html/html_widget.dart';
import 'package:bacomathiques/utils/utils.dart';
import 'package:bacomathiques/widgets/app_bar/actions/save_pdf.dart';
import 'package:bacomathiques/widgets/app_bar/app_bar.dart';
import 'package:bacomathiques/widgets/centered_circular_progress_indicator.dart';
import 'package:bacomathiques/widgets/request_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

/// A screen that is able to display some HTML content.
class HTMLPage extends RequestScaffold<APIEndpointResultHTML> {
  /// The current anchor.
  final String? anchor;

  /// Creates a new HTML screen instance.
  const HTMLPage({
    super.key,
    required super.endpoint,
    this.anchor,
  });

  @override
  RequestScaffoldState<APIEndpointResultHTML, HTMLPage> createState() => _HTMLPageState();
}

/// State of HTML screens.
class _HTMLPageState extends RequestScaffoldState<APIEndpointResultHTML, HTMLPage> {
  /// Contains the parsed HTML.
  String? parsedHtml;

  /// The share button key.
  late GlobalKey shareButtonKey;

  /// Creates a new HTML screen state instance.
  _HTMLPageState()
      : super(
          failMessage: 'Impossible de charger ce contenu et aucune sauvegarde n\'est disponible.',
        );

  @override
  void initState() {
    super.initState();
    shareButtonKey = GlobalKey();
  }

  @override
  AppBar createAppBar(BuildContext context) => BacomathiquesAppBar(
        title: RichText(
          overflow: TextOverflow.ellipsis,
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Chapitre ${result!.lesson.chapter.romanize()}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: '\n${result!.lesson.title}',
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            key: shareButtonKey,
            icon: const Icon(
              Icons.share,
              color: Colors.white,
            ),
            onPressed: () async {
              Rect? sharePositionOrigin;
              RenderBox? renderBox = shareButtonKey.currentContext?.findRenderObject() as RenderBox?;
              if (renderBox != null) {
                Offset position = renderBox.localToGlobal(Offset.zero);
                sharePositionOrigin = Rect.fromLTWH(position.dx, position.dy, 24, 12);
              }

          await SharePlus.instance.share(
            ShareParams(
              text: 'Lisez le cours intitulé « ${result!.lesson.title} » en téléchargeant l\'application Bacomathiques !\n$storePage',
              subject: 'Bacomathiques - ${result!.lesson.title}',
              sharePositionOrigin: sharePositionOrigin,
            ),
          );
        },
          ),
          if (result is LessonContent)
            IconButton(
              icon: const Icon(
                Icons.message,
                color: Colors.white,
              ),
              onPressed: () {
            Navigator.pushNamed(
              context,
              AppRoutes.comments,
              arguments: CommentsRouteArguments(endpoint: result!.lesson.comments),
            );
          },
        ),
        ],
        actionMenus: [
          if (result is LessonContent)
            SavePdfActionMenu(
              lessonContent: result as LessonContent,
            ),
          ...BacomathiquesAppBar.defaultActions,
        ],
      );

  @override
  Widget createBody(BuildContext context, APIEndpointResultHTML result) {
    if (parsedHtml == null) {
      return const CenteredCircularProgressIndicator(message: 'Analyse…');
    }

    return AppHtmlWidget(
      data: parsedHtml!,
      anchor: widget.anchor,
    );
  }

  @override
  void onSuccess(APIEndpointResultHTML result) async {
    AppSettings settings = await ref.read(settingsModelProvider.future);
    Brightness brightness = mounted ? settings.resolveTheme(context).brightness : Brightness.light;
    String html = HtmlDocumentFormatter(brightness: brightness).format(result.html);

    if (mounted) {
      setState(() => parsedHtml = html);
    }
  }
}
