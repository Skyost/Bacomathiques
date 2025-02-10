import 'package:bacomathiques/utils/utils.dart';
import 'package:bacomathiques/widgets/app_bar/actions/action_menu.dart';
import 'package:flutter/material.dart';

/// Action menu that allows to launch the privacy policy url.
class PrivacyPolicyActionMenu extends ActionMenu {
  /// Creates a new "Privacy policy" action menu instance.
  const PrivacyPolicyActionMenu()
      : super(
          icon: Icons.remove_red_eye,
          label: 'Politique de confidentialité',
        );

  @override
  void onTap(BuildContext context) => openUrl('https://gmr.skyost.eu/Skyost/Bacomathiques/app/politique-de-confidentialite.md');
}
