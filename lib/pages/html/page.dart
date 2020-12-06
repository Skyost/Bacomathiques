import 'package:admob_flutter/admob_flutter.dart';
import 'package:bacomathiques/app/api/common.dart';
import 'package:bacomathiques/app/dialogs/consent.dart';
import 'package:bacomathiques/app/settings.dart';
import 'package:bacomathiques/app/theme/bubble.dart';
import 'package:bacomathiques/pages/html/html_widget.dart';
import 'package:bacomathiques/utils/request_scaffold.dart';
import 'package:bacomathiques/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;
import 'package:provider/provider.dart';

/// Allows to display the html content with an AdMob banner.
class AdMobHTMLPage extends StatefulWidget {
  /// The endpoint to display.
  final APIEndpoint<APIEndpointResultHTML> endpoint;

  /// The current anchor.
  final String anchor;

  /// Creates a new AdMob HTML screen instance.
  const AdMobHTMLPage({
    @required this.endpoint,
    this.anchor,
  });

  @override
  State<StatefulWidget> createState() => _AdMobHTMLPageState();
}

/// The AdMob HTML page state.
class _AdMobHTMLPageState extends State<AdMobHTMLPage> {
  /// The consent information.
  ConsentInformation consentInformation;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => askConsent());
  }

  /// Asks for the user consent.
  Future<void> askConsent() async {
    ConsentInformation consentInformation = await ConsentInformation.askIfNeeded(
      context: context,
      appMessage: 'Nous souhaitons votre accord pour vous afficher des publicités personnalisées. Sachez que cette application et son contenu sont mis à disposition gratuitement pour les utilisateurs et que les publicités constituent les seuls revenus de cette application.',
      question: 'Pouvons-nous utiliser vos données pour vous afficher des publicités personnalisées ?',
      privacyPolicyMessage: 'Vous pourrez changer votre choix dans le menu déroulant de l\'application. Sachez que des cookies seront stockés sur votre appareil. Consultez notre <a href="https://bacomathiqu.es/assets/pdf/politique-de-confidentialite.pdf">politique de confidentialité</a> pour plus d\'informations.',
      personalizedAdsButton: 'Oui, je souhaite voir des annonces pertinentes'.toUpperCase(),
      nonPersonalizedAdsButton: 'Non, je souhaite voir des annonces moins pertinentes'.toUpperCase(),
    );
    await Admob.requestTrackingAuthorization();
    setState(() => this.consentInformation = consentInformation);
  }

  @override
  Widget build(BuildContext context) {
    SettingsModel settingsModel = Provider.of<SettingsModel>(context);
    Widget htmlPage = _HTMLPage(
      endpoint: widget.endpoint,
      anchor: widget.anchor,
    );

    if (consentInformation == null) {
      return htmlPage;
    }

    AdmobBanner banner = settingsModel.createAdMobBanner(context, consentInformation.wantsNonPersonalizedAds);
    if (banner == null) {
      return htmlPage;
    }

    return FutureBuilder<Size>(
      initialData: Size.zero,
      future: settingsModel.calculateAdMobBannerSize(context),
      builder: (context, sizeSnapshot) => Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: sizeSnapshot.data.height),
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
  final String anchor;

  /// Creates a new HTML screen instance.
  const _HTMLPage({
    @required this.endpoint,
    this.anchor,
  });

  @override
  State<StatefulWidget> createState() => HTMLPageState(endpoint: endpoint);
}

/// State of HTML screens.
class HTMLPageState extends RequestScaffold<_HTMLPage, APIEndpointResultHTML> {
  /// Contains the parsed HTML.
  String parsedHtml;

  /// Creates a new HTML screen state instance.
  HTMLPageState({
    @required APIEndpoint<APIEndpointResultHTML> endpoint,
  }) : super(
          endpoint: endpoint,
          failMessage: 'Impossible de charger ce contenu et aucune sauvegarde n\'est disponible.',
        );

  @override
  Widget createBody(BuildContext context) => AppHtmlWidget(
        data: parsedHtml,
        textStyle: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 16),
        imagesDirectoryURL: result.lesson.imagesDirectoryURL,
      );

  @override
  set result(APIEndpointResultHTML result) {
    String html = result.html;
    html = html.replaceAllMapped(RegExp(r'\$(.+?)\$'), (match) => '<math>${match.group(1)}</math>');

    dom.Document document = parser.parse(html);
    _formatTitles(document, 'h2');

    List<dom.Element> sections = document.querySelectorAll('section');
    for (dom.Element section in sections) {
      if (section.parent.localName == 'body') {
        _formatTitles(section, 'h3');
      }
    }

    _removeBottomMarginOfLastElements(document);
    _formatBubbles(document);
    _formatLinks(document);

    String dataAnchor = widget.anchor == null ? '' : 'data-scroll-target="${widget.anchor}"';
    parsedHtml = '<lv $dataAnchor>${document.outerHtml}</lv>';
    super.result = result;
  }

  /// Formats the titles specified by the tag name.
  void _formatTitles(dynamic parent, String tagName) {
    String Function(int, String) formatter = tagName == 'h2' ? (index, input) => '${index.romanize()} – $input' : (index, input) => '$index. $input';
    List<dom.Element> titles = parent.getElementsByTagName('$tagName');
    for (int i = 0; i < titles.length; i++) {
      dom.Element title = titles[i];
      title.innerHtml = formatter(i + 1, title.innerHtml);
      title.id = title.text.urlify();
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
        dom.Element lastDirectList = lists.lastWhere((element) => element.parent.classes.contains(bubble.className), orElse: () => null);
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
      if (link.attributes['data-api-v2-hash'] != null && (link.attributes['data-api-v2-level'] == null || link.attributes['data-api-v2-lesson'] == null)) {
        link.attributes['data-target-lesson-endpoint'] = endpoint.path;
      }
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
}
