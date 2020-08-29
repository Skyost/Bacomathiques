import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:mime/mime.dart';

/// Allows to create a local server.
/// Thanks to flutter_tex (https://github.com/shahxadakram/flutter_tex) for the base implementation of this class.
class Server {
  /// The http server.
  HttpServer _server;

  /// All format arguments.
  Map<String, List<FormatArgument>> formatArguments;

  /// Creates a new server instance.
  Server([this.formatArguments]);

  /// Returns the server address.
  String get address => _server?.address?.address;

  /// Returns the server port.
  int get port => _server?.port;

  /// Closes the server.
  Future<void> close() async {
    if (_server != null) {
      await _server.close(force: true);
      _server = null;
    }
  }

  /// Starts the server.
  Future<void> start() async {
    if (_server != null) {
      await close();
    }

    _server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    _server.listen((HttpRequest request) async {
      String path = request.requestedUri.path;
      path = (path.startsWith('/')) ? path.substring(1) : path;
      path += (path.endsWith('/')) ? 'index.html' : '';

      List<FormatArgument> arguments = formatArguments == null ? null : formatArguments[path];
      if (arguments == null) {
        await sendResponseWithoutFormatting(request, path);
      } else {
        await sendResponseWithFormatting(request, path, arguments);
      }
    });
  }

  /// Sends the response with formatting.
  Future<void> sendResponseWithFormatting(HttpRequest request, String path, List<FormatArgument> arguments) async {
    var body = '';

    try {
      body = await rootBundle.loadString(path);
    } catch (e) {
      print(e.toString());
      return request.response.close();
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

    request.response.headers.contentType = ContentType(contentType[0], contentType[1], charset: 'utf-8');
    request.response.write(body);
    return request.response.close();
  }

  /// Sends the response without formatting.
  Future<void> sendResponseWithoutFormatting(HttpRequest request, String path) async {
    var body = [];

    try {
      body = (await rootBundle.load(path)).buffer.asUint8List();
    } catch (e) {
      print(e.toString());
      return request.response.close();
    }

    var contentType = ['text', 'html'];
    if (!request.requestedUri.path.endsWith('/') && request.requestedUri.pathSegments.isNotEmpty) {
      var mimeType = lookupMimeType(request.requestedUri.path, headerBytes: body);
      if (mimeType != null) {
        contentType = mimeType.split('/');
      }
    }

    request.response.headers.contentType = ContentType(contentType[0], contentType[1], charset: 'utf-8');
    request.response.add(body);
    return request.response.close();
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
