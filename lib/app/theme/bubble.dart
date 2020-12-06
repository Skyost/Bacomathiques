import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;

/// Contains all possible bubbles.
enum Bubble {
  /// Formula bubble.
  FORMULA,

  /// Tip bubble.
  TIP,

  /// Proof bubble.
  PROOF
}

/// The bubble class extension.
extension BubbleUtils on Bubble {
  /// Returns the bubble CSS class name.
  String get className {
    switch (this) {
      case Bubble.FORMULA:
        return 'formula';
      case Bubble.TIP:
        return 'tip';
      case Bubble.PROOF:
        return 'proof';
    }
    return null;
  }

  /// Returns the bubble that corresponds to the specified class name.
  static Bubble getByClassName(String className) {
    switch(className) {
      case 'formula':
        return Bubble.FORMULA;
      case 'tip':
        return Bubble.TIP;
      case 'proof':
        return Bubble.PROOF;
    }
    return null;
  }

  /// Returns the bubble of an element.
  static Bubble of(dom.Element element) {
    if(element.classes.contains('formula')) {
      return Bubble.FORMULA;
    }
    if(element.classes.contains('tip')) {
      return Bubble.TIP;
    }
    if(element.classes.contains('proof')) {
      return Bubble.PROOF;
    }
    return null;
  }

  /// Returns whether this bubble is expandable.
  bool get isExpandable => this == Bubble.PROOF;

  /// Returns the expand button of this bubble (if it's expandable).
  String get expandButton => this == Bubble.PROOF ? 'Démonstration' : null;
}

/// A bubble theme.
class BubbleTheme {
  /// The background color.
  final Color backgroundColor;

  /// The left border color.
  final Color leftBorderColor;

  /// The link color.
  final Color linkColor;

  /// The link decoration color.
  final Color linkDecorationColor;

  /// Creates a new bubble theme instance.
  const BubbleTheme({
    this.backgroundColor,
    @required this.leftBorderColor,
    this.linkColor,
    this.linkDecorationColor,
  });
}
