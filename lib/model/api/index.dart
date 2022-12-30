import 'package:bacomathiques/model/api/common.dart';

/// /api/v2/ endpoint.
class APIIndexEndpoint extends APIEndpoint<APIIndex> {
  /// Creates a new API index endpoint instance.
  const APIIndexEndpoint()
      : super(
          path: '/api/v2',
        );

  @override
  APIIndex createObjectFromJSON(Map<String, dynamic> parsedJSON) => APIIndex.fromParsedJSON(parsedJSON);
}

/// The API index result object.
class APIIndex extends APIEndpointResult {
  /// The "api" field.
  final APIStatus api;

  /// The "levels" field.
  final List<Level> levels;

  /// Creates a new API index instance.
  const APIIndex({
    required this.api,
    required this.levels,
  });

  /// Creates a new API index instance from a parsed JSON string.
  APIIndex.fromParsedJSON(Map<String, dynamic> parsedJSON)
      : this(
          api: APIStatus.fromParsedJSON(parsedJSON['api']),
          levels: parsedJSON['levels'].map<Level>((level) => Level.fromParsedJSON(level)).toList(),
        );
}
