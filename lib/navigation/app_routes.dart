import 'package:bacomathiques/model/api/comments.dart';
import 'package:bacomathiques/model/api/common.dart';
import 'package:bacomathiques/model/api/list.dart';

/// Application route names and typed arguments.
abstract final class AppRoutes {
  static const home = '/';
  static const levels = '/levels';
  static const lessons = '/lessons';
  static const html = '/html';
  static const comments = '/comments';
}

/// Arguments for [AppRoutes.lessons].
class LessonsRouteArguments {
  /// The lessons endpoint.
  final APIEndpoint<LessonList> endpoint;

  /// Creates lessons route arguments.
  const LessonsRouteArguments({
    required this.endpoint,
  });
}

/// Arguments for [AppRoutes.html].
class HtmlRouteArguments {
  /// The HTML endpoint.
  final APIEndpoint<APIEndpointResultHTML> endpoint;

  /// Optional anchor to scroll to.
  final String? anchor;

  /// Creates HTML route arguments.
  const HtmlRouteArguments({
    required this.endpoint,
    this.anchor,
  });
}

/// Arguments for [AppRoutes.comments].
class CommentsRouteArguments {
  /// The lesson comments endpoint.
  final APIEndpoint<LessonComments> endpoint;

  /// Creates comments route arguments.
  const CommentsRouteArguments({
    required this.endpoint,
  });
}
