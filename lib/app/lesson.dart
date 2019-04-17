import 'dart:convert';

import 'package:bacomathiques/app/dialogs.dart' as Dialogs;
import 'package:bacomathiques/util/util.dart';
import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:share/share.dart';

/// Represents an API object.
abstract class APIObject<T> {
  /// The website address.
  static const WEBSITE = 'https://bacomathiqu.es/';

  /// The API path.
  static const API_PATH = WEBSITE + 'api/v1/';

  /// The object identifier.
  final String id;

  /// The object title.
  final String title;

  /// The object main content.
  final T content;

  /// Creates a new API object instance.
  const APIObject(this.id, this.title, this.content);

  /// Creates all actions (displayed in the action bar).
  List<Widget> createActions(BuildContext context);
}

/// Represents a lesson preview with a title, a picture and a description.
class Preview extends APIObject<String> {
  /// Path to previews.
  static const PREVIEWS_PATH = 'lessons.json';

  /// The current preview image URL.
  final String previewImage;

  /// The preview image caption.
  final String caption;

  /// The content URL.
  final String contentURL;

  /// The summary URL.
  final String summaryURL;

  /// Creates a new lesson preview instance.
  Preview(String id, String title, String content, this.previewImage, this.caption, this.contentURL, this.summaryURL) : super(id, title, content);

  /// Requests to load the list of available previews.
  static Future<List<Preview>> request() async {
    String content = await getAndSave('previews', 'content', APIObject.API_PATH + PREVIEWS_PATH);
    if (content == null) {
      return null;
    }

    List<dynamic> previews = json.decode(content);
    return List.of(previews.map((preview) => Preview(preview['id'], preview['title'], HtmlUnescape().convert(preview['excerpt']).replaceAll("<q>", "« <em>").replaceAll('</q>', '</em> »'), preview['preview'], HtmlUnescape().convert(preview['caption']), preview['content'], preview['summary'])));
  }

  @override
  List<Widget> createActions(BuildContext context) => null;
}

/// Represents a lesson.
class Lesson extends APIObject<String> {
  /// Available action bar actions.
  static final _actions = [
    ActionMenu(Icons.assignment_turned_in, 'Annales…', (context, object) => Dialogs.AnnalsDialog.show(context, object as Lesson)),
    ActionMenu(Icons.save, 'Enregistrer le PDF', (context, object) => openURL(APIObject.WEBSITE + 'assets/pdf/lessons/' + Uri.encodeComponent(object.title.replaceAll('é', 'e').replaceAll('É', 'E')) + '.pdf')),
    ActionMenu(Icons.subtitles, 'Publicités…', (context, object) => Dialogs.AdsDialog.show(context)),
    ActionMenu(Icons.thumb_up, 'Noter l\'application', (context, object) => openURL(storePage)),
    ActionMenu(Icons.sms_failed, 'Signaler un bug', (context, object) => openURL('https://github.com/Skyost/Bacomathiques/issues/new?title=[Application]%20Rapport%20de%20bug')),
    ActionMenu(Icons.help, 'À Propos…', (context, object) => Dialogs.AboutDialog.show(context))
  ];

  /// List of annals.
  final List<String> annals;

  /// The comments URL.
  final String commentsURL;

  /// Creates a new lesson instance.
  Lesson(String id, String title, String content, this.annals, this.commentsURL) : super(id, title, content);

  /// Requests to load the specified lesson.
  static Future<Lesson> request(String relativeURL) async {
    String data = await getAndSave('lessons', relativeURL, APIObject.WEBSITE + relativeURL);
    if (data == null) {
      return null;
    }

    Map<String, dynamic> lesson = json.decode(data);
    List<String> annals = [];
    lesson['annals'].forEach((id) => annals.add(id));

    return Lesson(
      lesson['id'],
      lesson['title'],
      HtmlUnescape().convert(lesson['content']),
      annals,
      lesson['comments'] ?? APIObject.API_PATH.substring(APIObject.WEBSITE.length) + 'comments/' + lesson['id'] + '.json',
    );
  }

  @override
  List<Widget> createActions(BuildContext context) => [
        IconButton(
          icon: Icon(
            Icons.share,
            color: Colors.white,
          ),
          onPressed: () => Share.share('Lisez le cours intitulé « ' + title + ' » en téléchargeant l\'application Bacomathiques !\n' + storePage),
        ),
        IconButton(
          icon: Icon(
            Icons.message,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/comments', arguments: {
              'relativeURL': commentsURL,
            });
          },
        ),
        PopupMenuButton<ActionMenu>(
          onSelected: (action) => action.callback(context, this),
          itemBuilder: (context) => _actions
              .map(
                (action) => PopupMenuItem<ActionMenu>(
                      value: action,
                      child: action.createWidget(),
                    ),
              )
              .toList(),
        )
      ];
}

