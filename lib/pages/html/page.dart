import 'package:admob_flutter/admob_flutter.dart';
import 'package:bacomathiques/app/api/common.dart';
import 'package:bacomathiques/app/api/content.dart';
import 'package:bacomathiques/app/dialogs/consent.dart';
import 'package:bacomathiques/app/settings.dart';
import 'package:bacomathiques/app/theme/bubble.dart';
import 'package:bacomathiques/pages/html/html_widget.dart';
import 'package:bacomathiques/utils/request_scaffold.dart';
import 'package:bacomathiques/utils/utils.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;
import 'package:provider/provider.dart';

/// Allows to display the html content with an AdMob banner.
class AdMobHTMLPage extends StatefulWidget {
  /// The endpoint to display.
  final APIEndpoint<APIEndpointResultHTML> endpoint;

  /// The current anchor.
  final String? anchor;

  /// Creates a new AdMob HTML screen instance.
  const AdMobHTMLPage({
    required this.endpoint,
    this.anchor,
  });

  @override
  State<StatefulWidget> createState() => _AdMobHTMLPageState();
}

/// The AdMob HTML page state.
class _AdMobHTMLPageState extends State<AdMobHTMLPage> {
  /// The consent information.
  ConsentInformation? consentInformation;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) => askConsent());
  }

  /// Asks for the user consent.
  Future<void> askConsent() async {
    ConsentInformation consentInformation = await ConsentInformation.askIfNeeded(
      context: context,
      appMessage: 'Nous souhaitons votre accord pour vous afficher des publicités personnalisées. Sachez que cette application et son contenu sont mis à disposition gratuitement pour les utilisateurs et que les publicités constituent les seuls revenus de cette application.',
      question: 'Pouvons-nous utiliser vos données pour vous afficher des publicités personnalisées ?',
      privacyPolicyMessage: 'Vous pourrez changer votre choix dans le menu déroulant de l\'application. Sachez que des cookies seront stockés sur votre appareil. Consultez notre <a href="https://bacomathiqu.es/pdf/politique-de-confidentialite.pdf">politique de confidentialité</a> pour plus d\'informations.',
      personalizedAdsButton: 'Oui, je souhaite voir des annonces pertinentes'.toUpperCase(),
      nonPersonalizedAdsButton: 'Non, je souhaite voir des annonces moins pertinentes'.toUpperCase(),
    );
    await Admob.requestTrackingAuthorization();
    setState(() => this.consentInformation = consentInformation);
  }

  @override
  Widget build(BuildContext context) {
    Widget htmlPage = _HTMLPage(
      endpoint: widget.endpoint,
      anchor: widget.anchor,
    );

    if (consentInformation == null) {
      return htmlPage;
    }

    SettingsModel settingsModel = Provider.of<SettingsModel>(context);
    AdmobBanner? banner = settingsModel.createAdMobBanner(context, consentInformation!.wantsNonPersonalizedAds);
    if (banner == null) {
      return htmlPage;
    }

    return FutureBuilder<Size>(
      initialData: Size.zero,
      future: settingsModel.calculateAdMobBannerSize(context),
      builder: (context, sizeSnapshot) => Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: sizeSnapshot.hasData ? sizeSnapshot.data!.height : 0),
            child: htmlPage,
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: banner,
          ),
        ],
      ),
    );
  }
}

/// A screen that is able to display some HTML content.
class _HTMLPage extends StatefulWidget {
  /// The endpoint to display.
  final APIEndpoint<APIEndpointResultHTML> endpoint;

  /// The current anchor.
  final String? anchor;

  /// Creates a new HTML screen instance.
  const _HTMLPage({
    required this.endpoint,
    this.anchor,
  });

  @override
  State<StatefulWidget> createState() => endpoint is LessonContentEndpoint ? _LessonContentHTMLPageState(endpoint: endpoint as LessonContentEndpoint) : _HTMLPageState(endpoint: endpoint);
}

/// State of HTML screens.
class _HTMLPageState extends RequestScaffold<_HTMLPage, APIEndpointResultHTML> {
  /// Contains the parsed HTML.
  late String parsedHtml;

  /// Creates a new HTML screen state instance.
  _HTMLPageState({
    required APIEndpoint<APIEndpointResultHTML> endpoint,
  }) : super(
          endpoint: endpoint,
          failMessage: 'Impossible de charger ce contenu et aucune sauvegarde n\'est disponible.',
        );

