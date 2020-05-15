import 'package:bacomathiques/app/api/comments.dart';
import 'package:bacomathiques/app/api/common.dart';
import 'package:bacomathiques/app/app.dart';
import 'package:bacomathiques/app/settings.dart';
import 'package:bacomathiques/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// The comments screen, where previews are shown.
class CommentsPage extends StatefulWidget {
  /// The comments endpoint.
  final APIEndpoint<LessonComments> endpoint;

  /// Creates a new comments screen instance.
  const CommentsPage({
    @required this.endpoint,
  });

  @override
  _CommentsPageState createState() => _CommentsPageState(endpoint: endpoint);
}

/// The comments screen state.
class _CommentsPageState extends RequestScaffold<CommentsPage, LessonComments> {
  /// The current bottom padding to add.
  double bottomPadding = 0;

  /// Creates a new home screen state instance.
  _CommentsPageState({
    @required APIEndpoint<LessonComments> endpoint,
  }) : super(
          endpoint: endpoint,
          failMessage: 'Impossible de charger les commentaires de ce cours.',
          cacheRequest: false,
        );

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      SettingsModel settingsModel = Provider.of<SettingsModel>(context, listen: false);
      if (settingsModel.adMobEnabled) {
        bottomPadding = 60;
      }
    });
  }

  @override
  Widget createBody(BuildContext context) {
    if (result.list.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Center(
          child: Text(
            'Aucun commentaire sur ce cours pour le moment. Soyez le premier à en poster un !',
            textAlign: TextAlign.center,
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 20 + bottomPadding),
      semanticChildCount: result.list.length,
      itemCount: result.list.length,
      itemBuilder: (context, position) => _CommentWidget(comment: result.list[position]),
    );
  }
}

/// A widget that allows to show a comment.
class _CommentWidget extends StatelessWidget {
  /// The comment to show.
  final LessonComment comment;

  /// Creates a new comment widget instance.
  const _CommentWidget({
    @required this.comment,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Consumer<SettingsModel>(
          builder: (context, settings, _) => Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _createAvatarWidget(settings.appTheme),
              _createContentWidget(context, settings.appTheme),
            ],
          ),
        ),
      );

  /// Creates the avatar widget.
  Widget _createAvatarWidget(AppTheme theme) => Padding(
        padding: const EdgeInsets.only(right: 10),
        child: CircleAvatar(
          backgroundImage: NetworkImage(comment.author.avatar),
          backgroundColor: theme.themeData.primaryColor.withAlpha(50),
          radius: 30,
        ),
      );

  /// Creates the content widget.
  Widget _createContentWidget(BuildContext context, AppTheme theme) => Expanded(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(theme.themeData.commentBorderRadius),
              bottomRight: Radius.circular(theme.themeData.commentBorderRadius),
              bottomLeft: Radius.circular(theme.themeData.commentBorderRadius),
            ),
            color: theme.themeData.commentBackgroundColor,
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              _createAuthorWidget(context),
              _createMessageWidget(),
              _createDateWidget(context, theme),
            ],
          ),
        ),
      );

  /// Creates the author widget.
  Widget _createAuthorWidget(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
          comment.author.name + (comment.author.isModerator ? ' (Modérateur)' : ''),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      );

  /// Creates the message widget.
  Widget _createMessageWidget() => Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Text(
          comment.message,
        ),
      );

  /// Creates the date widget.
  Widget _createDateWidget(BuildContext context, AppTheme theme) => SizedBox(
        width: double.infinity,
        child: Text(
          _dateToString(DateTime.fromMillisecondsSinceEpoch(comment.date * 1000)),
          textAlign: TextAlign.right,
          style: TextStyle(
            fontSize: 12,
            color: theme.themeData.commentDateColor,
          ),
        ),
      );

  /// Returns a formatted date string.
  String _dateToString(DateTime date) => date.day.toString().padLeft(2, '0') + '/' + date.month.toString().padLeft(2, '0') + '/' + date.year.toString();
}
