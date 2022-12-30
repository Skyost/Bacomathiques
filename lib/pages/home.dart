import 'package:bacomathiques/model/api/list.dart';
import 'package:bacomathiques/utils/utils.dart';
import 'package:bacomathiques/widgets/centered_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// The home page that allows to redirect to the corresponding route according to user preferences.
class HomePage extends StatefulWidget {
  /// Creates a new home page instance.
  const HomePage();

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

/// The home page state.
class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((preferences) {
      String? lessonListEndpoint = preferences.getString('preferences.lesson-list');
      if (lessonListEndpoint == null) {
        WidgetsBinding.instance.addPostFrameCallback((_) => Navigator.pushReplacementNamed(context, '/levels'));
        return;
      }

      WidgetsBinding.instance.addPostFrameCallback(
        (_) => Navigator.pushReplacementNamed(
          context,
          '/lessons',
          arguments: {
            'endpoint': LessonListEndpoint(path: lessonListEndpoint),
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) => const Scaffold(
        body: CenteredCircularProgressIndicator(),
      );
}