  @override
  Widget createBody(BuildContext context, APIEndpointResultHTML result) => AppHtmlWidget(
        data: parsedHtml,
        textStyle: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 16),
      );

  @override
  void onSuccess(APIEndpointResultHTML result) {
    String html = result.html;
    html = html.replaceAllMapped(RegExp(r'(\$+)(?:(?!\1)[\s\S])*\1'), (match) => '<math>${_removeTrailingAndLeadingDollars(match.group(0)!)}</math>');

    dom.Document document = parser.parse(html);
    _formatTitles(document);
    _centerImages(document);
    _removeBottomMarginOfLastElements(document);
    _formatBubbles(document);
    _formatLinks(document);
    _formatTables(document);

    String dataAnchor = widget.anchor == null ? '' : 'data-scroll-target="${widget.anchor}"';
    parsedHtml = '<lv $dataAnchor>${document.outerHtml}</lv>';
  }

  /// Formats the titles specified by the tag name.
  void _formatTitles(dom.Document document) {
    List<dom.Element> titles = document.getElementsByTagName('h2, h3');
    int h2Index = 0;
    int h3Index = 0;
    for (dom.Element title in titles) {
      switch (title.localName) {
        case 'h2':
          h3Index = 0;
          title.innerHtml = '${(++h2Index).romanize()} – ${title.innerHtml}';
          break;
        case 'h3':
          title.innerHtml = '${++h3Index}. ${title.innerHtml}';
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
  void _centerImages(dom.Document document) {
    List<dom.Element> images = document.getElementsByTagName('img');
    for (dom.Element image in images) {
      dom.Element div = document.createElement('center');
      div.attributes['style'] = 'margin-bottom: 0.75em';
      div.innerHtml = image.outerHtml;
      image.replaceWith(div);
    }
  }

  /// Formats the bubbles.
  void _formatBubbles(dom.Document document) {
    for (Bubble bubble in Bubble.values) {
      List<dom.Element> bubbles = document.getElementsByClassName(bubble.className);
      for (dom.Element element in bubbles) {
        List<dom.Element> children = element.children;
        if (children.isEmpty) {
          continue;
        }

        _removeBottomMarginOfLastElements(element);

        List<dom.Element> lists = element.querySelectorAll('ol, ul');
        dom.Element? lastDirectList = lists.lastWhereOrNull((element) => element.parent?.classes.contains(bubble.className) ?? false);
        if (lastDirectList != null && children.last == lastDirectList) {
          _removeBottomMarginOfLastElements(lastDirectList);
        }
      }
    }
  }

  /// Formats the links.
  void _formatLinks(dom.Document document) {
    List<dom.Element> links = document.getElementsByTagName('a');
    for (dom.Element link in links) {
      link.attributes['data-current-endpoint'] = endpoint.path;
    }
  }

  /// Formats the tables.
  void _formatTables(dom.Document document) {
    List<dom.Element> tables = document.getElementsByTagName('table');
    for (dom.Element table in tables) {
      //table.attributes['border'] = '1';
      table.attributes['cellspacing'] = '0';
    }
  }

  /// Removes the last element of the given node.
  void _removeBottomMarginOfLastElements(dynamic node) {
    if (!node.hasChildNodes()) {
      return;
    }

    dom.Element lastChild = node.children.last;
    if (!lastChild.classes.contains('mb-0')) {
      lastChild.classes.add('mb-0');
    }
  }

  /// Removes trailing and leading dollars of a string.
  String _removeTrailingAndLeadingDollars(String input) {
    if (input.startsWith('\$')) {
      return _removeTrailingAndLeadingDollars(input.substring(1));
    }
    if (input.endsWith('\$')) {
      return _removeTrailingAndLeadingDollars(input.substring(0, input.length - 1));
    }

    return input;
  }
}

/// Page state for lessons contents.
class _LessonContentHTMLPageState extends _HTMLPageState {
  /// The share button key.
  GlobalKey shareButtonKey = GlobalKey();

  /// Creates a new lesson content HTML page state instance.
  _LessonContentHTMLPageState({
    required LessonContentEndpoint endpoint,
  }) : super(
          endpoint: endpoint,
        );

  @override
  AppBar createAppBar(BuildContext context) => result == null ? super.createAppBar(context) : (result as LessonContent).createAppBar(context, shareButtonKey: shareButtonKey);
}
