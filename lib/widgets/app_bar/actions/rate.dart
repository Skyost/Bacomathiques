import 'package:bacomathiques/utils/utils.dart';
import 'package:bacomathiques/widgets/app_bar/actions/action_menu.dart';
import 'package:flutter/material.dart';

/// Action menu that allows to launch the app store page url.
class RateActionMenu extends ActionMenu {
  /// Creates a new "Rate the app" action menu.
  const RateActionMenu()
      : super(
          icon: Icons.thumb_up,
          label: 'Noter l\'application',
        );

  @override
  void onTap(BuildContext context) => openUrl(storePage);
}
