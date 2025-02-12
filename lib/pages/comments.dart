import 'package:bacomathiques/model/api/comments.dart';
import 'package:bacomathiques/model/settings.dart';
import 'package:bacomathiques/widgets/app_bar/app_bar.dart';
import 'package:bacomathiques/widgets/dialogs/user.dart';
import 'package:bacomathiques/widgets/dialogs/write_comment.dart';
import 'package:bacomathiques/widgets/request_scaffold.dart';
import 'package:bacomathiques/widgets/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jovial_svg/jovial_svg.dart';

/// The comments screen, where previews are shown.
class CommentsPage extends RequestScaffold<LessonComments> {
  /// Creates a new comments screen instance.
  const CommentsPage({
    required super.endpoint,
  });

  @override
  ConsumerState createState() => _CommentsPageState();
}

/// The comments screen state.
class _CommentsPageState extends RequestScaffoldState<LessonComments, CommentsPage> {
  /// Creates a new home screen state instance.
  _CommentsPageState()
      : super(
          failMessage: 'Impossible de charger les commentaires de ce cours.',
          cacheRequest: false,
        );

  @override
  AppBar createAppBar(BuildContext context) => BacomathiquesAppBar(
        title: Text('Commentaires sur ${result!.lesson.title}'),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.person,
              color: Colors.white,
            ),
            onPressed: () => UserDialog.show(context),
          ),
          IconButton(
            icon: const Icon(
              Icons.create,
              color: Colors.white,
            ),
            onPressed: () => WriteCommentDialog.show(context, comments: result!),
          ),
        ],
      );

  @override
  Widget createBody(BuildContext context, LessonComments result) {
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
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      semanticChildCount: result.list.length,
      itemCount: result.list.length,
      itemBuilder: (context, position) => _CommentWidget(comment: result.list[position]),
    );
  }
}

/// A widget that allows to show a comment.
class _CommentWidget extends ConsumerWidget {
  /// The comment to show.
  final LessonComment comment;

  /// Creates a new comment widget instance.
  const _CommentWidget({
    required this.comment,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AppTheme theme = ref.watch(settingsModelProvider).resolveTheme(context);
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: _AvatarWidget(
              url: comment.author.avatar,
              primaryColor: theme.primaryColor,
            ),
          ),
          Expanded(
            child: _CommentMessageWidget(
              comment: comment,
            ),
          ),
        ],
      ),
    );
  }
}

/// Allows to display an avatar.
class _AvatarWidget extends StatelessWidget {
  /// The avatar URL.
  final String url;

  /// The color.
  final Color primaryColor;

  /// Creates a new avatar widget instance.
  const _AvatarWidget({
    required this.url,
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    Uri uri = Uri.parse(url);
    if (uri.pathSegments.lastOrNull?.endsWith('svg') ?? false) {
      return SizedBox(
        width: 60,
        child: ScalableImageWidget.fromSISource(
          si: ScalableImageSource.fromSvgHttpUrl(uri),
          onLoading: (context) => Container(
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(50),
              shape: BoxShape.circle,
            ),
          ),
        ),
      );
    }

    return CircleAvatar(
      backgroundImage: NetworkImage(url),
      backgroundColor: primaryColor.withAlpha(50),
      radius: 30,
    );
  }
}

/// A widget that allows to show a comment message.
class _CommentMessageWidget extends ConsumerWidget {
  /// The comment message to show.
  final LessonComment comment;

  /// Creates a new comment message widget instance.
  const _CommentMessageWidget({
    required this.comment,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AppTheme theme = ref.watch(settingsModelProvider).resolveTheme(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(theme.commentBorderRadius),
          bottomRight: Radius.circular(theme.commentBorderRadius),
          bottomLeft: Radius.circular(theme.commentBorderRadius),
        ),
        color: theme.commentBackgroundColor,
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              comment.author.name + (comment.author.isModerator ? ' (Modérateur)' : ''),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Text(
              comment.message,
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Text(
              dateToString(DateTime.fromMillisecondsSinceEpoch(comment.date * 1000)),
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 12,
                color: theme.commentDateColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Returns a formatted date string.
  String dateToString(DateTime date) => '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
}
