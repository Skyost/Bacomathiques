import 'package:bacomathiques/model/api/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// The level button.
class LevelIconButton extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LevelIconButtonState();
}

/// The level button state.
class _LevelIconButtonState extends State<LevelIconButton> {
  /// The level image URL.
  String? imageUrl;

  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((preferences) async {
      String? imageUrl = preferences.getString('preferences.level-image');
      if (imageUrl != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          setState(() => this.imageUrl = imageUrl);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null) {
      return createButton(createIcon());
    }

    return createButton(SvgPicture.network(
      API.baseUrl + imageUrl!,
      height: 60,
      placeholderBuilder: (_) => createIcon(),
    ));
  }

  /// Creates the button.
  Widget createButton(Widget child) => IconButton(
    icon: child,
    onPressed: () => Navigator.pushNamed(context, '/levels'),
  );

  /// Creates the icon.
  Widget createIcon() => const Icon(
    Icons.view_day,
    color: Colors.white,
  );
}
