import 'package:bacomathiques/widgets/app_bar/actions/action_menu.dart';
import 'package:bacomathiques/widgets/dialogs/ads.dart';
import 'package:flutter/material.dart';

/// Action menu that allows to show the ads dialog.
class AdsActionMenu extends ActionMenu {
  /// Creates a new "Ads" action menu instance.
  const AdsActionMenu()
      : super(
          icon: Icons.subtitles,
          label: 'Publicités…',
        );

  @override
  void onTap(BuildContext context) => AdsDialog.show(context);
}
