import 'dart:convert';

import 'package:bacomathiques/model/api/common.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

/// /api/v2/:level/:lesson/comments/ endpoint.
class LessonCommentsEndpoint extends APIEndpoint<LessonComments> {
  /// Creates a new lesson comments endpoint instance.
  const LessonCommentsEndpoint({
    required String path,
  }) : super(
          path: path,
        );

  @override
  LessonComments createObjectFromJSON(Map<String, dynamic> parsedJSON) => LessonComments.fromParsedJSON(parsedJSON);
}

/// The lesson comments result object.
class LessonComments extends APIEndpointResult {
  /// The "api" field.
  final APIStatus api;

  /// The "lesson" field.
  final Lesson lesson;

  /// The "postCommentUrl" field.
  final String postCommentUrl;

  /// The "list" field.
  final List<LessonComment> list;

  /// Creates a new lesson comments instance.
  const LessonComments({
    required this.api,
    required this.lesson,
    required this.postCommentUrl,
    required this.list,
  });

  /// Creates a new lesson comments instance from a parsed JSON string.
  factory LessonComments.fromParsedJSON(Map<String, dynamic> parsedJSON) => LessonComments(
        api: APIStatus.fromParsedJSON(parsedJSON['api']),
        lesson: Lesson.fromParsedJSON(parsedJSON['lesson']),
        postCommentUrl: parsedJSON['postCommentUrl'],
        list: parsedJSON['list'].map<LessonComment>((comment) => LessonComment.fromParsedJSON(comment)).toList(),
      );

  /// Posts a comment.
  Future<bool> postComment(String author, String message) async {
    try {
      Map<String, String> body = {
        'level': lesson.level,
        'lesson': lesson.id,
        'author': author,
        'message': message,
        'client': defaultTargetPlatform == TargetPlatform.iOS ? 'iOS' : 'Android',
      };

      http.Response response = await http.post(Uri.parse(postCommentUrl), body: body);
      Map<String, dynamic> data = json.decode(response.body);
      return data['success'] ?? false;
    } catch (ignored) {
      return false;
    }
  }
}

/// A lesson comment.
class LessonComment {
  /// The "id" field.
  final String id;

  /// The "author" field.
  final LessonCommentAuthor author;

  /// The "date" field.
  final int date;

  /// The "message" field.
  final String message;

  /// Creates a new lesson comment instance.
  const LessonComment({
    required this.id,
    required this.author,
    required this.date,
    required this.message,
  });

  /// Creates a new lesson comment instance from a parsed JSON string.
  LessonComment.fromParsedJSON(Map<String, dynamic> parsedJSON)
      : this(
          id: parsedJSON['id'],
          author: LessonCommentAuthor.fromParsedJSON(parsedJSON['author']),
          date: parsedJSON['date'],
          message: parsedJSON['message'],
        );
}

/// A lesson comment author.
class LessonCommentAuthor {
  /// The "name" field.
  final String name;

  /// The "avatar" field.
  final String avatar;

  /// The "isModerator" field.
  final bool isModerator;

  /// Creates a new lesson comment author instance.
  const LessonCommentAuthor({
    required this.name,
    required this.avatar,
    required this.isModerator,
  });

  /// Creates a new lesson comment author instance from a parsed JSON string.
  LessonCommentAuthor.fromParsedJSON(Map<String, dynamic> parsedJSON)
      : this(
          name: parsedJSON['name'],
          avatar: parsedJSON['avatar'],
          isModerator: parsedJSON['isModerator'],
        );
}
