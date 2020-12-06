
import 'package:bacomathiques/app/api/common.dart';
import 'package:bacomathiques/app/api/content.dart';
import 'package:bacomathiques/app/theme/theme.dart';
import 'package:bacomathiques/utils/utils.dart';
import 'package:flutter/material.dart';

/// Dialog that displays E3C.
class E3CDialog extends StatelessWidget {
  /// The lesson E3C.
  final List<LessonE3C> e3c;

  /// Creates a new annals dialog.
  const E3CDialog({
    @required this.e3c,
  });

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.resolveTheme();
    return AlertDialog(
      title: _createTitleWidget(),
      contentPadding: EdgeInsets.zero,
      content: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          padding: const EdgeInsets.all(24).copyWith(top: 20),
          children: [
            ...e3c.map((e3c) => _createE3CWidget(context, theme, e3c)),
            const Text(
              'Sujets disponibles en libre accès sur le site du ministère. Merci à CCBac pour la liste des corrigés.',
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 12,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
      actions: [
        FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Fermer'.toUpperCase()),
        ),
      ],
    );
  }

  /// Creates a new title widget.
  Widget _createTitleWidget() => const Text('E3C en rapport avec ce cours');

  /// Creates a new E3C widget.
  Widget _createE3CWidget(BuildContext context, AppTheme theme, LessonE3C e3c) => Container(
    padding: const EdgeInsets.all(15),
    margin: const EdgeInsets.only(bottom: 25),
    color: Colors.blue[50],
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            e3c.id,
            style: TextStyle(
              fontFamily: 'FuturaBT',
              color: Colors.blue[700],
              fontSize: 20,
            ),
          ),
        ),
        FlatButton(
          color: theme.greenButtonColor,
          child: const Text(
            'Voir le sujet',
            style: TextStyle(fontSize: 14, color: Colors.white),
          ),
          onPressed: () => openURL(API.BASE_URL + e3c.subject),
          padding: const EdgeInsets.symmetric(horizontal: 5),
          minWidth: double.infinity,
        ),
        for (String correction in e3c.corrections) _createCorrectionButton(correction, theme)
      ],
    ),
  );

  /// Creates the correction button.
  Widget _createCorrectionButton(String correction, AppTheme theme) {
    List<String> parts = correction.split('://')[1].split('/')[0].split('www.');
    return FlatButton(
      color: theme.blueButtonColor,
      child: Text(
        'Voir la correction sur\n' + (parts.length >= 2 ? parts[1] : parts[0]),
        style: const TextStyle(fontSize: 14, color: Colors.white),
        textAlign: TextAlign.center,
      ),
      onPressed: () => openURL(correction),
      padding: const EdgeInsets.all(5),
      minWidth: double.infinity,
    );
  }

  /// Shows the dialog.
  static void show(BuildContext context, {@required List<LessonE3C> e3c}) => showDialog(
    context: context,
    builder: (context) => E3CDialog(e3c: e3c),
  );
}