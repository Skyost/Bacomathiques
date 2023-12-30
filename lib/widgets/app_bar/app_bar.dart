import 'package:bacomathiques/model/app.dart';
import 'package:bacomathiques/widgets/app_bar/actions/about.dart';
import 'package:bacomathiques/widgets/app_bar/actions/action_menu.dart';
import 'package:bacomathiques/widgets/app_bar/actions/ads.dart';
import 'package:bacomathiques/widgets/app_bar/actions/bug.dart';
import 'package:bacomathiques/widgets/app_bar/actions/rate.dart';
import 'package:bacomathiques/widgets/app_bar/actions/theme.dart';
import 'package:bacomathiques/widgets/dialogs/about.dart';
import 'package:flutter/material.dart' hide AboutDialog;
import 'package:flutter_svg/flutter_svg.dart';

/// An app bar for endpoints.
class BacomathiquesAppBar extends AppBar {
  /// Default actions to be shown.
  static const List<ActionMenu> defaultActions = [
    ThemeActionMenu(),
    AdsActionMenu(),
    RateActionMenu(),
    BugActionMenu(),
    AboutActionMenu(),
  ];

  /// Creates a new app bar for endpoints.
  BacomathiquesAppBar({
    super.key,
    super.title = const _DefaultTitleWidget(),
    List<Widget> actions = const [],
    List<ActionMenu> actionMenus = const [],
  }) : super(
          actions: [
            ...actions,
            if (actionMenus.isNotEmpty)
              PopupActionMenu(
                actionMenus: actionMenus,
              ),
          ],
        );
}

/// The app bar default title widget.
class _DefaultTitleWidget extends StatelessWidget {
  /// Creates a new title widget instance.
  const _DefaultTitleWidget();

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => AboutDialog.show(context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              'assets/images/logo.svg',
              width: 30,
              semanticsLabel: 'Logo',
            ),
            const Padding(
              padding: EdgeInsets.only(top: 5, left: 7),
              child: Text(
                App.appName,
                style: TextStyle(
                  fontFamily: 'Handlee',
                  fontSize: 26,
                ),
              ),
            ),
          ],
        ),
      );
}
