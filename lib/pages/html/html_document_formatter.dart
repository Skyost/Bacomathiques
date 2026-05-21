import 'package:bacomathiques/pages/html/html_widget.dart';
import 'package:bacomathiques/utils/utils.dart';
import 'package:bacomathiques/widgets/theme/bubble.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;

/// Formats lesson HTML before it is rendered by [AppHtmlWidget].
class HtmlDocumentFormatter {
  /// The current display brightness.
  final Brightness brightness;

  /// Creates an HTML document formatter.
  const HtmlDocumentFormatter({
    required this.brightness,
  });

  /// Formats raw HTML.
  String format(String html) {
    dom.Document document = parser.parse(html);
    _formatTitles(document);
    _formatImages(document);
    _removeBottomMarginOfLastElements(document);
    _formatBubbles(document);
    _formatTables(document);
    return document.outerHtml;
  }

  void _formatTitles(dom.Document document) {
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
      }
    }

    List<dom.Element> linksInside = document.querySelectorAll('h2 > a, h3 > a, h4 > a');
    for (dom.Element linkInside in linksInside) {
      linkInside.remove();
    }
  }

  void _formatImages(dom.Document document) {
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

  void _formatBubbles(dom.Document document) {
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

        _removeBottomMarginOfLastElements(element);

        List<dom.Element> lists = element.querySelectorAll('ol, ul');
        dom.Element? lastDirectList = lists.lastWhereOrNull((element) => element.parent?.classes.contains(bubble.className) ?? false);
        if (lastDirectList != null && children.last == lastDirectList) {
          _removeBottomMarginOfLastElements(lastDirectList);
        }
      }
    }
  }

  void _formatTables(dom.Document document) {
    List<dom.Element> tables = document.getElementsByTagName('table');
    for (dom.Element table in tables) {
      table.attributes['cellspacing'] = '0';
    }
  }

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
