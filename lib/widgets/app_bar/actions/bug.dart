import 'package:bacomathiques/utils/utils.dart';
import 'package:bacomathiques/widgets/app_bar/actions/action_menu.dart';
import 'package:flutter/material.dart';

/// Action menu that allows to launch the bug report url.
class BugActionMenu extends ActionMenu {
  /// Creates a new "Report a bug" action menu instance.
  const BugActionMenu()
      : super(
          icon: Icons.sms_failed,
          label: 'Signaler un bug',
        );

  @override
  void onTap(BuildContext context) => openUrl('https://github.com/Skyost/Bacomathiques/issues/new?title=[Application]%20Rapport%20de%20bug');
}
