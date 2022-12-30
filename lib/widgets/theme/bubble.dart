import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;

/// Contains all possible bubbles.
enum Bubble {
  /// Formula bubble.
  formula,

  /// Proof bubble.
  proof,

  /// Tip bubble.
  tip,

  /// Exercise bubble.
  exercise,

  /// Correction bubble.
  correction,
}

/// The bubble class extension.
extension BubbleUtils on Bubble {
  /// Returns the bubble CSS class name.
  String get className {
    switch (this) {
      case Bubble.formula:
        return 'formula';
      case Bubble.proof:
        return 'proof';
      case Bubble.tip:
        return 'tip';
      case Bubble.exercise:
        return 'exercise';
      case Bubble.correction:
        return 'correction';
    }
  }

  /// Returns the bubble that corresponds to the specified class name.
  static Bubble getByClassName(String? className) {
    switch (className) {
      case 'tip':
        return Bubble.tip;
      case 'proof':
        return Bubble.proof;
      case 'exercise':
        return Bubble.exercise;
      case 'correction':
        return Bubble.correction;
      default:
        return Bubble.formula;
    }
  }

  /// Returns the bubble of an element.
  static Bubble of(dom.Element element) {
    if (element.classes.contains('tip')) {
      return Bubble.tip;
    }
    if (element.classes.contains('proof')) {
      return Bubble.proof;
    }
    if (element.classes.contains('exercise')) {
      return Bubble.exercise;
    }
    if (element.classes.contains('correction')) {
      return Bubble.correction;
    }
    return Bubble.formula;
  }

  /// Returns whether this bubble is expandable.
  bool get isExpandable => this == Bubble.proof || this == Bubble.correction;

  /// Returns the expand button of this bubble (if it's expandable).
  String? get expandButton {
    switch (this) {
      case Bubble.proof:
        return 'Démonstration';
      case Bubble.correction:
        return 'Correction';
      default:
        return null;
    }
  }

  /// Returns the bubble label.
  String get bubbleLabel {
    switch (this) {
      case Bubble.formula:
        return 'À connaître 💡';
      case Bubble.tip:
        return 'À lire 👀';
      case Bubble.proof:
        return 'Démonstration 🧠';
      case Bubble.exercise:
        return 'Exercice ✍';
      case Bubble.correction:
        return 'Correction 💯';
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
