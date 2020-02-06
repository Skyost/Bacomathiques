import 'package:bacomathiques/app/api/comments.dart';
import 'package:bacomathiques/app/api/common.dart';
import 'package:bacomathiques/app/app.dart';
import 'package:bacomathiques/utils/utils.dart';
import 'package:flutter/material.dart';

/// The comments screen, where previews are shown.
class CommentsPage extends StatefulWidget {
  /// The comments endpoint.
  final APIEndpoint<LessonComments> endpoint;

  /// Creates a new comments screen instance.
  CommentsPage(this.endpoint);

  @override
  _CommentsPageState createState() => _CommentsPageState(endpoint);
}

/// The comments screen state.
class _CommentsPageState extends RequestScaffold<CommentsPage, LessonComments> {
  /// Creates a new home screen state instance.
  _CommentsPageState(
    APIEndpoint<LessonComments> endpoint,
  ) : super(
          endpoint: endpoint,
          failMessage: 'Impossible de charger les commentaires de ce cours.',
        );

  @override
  Widget createBody(BuildContext context) {
    if (result.list.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
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
      semanticChildCount: result.list.length,
      itemCount: result.list.length,
      itemBuilder: (context, position) => _CommentWidget(result.list[position]),
    );
  }
}

/// A widget that allows to show a comment.
class _CommentWidget extends StatelessWidget {
  /// The comment to show.
  final LessonComment _comment;

  /// Creates a new comment widget instance.
  _CommentWidget(this._comment);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
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
        padding: const EdgeInsets.only(right: 10),
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
          padding: const EdgeInsets.all(20),
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
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
          _comment.author.name + (_comment.author.isModerator ? ' (Modérateur)' : ''),
          style: Theme.of(context).textTheme.body1.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      );

  /// Creates the message widget.
  Widget _createMessageWidget() => Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Text(
          _comment.message,
        ),
      );

  /// Creates the date widget.
  Widget _createDateWidget(BuildContext context) => SizedBox(
        width: double.infinity,
        child: Text(
          _dateToString(DateTime.fromMillisecondsSinceEpoch(_comment.date * 1000)),
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
