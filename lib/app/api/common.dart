import 'dart:convert';
import 'dart:io';

import 'package:bacomathiques/app/api/comments.dart';
import 'package:bacomathiques/app/api/content.dart';
import 'package:bacomathiques/app/api/list.dart';
import 'package:bacomathiques/app/api/summary.dart';
import 'package:bacomathiques/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:pedantic/pedantic.dart';

/// The API.
class API {
  /// The website base URL.
  static const String BASE_URL = 'https://bacomathiqu.es';
}

/// The API status object.
class APIStatus {
  /// The "version" field.
  final int version;

  /// The "latestVersion" field.
  final int latestVersion;

  /// Creates a new API status instance.
  const APIStatus({
    @required this.version,
    @required this.latestVersion,
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
    @required this.id,
    @required this.name,
    @required this.image,
    @required this.description,
    @required this.lessons,
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
    @required this.id,
    @required this.level,
    @required this.title,
    @required this.chapter,
    @required this.specialty,
    @required this.content,
    @required this.comments,
    @required this.summary,
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

  /// Returns the images directory URL.
  String get imagesDirectoryURL => '${API.BASE_URL}/assets/img/lessons/$level/$id';
}

/// An API endpoint.
abstract class APIEndpoint<T extends APIEndpointResult> {
  /// The path to the endpoint.
  final String path;

  /// Creates a new API endpoint instance.
  const APIEndpoint({
    @required this.path,
  });

  /// Creates the result object from a parsed JSON string.
  T createObjectFromJSON(Map<String, dynamic> parsedJSON);

  /// Requests the endpoint.
  Future<T> request({bool cache = true}) async {
    String content = await _getContent(cache: cache);
    return content == null ? null : createObjectFromJSON(json.decode(content));
  }

  /// Gets the content from the specified url and saves it to the local storage.
  Future<String> _getContent({bool cache = true}) async {
    File file;
    String content;

    if (cache) {
      Directory libDirectory = await getApplicationDocumentsDirectory();
      String filePath = path.replaceAll('/', Platform.pathSeparator);
      if (!filePath.endsWith(Platform.pathSeparator)) {
        filePath += Platform.pathSeparator;
      }
      file = File('${libDirectory.path}${filePath}index.json');
    }

    try {
      content = await http.read(API.BASE_URL + path);
      if (file != null) {
        if (!file.existsSync()) {
          file.createSync(recursive: true);
        }
        unawaited(file.writeAsString(content));
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

  /// Creates the app bar.
  AppBar createAppBar(BuildContext context) => AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            _createLogoWidget(context),
            _createTitleWidget(context),
          ],
        ),
        actions: createActions(context),
      );

  /// Creates the logo widget.
  Widget _createLogoWidget(BuildContext context) => SvgPicture.asset(
        'assets/images/logo.svg',
        width: MediaQuery.of(context).size.width > App.DAY_NIGHT_SWITCH_WIDTH_BREAKPOINT ? 30 : 26,
        semanticsLabel: 'Logo',
      );

  /// Creates the title widget.
  Widget _createTitleWidget(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 5, left: 7),
        child: Text(
          App.APP_NAME,
          style: GoogleFonts.handlee(fontSize: MediaQuery.of(context).size.width > App.DAY_NIGHT_SWITCH_WIDTH_BREAKPOINT ? 26 : 30),
        ),
      );

  @protected
  List<Widget> createActions(BuildContext context) => null;
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