/// Represents a lesson summary.
class Summary extends APIObject<String> {
  /// Creates a new lesson summary instance.
  Summary(String id, String title, String content) : super(id, title, content);

  /// Requests to load the specified lesson summary.
  static Future<Summary> request(String relativeURL) async {
    String content = await getAndSave('summaries', relativeURL, APIObject.WEBSITE + relativeURL);
    if (content == null) {
      return null;
    }

    Map<String, dynamic> summary = json.decode(content);
    return Summary(
      summary['id'],
      summary['title'],
      HtmlUnescape().convert(summary['content']),
    );
  }

  @override
  List<Widget> createActions(BuildContext context) => [];
}

/// Represents a comment list.
class Comments extends APIObject<List<Comment>> {
  /// The URL that allows to post comments to this list.
  String postURL;

  /// Creates a new comments instance.
  Comments(String id, List<Comment> content, this.postURL) : super(id, 'Commentaires', content);

  /// Requests to load the specified comments.
  static Future<Comments> request(String relativeURL) async {
    String content;
    try {
      content = await http.read(APIObject.WEBSITE + relativeURL);
    } catch (ignored) {}

    if (content == null) {
      return null;
    }

    Map<String, dynamic> data = json.decode(content);
    List<dynamic> jsonComments = data['comments'];
    List<Comment> comments = [];
    for (Map<String, dynamic> comment in jsonComments) {
      Map<String, dynamic> authorData = comment['author'];
      comments.add(Comment(comment['id'], CommentAuthor(authorData['name'], authorData['avatar'], authorData['isModerator']), comment['message'], DateTime.fromMillisecondsSinceEpoch(comment['date'] * 1000)));
    }

    return Comments(
      data['lesson'],
      comments,
      data['postUrl'],
    );
  }

  /// Creates a new local storage instance containing comments settings.
  static LocalStorage createCommentsSettings() => LocalStorage('comments');

  /// Posts a new comment.
  Future<bool> post(String message) async {
    try {
      LocalStorage storage = createCommentsSettings();
      String username = storage.getItem('username');
      if(username == null || username.isEmpty) {
        username = 'Anonyme';
      }

      http.Response response = await http.post(postURL, body: {
        'options[slug]': id,
        'fields[lesson]': id,
        'fields[message]': message,
        'fields[author]': username,
      });

      Map<String, dynamic> data = json.decode(response.body);
      return data['success'] ?? false;
    } catch (ignored) {
      return false;
    }
  }

  @override
  List<Widget> createActions(BuildContext context) => [
        IconButton(
          icon: Icon(
            Icons.person,
            color: Colors.white,
          ),
          onPressed: () => Dialogs.UserDialog.show(context),
        ),
        IconButton(
          icon: Icon(
            Icons.create,
            color: Colors.white,
          ),
          onPressed: () => Dialogs.WriteCommentDialog.show(context, this),
        ),
      ];
}

/// Represents a comment.
class Comment {
  /// The comment id.
  String id;

  /// The comment author.
  CommentAuthor author;

  /// The comment message.
  String message;

  /// The comment date.
  DateTime date;

  /// Creates a new comment instance.
  Comment(this.id, this.author, this.message, this.date);
}

/// Represents a comment author.
class CommentAuthor {
  /// The author name.
  String name;

  /// The author avatar.
  String avatar;

  /// Whether this author is a moderator.
  bool isModerator;

  /// Creates a new comment author instance.
  CommentAuthor(this.name, this.avatar, this.isModerator);
}

/// An action menu with text, icon and callback.
class ActionMenu {
  /// The menu icon.
  final IconData _icon;

  /// The menu label.
  final String _label;

  /// The callback.
  final Function(BuildContext, APIObject) callback;

  /// Creates a new action menu.
  ActionMenu(this._icon, this._label, this.callback);

  /// Creates and returns the widget corresponding to this action menu.
  Widget createWidget() => Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 5,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 5),
            child: Icon(
              _icon,
              color: Colors.black,
            ),
          ),
          Text(
            _label,
            style: TextStyle(color: Colors.black),
          ),
        ],
      );
}
