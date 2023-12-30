import 'package:bacomathiques/model/settings.dart';
import 'package:bacomathiques/utils/utils.dart';
import 'package:bacomathiques/widgets/dialogs/app_alert_dialog.dart';
import 'package:bacomathiques/widgets/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

/// The ads dialog.
class AdsDialog extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AdsDialogState();

  /// Shows the dialog.
  static void show(BuildContext context) => showDialog(
        context: context,
        builder: (context) => AdsDialog(),
      );
}

/// The ads dialog state.
class _AdsDialogState extends ConsumerState<AdsDialog> {
  @override
  Widget build(BuildContext context) {
    AppTheme theme = ref.watch(settingsModelProvider).resolveTheme(context);
    return AppAlertDialog.oneChild(
      title: 'Publicités',
      actions: [
        TextButton(
          onPressed: () => changeAdMobSettings(true),
          child: const Text('Activer les publicités'),
        ),
        TextButton(
          onPressed: () => changeAdMobSettings(false),
          child: const Text('Désactiver les publicités'),
        ),
        const AppAlertDialogCloseButton(),
      ],
      child: HtmlWidget(
        '''
          Bacomathiques vous laisse le choix d'activer ou de désactiver les publicités (personnalisées ou non).
          Sachez cependant que cette application et son contenu sont mis à disposition gratuitement pour les utilisateurs et que les publicités
          constituent les seuls revenus de cette application.
          Consultez notre <a href="https://bacomathiqu.es/assets/pdf/politique-de-confidentialite.pdf">politique de confidentialité</a> pour plus d'informations.
          ''',
        customStylesBuilder: (element) {
          if (element.localName == 'a') {
            return { 'text-decoration-color': (theme.textColor ?? Colors.black).toHex() };
          }
          return null;
        },
      ),
    );
  }

  Future<void> changeAdMobSettings(bool adMobEnabled) async {
    SettingsModel settingsModel = ref.read(settingsModelProvider);
    settingsModel.adMobEnabled = adMobEnabled;
    await settingsModel.flush();
    if (mounted) {
      await showRestartDialog(context);
      if (mounted) {
        Navigator.pop(context);
      }
    }
  }

  /// Shows a restart dialog.
  Future<void> showRestartDialog(BuildContext context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: const SingleChildScrollView(
            child: Text(
              'Choix enregistré ! Il est possible que vous ayez à redémarrer l\'application pour que les changements soient pris en compte.',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Ok'),
            ),
          ],
        ),
      );
}
