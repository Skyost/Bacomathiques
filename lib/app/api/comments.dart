import 'dart:collection';
import 'dart:convert';

import 'package:bacomathiques/app/api/common.dart';
import 'package:bacomathiques/app/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

/// /api/v2/:level/:lesson/comments/ endpoint.
class LessonCommentsEndpoint extends APIEndpoint<LessonComments> {
  /// Creates a new lesson comments endpoint instance.
  const LessonCommentsEndpoint({
    @required String path,
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

  /// The "post" field.
  final LessonCommentsPostData post;

  /// The "list" field.
  final List<LessonComment> list;

  /// The current comments username.
  String _username = 'Anonyme';

  /// Creates a new lesson comments instance.
  LessonComments({
    @required this.api,
    @required this.lesson,
    @required this.post,
    @required this.list,
  }) {
    SharedPreferences.getInstance().then((preferences) {
      String username = preferences.getString('comments.username');
      if (username != null && username.isNotEmpty) {
        _username = username;
      }
    });
  }

  /// Creates a new lesson comments instance from a parsed JSON string.
  LessonComments.fromParsedJSON(Map<String, dynamic> parsedJSON)
      : this(
          api: APIStatus.fromParsedJSON(parsedJSON['api']),
          lesson: Lesson.fromParsedJSON(parsedJSON['lesson']),
          post: LessonCommentsPostData.fromParsedJSON(parsedJSON['post']),
          list: parsedJSON['list'].map<LessonComment>((comment) => LessonComment.fromParsedJSON(comment)).toList(),
        );

  @override
  AppBar createAppBar(BuildContext context) => AppBar(
        title: Text('Commentaires sur ' + lesson.title),
        actions: [
          IconButton(
            icon: Icon(
              Icons.person,
              color: Colors.white,
            ),
            onPressed: () => UserDialog.show(context, this),
          ),
          IconButton(
            icon: Icon(
              Icons.create,
              color: Colors.white,
            ),
            onPressed: () => WriteCommentDialog.show(context, this),
          ),
        ],
      );

  /// Posts a comment.
  Future<bool> postComment(List<LessonCommentsPostDataFieldValue> fields) async {
    try {
      Map<String, String> body = HashMap();
      for (LessonCommentsPostDataFieldValue field in fields) {
        body[field.postKey] = field.value;
      }

      http.Response response = await http.post(post.url, body: body);
      Map<String, dynamic> data = json.decode(response.body);
      return data['success'] ?? false;
    } catch (ignored) {
      return false;
    }
  }

  /// Returns the username.
  String get username => _username;

  /// Sets the username.
  set username(String username) {
    _username = username;
    SharedPreferences.getInstance().then((preferences) {
      preferences.setString('comments.username', username);
    });
  }
}

/// A lesson comments post data.
class LessonCommentsPostData {
  /// The "url" field.
  final String url;

  /// The "fields" field.
  final List<LessonCommentsPostDataField> fields;

  /// Creates a new lesson comments post data instance.
  const LessonCommentsPostData({
    @required this.url,
    @required this.fields,
  });

  /// Creates a new lesson comments post data instance from a parsed JSON string.
  LessonCommentsPostData.fromParsedJSON(Map<String, dynamic> parsedJSON)
      : this(
          url: parsedJSON['url'],
          fields: parsedJSON['fields'].map<LessonCommentsPostDataField>((field) => LessonCommentsPostDataField.fromParsedJSON(field)).toList(),
        );
}

/// A lesson comments post data field.
class LessonCommentsPostDataField {
  /// The "name" field.
  final String name;

  /// The "type" field.
  final String type;

  /// Creates a new lesson comments post data field instance.
  const LessonCommentsPostDataField({
    @required this.name,
    @required this.type,
  });

  /// Creates a new lesson comments post data field instance from a JSON string.
  LessonCommentsPostDataField.fromParsedJSON(Map<String, dynamic> parsedJSON)
      : this(
          name: parsedJSON['name'],
          type: parsedJSON['type'],
        );

  /// Returns the HTTP post key.
  String get postKey => '$type[$name]';
}

/// A lesson comments post data field with a value.
class LessonCommentsPostDataFieldValue extends LessonCommentsPostDataField {
  /// The value.
  final String value;

  /// Creates a new lesson comments post data field value instance.
  LessonCommentsPostDataFieldValue({
    @required LessonCommentsPostDataField field,
    @required this.value,
  }) : super(
          name: field.name,
          type: field.type,
        );
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
    @required this.id,
    @required this.author,
    @required this.date,
    @required this.message,
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
    @required this.name,
    @required this.avatar,
    @required this.isModerator,
  });

  /// Creates a new lesson comment author instance from a parsed JSON string.
  LessonCommentAuthor.fromParsedJSON(Map<String, dynamic> parsedJSON)
      : this(
          name: parsedJSON['name'],
          avatar: parsedJSON['avatar'],
          isModerator: parsedJSON['isModerator'],
        );
}
