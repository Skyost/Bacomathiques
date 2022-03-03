import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;

/// Contains all possible bubbles.
enum Bubble {
  /// Formula bubble.
  formula,

  /// Tip bubble.
  tip,

  /// Proof bubble.
  proof,
}

/// The bubble class extension.
extension BubbleUtils on Bubble {
  /// Returns the bubble CSS class name.
  String get className {
    switch (this) {
      case Bubble.formula:
        return 'formula';
      case Bubble.tip:
        return 'tip';
      case Bubble.proof:
        return 'proof';
    }
  }

  /// Returns the bubble that corresponds to the specified class name.
  static Bubble getByClassName(String? className) {
    switch(className) {
      case 'tip':
        return Bubble.tip;
      case 'proof':
        return Bubble.proof;
      default:
        return Bubble.formula;
    }
  }

  /// Returns the bubble of an element.
  static Bubble of(dom.Element element) {
    if(element.classes.contains('tip')) {
      return Bubble.tip;
    }
    if(element.classes.contains('proof')) {
      return Bubble.proof;
    }
    return Bubble.formula;
  }

  /// Returns whether this bubble is expandable.
  bool get isExpandable => this == Bubble.proof;

  /// Returns the expand button of this bubble (if it's expandable).
  String? get expandButton => this == Bubble.proof ? 'Démonstration' : null;

  /// Returns the bubble label.
  String get bubbleLabel {
    switch (this) {
      case Bubble.formula:
        return 'À connaître 💡';
      case Bubble.tip:
        return 'À lire 👀';
      case Bubble.proof:
        return 'Démonstration 🧠';
    }
  }
}

/// A bubble theme.
class BubbleTheme {
  /// The background color.
  final Color? backgroundColor;

  /// The left border color.
  final Color leftBorderColor;

  /// The link color.
  final Color linkColor;

  /// The link decoration color.
  final Color linkDecorationColor;

  /// Creates a new bubble theme instance.
  const BubbleTheme({
    this.backgroundColor,
    required this.leftBorderColor,
    required this.linkColor,
    required this.linkDecorationColor,
  });
}
