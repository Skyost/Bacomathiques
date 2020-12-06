
import 'package:bacomathiques/utils/utils.dart';
import 'package:flutter/material.dart';

/// The about dialog.
class AboutDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) => AlertDialog(
    title: _createTitleWidget(),
    content: _createContentWidget(),
    actions: [
      Wrap(
        alignment: WrapAlignment.end,
        crossAxisAlignment: WrapCrossAlignment.end,
        children: createActionsWidgets(context),
        direction: Axis.vertical,
      )
    ],
  );

  /// Creates a new title widget.
  Widget _createTitleWidget() => const Text('À propos');

  /// Creates a new content widget.
  Widget _createContentWidget() => const SingleChildScrollView(
    child: Text(
      'Révisez vos maths en toute tranquillité de la Première à la Terminale avec Bacomathiques !\nVous pouvez consulter les licences des contenus, technologies utilisées et autres en cliquant sur le bouton « Plus d\'informations ».\nSinon, n\'hésitez pas à laisser une (bonne) note sur la fiche de l\'application !',
    ),
  );

  /// Creates a new dialog actions widgets.
  List<Widget> createActionsWidgets(BuildContext context) => [
    FlatButton(
      onPressed: () => openURL('https://bacomathiqu.es/a-propos/'),
      child: Text('Plus d\'informations'.toUpperCase()),
      textTheme: ButtonTextTheme.accent,
    ),
    FlatButton(
      onPressed: () => openURL(storePage),
      child: Text('Fiche de l\'application'.toUpperCase()),
      textTheme: ButtonTextTheme.accent,
    ),
    FlatButton(
      onPressed: () => Navigator.pop(context),
      child: Text('Fermer'.toUpperCase()),
      textTheme: ButtonTextTheme.accent,
    ),
  ];

  /// Shows the dialog.
  static void show(BuildContext context) => showDialog(
    context: context,
    builder: (context) => AboutDialog(),
  );
}