import 'package:bacomathiques/app/api/list.dart';
import 'package:bacomathiques/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// The home page that allows to redirect to the corresponding route according to user preferences.
class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

/// The home page state.
class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    SharedPreferences.getInstance().then((preferences) {
      String lessonListEndpoint = preferences.getString('preferences.lesson-list');
      if (lessonListEndpoint == null) {
        WidgetsBinding.instance.addPostFrameCallback((_) => Navigator.pushReplacementNamed(context, '/levels'));
        return;
      }

      WidgetsBinding.instance.addPostFrameCallback(
        (_) => Navigator.pushReplacementNamed(
          context,
          '/lessons',
          arguments: {
            'endpoint': LessonListEndpoint(
              path: lessonListEndpoint,
            ),
          },
        ),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: CenteredCircularProgressIndicator(),
      );
}
