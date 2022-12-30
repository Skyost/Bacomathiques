import 'package:bacomathiques/model/settings.dart';
import 'package:bacomathiques/widgets/dialogs/app_alert_dialog.dart';
import 'package:bacomathiques/widgets/dialogs/consent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  Widget build(BuildContext context) => AppAlertDialog.oneChild(
        title: 'Publicités',
        actions: [
          TextButton(
            onPressed: () => changeAdMobSettings(true, preferencesWantsNonPersonalizedAds: false),
            child: Text('Voir des annonces sur mesure'.toUpperCase()),
          ),
          TextButton(
            onPressed: () => changeAdMobSettings(true, preferencesWantsNonPersonalizedAds: true),
            child: Text('Voir des annonces moins pertinentes'.toUpperCase()),
          ),
          TextButton(
            onPressed: () => changeAdMobSettings(false),
            child: Text('Désactiver les publicités'.toUpperCase()),
          ),
          const AppAlertDialogCloseButton(),
        ],
        child: const HtmlWidget(
          '''
          Bacomathiques vous laisse le choix d'activer ou de désactiver les publicités (personnalisées ou non).
          Sachez cependant que cette application et son contenu sont mis à disposition gratuitement pour les utilisateurs et que les publicités
          constituent les seuls revenus de cette application.
          Consultez notre <a href="https://bacomathiqu.es/assets/pdf/politique-de-confidentialite.pdf">politique de confidentialité</a> pour plus d'informations.
          ''',
        ),
      );

  Future<void> changeAdMobSettings(bool adMobEnabled, {bool? preferencesWantsNonPersonalizedAds}) async {
    SettingsModel settingsModel = ref.read(settingsModelProvider);
    settingsModel.adMobEnabled = adMobEnabled;
    await settingsModel.flush();
    if (preferencesWantsNonPersonalizedAds != null) {
      await (await SharedPreferences.getInstance()).setBool(ConsentInformation.preferencesWantsNonPersonalizedAds, preferencesWantsNonPersonalizedAds);
    }
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
              child: Text('Ok'.toUpperCase()),
            ),
          ],
        ),
      );
}
