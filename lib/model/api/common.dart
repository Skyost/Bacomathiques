import 'dart:convert';
import 'dart:io';

import 'package:bacomathiques/model/api/comments.dart';
import 'package:bacomathiques/model/api/content.dart';
import 'package:bacomathiques/model/api/list.dart';
import 'package:bacomathiques/model/api/summary.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

/// The API.
class API {
  /// The website base URL.
  static const String baseUrl = 'https://bacomathiqu.es';
}

/// The API status object.
class APIStatus {
  /// The "version" field.
  final int version;

  /// The "latestVersion" field.
  final int latestVersion;

  /// Creates a new API status instance.
  const APIStatus({
    required this.version,
    required this.latestVersion,
  });

  /// Creates a new API status instance from a parsed JSON string.
  APIStatus.fromParsedJSON(Map<String, dynamic> parsedJSON)
      : this(
          version: parsedJSON['version'],
          latestVersion: parsedJSON['latestVersion'],
        );

  /// Returns whether the current API is up to date.
  bool get isUpToDate => version >= latestVersion;
}

/// A level.
class Level {
  /// The "id" field.
  final String id;

  /// The "name" field.
  final String name;

  /// The "image" field.
  final String image;

  /// The "description" field.
  final String description;

  /// The "lessons" field.
  final APIEndpoint<LessonList> lessons;

  /// Creates a new level instance.
  const Level({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.lessons,
  });

  /// Creates a new level instance from a parsed JSON string.
  Level.fromParsedJSON(Map<String, dynamic> parsedJSON)
      : this(
          id: parsedJSON['id'],
          name: parsedJSON['name'],
          image: parsedJSON['image'],
          description: parsedJSON['description'],
          lessons: LessonListEndpoint(
            path: parsedJSON['lessons'],
          ),
        );
}

/// A lesson.
class Lesson {
  /// The "id" field.
  final String id;

  /// The "level" field.
  final String level;

  /// The "title" field.
  final String title;

  /// The "chapter" field.
  final int chapter;

  /// The "specialty" field.
  final bool specialty;

  /// The "content" field.
  final APIEndpoint<LessonContent> content;

  /// The "comments" field.
  final APIEndpoint<LessonComments> comments;

  /// The "summary" field.
  final APIEndpoint<LessonSummary> summary;

  /// Creates a new lesson instance.
  const Lesson({
    required this.id,
    required this.level,
    required this.title,
    required this.chapter,
    required this.specialty,
    required this.content,
    required this.comments,
    required this.summary,
  });

  /// Creates a new lesson instance from a parsed JSON string.
  Lesson.fromParsedJSON(Map<String, dynamic> parsedJSON)
      : this(
          id: parsedJSON['id'],
          level: parsedJSON['level'],
          title: parsedJSON['title'],
          chapter: parsedJSON['chapter'],
          specialty: parsedJSON['specialty'],
          content: LessonContentEndpoint(
            path: parsedJSON['content'],
          ),
          comments: LessonCommentsEndpoint(
            path: parsedJSON['comments'],
          ),
          summary: LessonSummaryEndpoint(
            path: parsedJSON['summary'],
          ),
        );
}

/// An API endpoint.
abstract class APIEndpoint<T extends APIEndpointResult> {
  /// The path to the endpoint.
  final String path;

  /// Creates a new API endpoint instance.
  const APIEndpoint({
    required this.path,
  });

  /// Creates the result object from a parsed JSON string.
  T createObjectFromJSON(Map<String, dynamic> parsedJSON);

  /// Requests the endpoint.
  Future<T?> request({bool cache = true}) async {
    String? content = await _getContent(cache: cache);
    return content == null ? null : createObjectFromJSON(json.decode(content));
  }

  /// Gets the content from the specified url and saves it to the local storage.
  Future<String?> _getContent({bool cache = true}) async {
    String path = this.path;
    if (!path.startsWith('/')) {
      path = '/$path';
    }

    File? file;
    String? content;

    if (cache) {
      Directory libDirectory = await getApplicationDocumentsDirectory();
      String filePath = path.replaceAll('/', Platform.pathSeparator);
      if (!filePath.endsWith(Platform.pathSeparator)) {
        filePath += Platform.pathSeparator;
      }
      file = File('${libDirectory.path}${filePath}index.json');
    }

    try {
      content = await http.read(Uri.parse(API.baseUrl + path));
      if (file != null) {
        if (!file.existsSync()) {
          file.createSync(recursive: true);
        }
        file.writeAsString(content);
      }
    } catch (ignored) {
      if (file != null && file.existsSync()) {
        content = await file.readAsString();
      }
    }

    return content;
  }
}

/// An API endpoint result.
abstract class APIEndpointResult {
  /// Creates a new API endpoint result instance.
  const APIEndpointResult();
}

/// An API endpoint result with a HTML body.
abstract class APIEndpointResultHTML extends APIEndpointResult {
  /// Creates a new API endpoint result with a HTML body.
  const APIEndpointResultHTML();

  /// The lesson.
  Lesson get lesson;

  /// The HTML body.
  String get html;
}
