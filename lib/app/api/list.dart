import 'package:bacomathiques/app/api/common.dart';
import 'package:flutter/material.dart';

/// /api/v2/:level/ endpoint.
class LessonListEndpoint extends APIEndpoint<LessonList> {
  /// Creates a new lesson list endpoint instance.
  const LessonListEndpoint({
    @required String path,
  }) : super(
          path: path,
        );

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
    @required this.api,
    @required this.list,
  });

  /// Creates a new lesson list instance from a parsed JSON instance.
  LessonList.fromParsedJSON(Map<String, dynamic> parsedJSON)
      : this(
          api: APIStatus.fromParsedJSON(parsedJSON['api']),
          list: parsedJSON['list'].map<LessonListItem>((item) => LessonListItem.fromParsedJSON(item)).toList(),
        );

  @override
  List<Widget> createActions(BuildContext context) => [
        IconButton(
          icon: Icon(
            Icons.view_day,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pushNamed(context, '/levels'),
        ),
      ];
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
    @required this.lesson,
    @required this.preview,
    @required this.caption,
    @required this.excerpt,
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
