import 'package:bacomathiques/app/api/common.dart';
import 'package:flutter/material.dart';

/// /api/v2/:level/summary/ endpoint.
class LessonSummaryEndpoint extends APIEndpoint<LessonSummary> {
  /// Creates a new lesson summary endpoint.
  const LessonSummaryEndpoint({
    @required String path,
  }) : super(
          path: path,
        );

  @override
  LessonSummary createObjectFromJSON(Map<String, dynamic> parsedJSON) => LessonSummary.fromParsedJSON(parsedJSON);
}

/// The lesson summary result object.
class LessonSummary extends APIEndpointResultHTML {
  /// The "api" field.
  final APIStatus api;

  /// The "lesson" field.
  final Lesson lesson;

  /// The "html" field.
  final String html;

  /// Creates a new lesson summary instance.
  LessonSummary({
    @required this.api,
    @required this.lesson,
    @required this.html,
  });

  /// Creates a new lesson summary instance from a parsed JSON string.
  LessonSummary.fromParsedJSON(Map<String, dynamic> parsedJSON)
      : this(
          api: APIStatus.fromParsedJSON(parsedJSON['api']),
          lesson: Lesson.fromParsedJSON(parsedJSON['lesson']),
          html: parsedJSON['html'],
        );

  @override
  AppBar createAppBar(BuildContext context) => AppBar(
        title: Text(lesson.title),
      );
}
