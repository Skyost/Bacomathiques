import 'package:bacomathiques/model/api/common.dart';
import 'package:bacomathiques/model/api/content.dart';
import 'package:bacomathiques/model/settings.dart';
import 'package:bacomathiques/pages/html/html_widget.dart';
import 'package:bacomathiques/utils/utils.dart';
import 'package:bacomathiques/widgets/app_bar/actions/save_pdf.dart';
import 'package:bacomathiques/widgets/app_bar/app_bar.dart';
import 'package:bacomathiques/widgets/centered_circular_progress_indicator.dart';
import 'package:bacomathiques/widgets/request_scaffold.dart';
import 'package:bacomathiques/widgets/theme/bubble.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;
import 'package:share_plus/share_plus.dart';

/// A screen that is able to display some HTML content.
class HTMLPage extends RequestScaffold<APIEndpointResultHTML> {
  /// The current anchor.
  final String? anchor;

  /// Creates a new HTML screen instance.
  const HTMLPage({
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

              await Share.share(
                'Lisez le cours intitulé « ${result!.lesson.title} » en téléchargeant l\'application Bacomathiques !\n$storePage',
                subject: 'Bacomathiques - ${result!.lesson.title}',
                sharePositionOrigin: sharePositionOrigin,
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
                Navigator.pushNamed(context, '/comments', arguments: {
                  'endpoint': result!.lesson.comments,
                });
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
  void onSuccess(APIEndpointResultHTML result) {
    dom.Document document = parser.parse(result.html);
    formatTitles(document);
    formatImages(document, mounted ? context : null);
    removeBottomMarginOfLastElements(document);
    formatBubbles(document);
    formatTables(document);

    if (mounted) {
      setState(() => parsedHtml = document.outerHtml);
    }
  }

  /// Formats the titles specified by the tag name.
  void formatTitles(dom.Document document) {
    List<dom.Element> titles = document.getElementsByTagName('h2, h3');
    int h2Index = 0;
    int h3Index = 0;
    for (dom.Element title in titles) {
      switch (title.localName) {
        case 'h2':
          h3Index = 0;
          String prefix = '${(++h2Index).romanize()} – ';
          if (!title.innerHtml.startsWith(prefix)) {
            title.innerHtml = '$prefix${title.innerHtml}';
          }
          break;
        case 'h3':
          String prefix = '${++h3Index}. ';
          if (!title.innerHtml.startsWith(prefix)) {
            title.innerHtml = '$prefix${title.innerHtml}';
          }
          break;
        default:
          continue;
      }
    }

    List<dom.Element> linksInside = document.querySelectorAll('h2 > a, h3 > a, h4 > a');
    for (dom.Element linkInside in linksInside) {
      linkInside.remove();
    }
  }

  /// Center the images.
  void formatImages(dom.Document document, BuildContext? context) {
    Brightness? brightness = context == null ? null : ref.read(settingsModelProvider).resolveTheme(context).brightness;
    List<dom.Element> images = document.getElementsByTagName('img');
    for (dom.Element image in images) {
      if (brightness == Brightness.dark && image.attributes['data-src-dark'] != null) {
        image.attributes['src'] = image.attributes['data-src-dark']!;
      }

      dom.Element div = document.createElement('center');
      div.attributes['style'] = 'margin-bottom: 0.75em';
      div.innerHtml = image.outerHtml;
      image.replaceWith(div);
    }
  }

  /// Formats the bubbles.
  void formatBubbles(dom.Document document) {
    for (Bubble bubble in Bubble.values) {
      List<dom.Element> bubbles = document.getElementsByClassName(bubble.className);
      for (dom.Element element in bubbles) {
        List<dom.Element> children = element.children;
        if (children.isEmpty) {
          continue;
        }

        List<dom.Element> links = element.getElementsByTagName('a');
        for (dom.Element link in links) {
          link.attributes[kAttributeParentBubble] = bubble.className;
        }

        List<dom.Element> headings = element.getElementsByTagName('h4');
        for (dom.Element heading in headings) {
          heading.attributes[kAttributeParentBubble] = bubble.className;
        }

        removeBottomMarginOfLastElements(element);

        List<dom.Element> lists = element.querySelectorAll('ol, ul');
        dom.Element? lastDirectList = lists.lastWhereOrNull((element) => element.parent?.classes.contains(bubble.className) ?? false);
        if (lastDirectList != null && children.last == lastDirectList) {
          removeBottomMarginOfLastElements(lastDirectList);
        }
      }
    }
  }

  /// Formats the tables.
  void formatTables(dom.Document document) {
    List<dom.Element> tables = document.getElementsByTagName('table');
    for (dom.Element table in tables) {
      //table.attributes['border'] = '1';
      table.attributes['cellspacing'] = '0';
    }
  }

  /// Removes the last element of the given node.
  void removeBottomMarginOfLastElements(dynamic node) {
    if (!node.hasChildNodes()) {
      return;
    }

    dom.Element lastChild = node.children.last;
    if (!lastChild.classes.contains('mb-0')) {
      lastChild.classes.add('mb-0');
    }
  }
}
