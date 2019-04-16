import 'package:bacomathiques/app/app.dart';
import 'package:bacomathiques/app/lesson.dart';
import 'package:bacomathiques/util/util.dart';
import 'package:flutter/material.dart';

/// comments home screen, where previews are shown.
class CommentsScreen extends StatefulWidget {
  /// The relative URL of comments.
  final String _relativeURL;

  /// Creates a new comments screen instance.
  CommentsScreen(this._relativeURL);

  @override
  _CommentsScreenState createState() => _CommentsScreenState(() => Comments.request(_relativeURL));
}

/// The comments screen state.
class _CommentsScreenState extends RequestScaffold<CommentsScreen, Comments> {
  /// Creates a new home screen state instance.
  _CommentsScreenState(Function() _requestObjectFunction) : super(_requestObjectFunction, 'Impossible de charger les commentaires de ce cours.');

  @override
  AppBar createAppBar(BuildContext context) => AppBar(
        title: Text(object == null ? 'Chargement…' : object.title),
        actions: object?.createActions(context),
      );

  @override
  Widget createBody(BuildContext context) {
    if (object.content.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Center(
          child: Text(
            'Aucun commentaire sur ce cours pour le moment. Soyez le premier à en poster un !',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.body1.copyWith(fontStyle: FontStyle.italic),
          ),
        ),
      );
    }

    return ListView.builder(
      semanticChildCount: object.content.length,
      scrollDirection: Axis.vertical,
      itemCount: object.content.length,
      itemBuilder: (context, position) => _CommentWidget(object.content[position]),
    );
  }
}

/// A widget that allows to show a comment.
class _CommentWidget extends StatelessWidget {
  /// The comment to show.
  final Comment _comment;

  /// Creates a new comment widget instance.
  _CommentWidget(this._comment);

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _createAvatarWidget(),
            _createContentWidget(context),
          ],
        ),
      );

  /// Creates the avatar widget.
  Widget _createAvatarWidget() => Padding(
        padding: EdgeInsets.only(right: 10),
        child: CircleAvatar(
          backgroundImage: NetworkImage(_comment.author.avatar),
          backgroundColor: App.PRIMARY_COLOR.withAlpha(50),
          radius: 30,
        ),
      );

  /// Creates the content widget.
  Widget _createContentWidget(BuildContext context) => Expanded(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(App.COMMENT_BORDER_RADIUS),
              bottomRight: Radius.circular(App.COMMENT_BORDER_RADIUS),
              bottomLeft: Radius.circular(App.COMMENT_BORDER_RADIUS),
            ),
            color: App.COMMENT_BACKGROUND_COLOR,
          ),
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              _createAuthorWidget(context),
              _createMessageWidget(),
              _createDateWidget(context),
            ],
          ),
        ),
      );

  /// Creates the author widget.
  Widget _createAuthorWidget(BuildContext context) => Padding(
        padding: EdgeInsets.only(bottom: 8),
        child: Text(
          _comment.author.name + (_comment.author.isModerator ? ' (Modérateur)' : ''),
          style: Theme.of(context).textTheme.body1.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      );

  /// Creates the message widget.
  Widget _createMessageWidget() => Padding(
        padding: EdgeInsets.only(bottom: 16),
        child: Text(
          _comment.message,
        ),
      );

  /// Creates the date widget.
  Widget _createDateWidget(BuildContext context) => SizedBox(
        width: double.infinity,
        child: Text(
          _dateToString(_comment.date),
          textAlign: TextAlign.right,
          style: Theme.of(context).textTheme.body1.copyWith(
                fontSize: 12,
                color: App.COMMENT_DATE_COLOR,
              ),
        ),
      );

  /// Returns a formatted date string.
  String _dateToString(DateTime date) => date.day.toString().padLeft(2, '0') + '/' + date.month.toString().padLeft(2, '0') + '/' + date.year.toString();
}
