import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:mime/mime.dart';

/// Allows to create a local server.
/// Thanks to flutter_tex (https://github.com/shahxadakram/flutter_tex) for the base implementation of this class.
class Server {
  /// The http server.
  HttpServer _server;

  /// The port.
  int _port = 8080;

  /// All format arguments.
  Map<String, List<FormatArgument>> formatArguments;

  /// Creates a new server instance.
  Server(this._port, [this.formatArguments]);

  /// Closes the server.
  Future<void> close() async {
    if (this._server != null) {
      await this._server.close(force: true);
      print('Server running on http://localhost:$_port closed');
      this._server = null;
    }
  }

  /// Starts the server.
  Future<void> start() async {
    if (this._server != null) {
      throw Exception('Server already started on http://localhost:$_port');
    }

    var completer = new Completer();

    runZoned(() {
      HttpServer.bind('127.0.0.1', _port).then((server) {
        print('Server running on http://localhost:' + _port.toString());

        this._server = server;

        server.listen((HttpRequest request) async {
          var path = request.requestedUri.path;
          path = (path.startsWith('/')) ? path.substring(1) : path;
          path += (path.endsWith('/')) ? 'index.html' : '';

          List<FormatArgument> arguments = formatArguments == null ? null : formatArguments[path];
          if (arguments == null) {
            sendResponseWithoutFormatting(request, path);
            return;
          }

          sendResponseWithFormatting(request, path, arguments);
        });

        completer.complete();
      });
    }, onError: (e, stackTrace) => print('Error: $e $stackTrace'));

    return completer.future;
  }

  /// Sends the response with formatting.
  Future<void> sendResponseWithFormatting(HttpRequest request, String path, List<FormatArgument> arguments) async {
    var body = '';

    try {
      body = await rootBundle.loadString(path);
    } catch (e) {
      print(e.toString());
      request.response.close();
      return;
    }

    arguments.forEach((argument) {
      body = body.replaceAll('{' + argument.key + '}', argument.value);
    });

    var contentType = ['text', 'html'];
    if (!request.requestedUri.path.endsWith('/') && request.requestedUri.pathSegments.isNotEmpty) {
      var mimeType = lookupMimeType(request.requestedUri.path);
      if (mimeType != null) {
        contentType = mimeType.split('/');
      }
    }

    request.response.headers.contentType = new ContentType(contentType[0], contentType[1], charset: 'utf-8');
    request.response.write(body);
    request.response.close();
  }

  /// Sends the response without formatting.
  Future<void> sendResponseWithoutFormatting(HttpRequest request, String path) async {
    var body = List<int>();

    try {
      body = (await rootBundle.load(path)).buffer.asUint8List();
    } catch (e) {
      print(e.toString());
      request.response.close();
      return;
    }

    var contentType = ['text', 'html'];
    if (!request.requestedUri.path.endsWith('/') && request.requestedUri.pathSegments.isNotEmpty) {
      var mimeType = lookupMimeType(request.requestedUri.path, headerBytes: body);
      if (mimeType != null) {
        contentType = mimeType.split('/');
      }
    }

    request.response.headers.contentType = new ContentType(contentType[0], contentType[1], charset: 'utf-8');
    request.response.add(body);
    request.response.close();
  }
}

/// A format argument.
class FormatArgument {
  /// The key.
  String key;

  /// The value.
  String value;

  /// Creates a new format argument instance.
  FormatArgument(this.key, this.value);
}
