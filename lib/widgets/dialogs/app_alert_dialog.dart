import 'package:flutter/material.dart';

/// An [AlertDialog], built for escape games.
class AppAlertDialog extends StatelessWidget {
  /// The default content padding.
  static const _defaultContentPadding = EdgeInsets.fromLTRB(24, 20, 24, 24);

  /// The dialog title.
  final String? title;

  /// The text to show when [children.isEmpty] is `true`.
  final String? empty;

  /// The dialog background color.
  final Color? backgroundColor;

  /// The dialog content padding.
  final EdgeInsets contentPadding;

  /// The dialog children.
  final List<Widget> children;

  /// The dialog actions.
  final List<Widget>? actions;

  /// The bottom child.
  final Widget? bottom;

  /// The dialog scroll controller.
  final ScrollController? scrollController;

  /// Creates a new [AppAlertDialog] instance.
  const AppAlertDialog({
    super.key,
    this.title,
    this.empty,
    this.backgroundColor,
    this.contentPadding = _defaultContentPadding,
    required this.children,
    this.actions,
    this.bottom,
    this.scrollController,
  });

  /// Creates a new [AppAlertDialog] instance with only one [child].
  AppAlertDialog.oneChild({
    Key? key,
    String? title,
    Color? backgroundColor,
    EdgeInsets contentPadding = _defaultContentPadding,
    required Widget child,
    List<Widget>? actions,
    Widget? bottom,
    ScrollController? scrollController,
  }) : this(
          key: key,
          title: title,
          backgroundColor: backgroundColor,
          contentPadding: contentPadding,
          children: [child],
          actions: actions,
          bottom: bottom,
          scrollController: scrollController,
        );

  @override
  Widget build(BuildContext context) => AlertDialog(
        titlePadding: EdgeInsets.zero,
        shape: const RoundedRectangleBorder(),
        backgroundColor: backgroundColor,
        contentPadding: children.isEmpty ? contentPadding : EdgeInsets.zero,
        title: title == null
            ? null
            : Container(
                color: Theme.of(context).primaryColorDark,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                child: Text(
                  title!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'FuturaBT',
                    color: Colors.white,
                  ),
                ),
              ),
        content: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: _createChildWidget(context),
        ),
        actions: actions,
      );

  /// Creates the child widget.
  Widget _createChildWidget(BuildContext context) {
    List<Widget> children = [];
    if (this.children.isEmpty && empty != null) {
      children.add(Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Text(
          empty!,
          style: const TextStyle(fontStyle: FontStyle.italic),
          textAlign: TextAlign.center,
        ),
      ));
    }

    children.addAll(this.children);

    if (bottom != null) {
      children.add(Padding(
        padding: const EdgeInsets.only(top: 10),
        child: bottom!,
      ));
    }

    return ListView(
      shrinkWrap: true,
      controller: scrollController,
      padding: contentPadding,
      children: children,
    );
  }
}

/// Allows to create an _OK_ button easily.
class AppAlertDialogOkButton extends StatelessWidget {
  /// Triggered when pressed.
  final VoidCallback? onPressed;

  /// Creates a new [EscapeGameAlertDialogOkButton] instance.
  const AppAlertDialogOkButton({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) => TextButton(
        onPressed: onPressed,
        child: const Text('OK'),
      );
}

/// Allows to create a _Close_ button easily.
class AppAlertDialogCloseButton extends StatelessWidget {
  /// Whether it is a cancel or a close button.
  final bool cancel;

  /// Creates a new [AppDialogCloseButton] instance.
  const AppAlertDialogCloseButton({
    super.key,
    this.cancel = false,
  });

  @override
  Widget build(BuildContext context) => TextButton(
        onPressed: () => Navigator.pop(context),
        child: Text(
          (cancel ? 'Annuler' : 'Fermer').toUpperCase(),
        ),
      );
}
