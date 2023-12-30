import 'package:collection/collection.dart';
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
  String get className => name;

  /// Returns the bubble that corresponds to the specified class name.
  static Bubble getByClassName(String? className) => Bubble.values.firstWhereOrNull((bubble) => bubble.className == className) ?? Bubble.formula;

  /// Returns the bubble of an element.
  static Bubble of(dom.Element element) => Bubble.values.firstWhereOrNull((bubble) => element.classes.contains(bubble.className)) ?? Bubble.formula;

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
