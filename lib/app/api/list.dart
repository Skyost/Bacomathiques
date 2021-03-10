import 'package:bacomathiques/app/api/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// /api/v2/:level/ endpoint.
class LessonListEndpoint extends APIEndpoint<LessonList> {
  /// Creates a new lesson list endpoint instance.
  const LessonListEndpoint({
    required String path,
  }) : super(path: path);

  @override
  LessonList createObjectFromJSON(Map<String, dynamic> parsedJSON) => LessonList.fromParsedJSON(parsedJSON);
}

/// The lesson list result object.
class LessonList extends APIEndpointResult {
  /// The "api" field.
  final APIStatus api;

  /// The "list" field.
  final List<LessonListItem> list;

  /// Creates a new lesson list instance.
  const LessonList({
    required this.api,
    required this.list,
  });

  /// Creates a new lesson list instance from a parsed JSON instance.
  LessonList.fromParsedJSON(Map<String, dynamic> parsedJSON)
      : this(
          api: APIStatus.fromParsedJSON(parsedJSON['api']),
          list: parsedJSON['list'].map<LessonListItem>((item) => LessonListItem.fromParsedJSON(item)).toList(),
        );

  @override
  List<Widget> createActions(BuildContext context) => [_LevelIconButton()];
}

/// A lesson list item.
class LessonListItem {
  /// The "lesson" field.
  final Lesson lesson;

  /// The "preview" field.
  final String preview;

  /// The "caption" field.
  final String caption;

  /// The "excerpt" field.
  final String excerpt;

  /// Creates a new lesson list item instance.
  const LessonListItem({
    required this.lesson,
    required this.preview,
    required this.caption,
    required this.excerpt,
  });

  /// Creates a new lesson list item instance from a parsed JSON string.
  LessonListItem.fromParsedJSON(Map<String, dynamic> parsedJSON)
      : this(
          lesson: Lesson.fromParsedJSON(parsedJSON['lesson']),
          preview: parsedJSON['preview'],
          caption: parsedJSON['caption'],
          excerpt: parsedJSON['excerpt'],
        );
}

/// The level button.
class _LevelIconButton extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LevelIconButtonState();
}

/// The level button state.
class _LevelIconButtonState extends State<_LevelIconButton> {
  /// The level image URL.
  String? imageUrl;

  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((preferences) async {
      String? imageUrl = preferences.getString('preferences.level-image');
      if (imageUrl != null) {
        WidgetsBinding.instance?.addPostFrameCallback((_) {
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
      API.BASE_URL + imageUrl!,
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
