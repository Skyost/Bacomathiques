
import 'package:bacomathiques/app/api/comments.dart';
import 'package:flutter/material.dart';

/// The user dialog.
class UserDialog extends StatelessWidget {
  /// The current comments instance.
  final LessonComments comments;

  /// A text editing controller.
  final TextEditingController _controller;

  /// Creates a new user dialog instance.
  UserDialog({
    required this.comments,
  }) : _controller = TextEditingController(text: comments.username);

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: _createTitleWidget(),
    content: _createContentWidget(context),
    actions: [
      Wrap(
        alignment: WrapAlignment.end,
        crossAxisAlignment: WrapCrossAlignment.end,
        direction: Axis.vertical,
        children: createActionsWidgets(context),
      )
    ],
  );

  /// Creates a new title widget.
  Widget _createTitleWidget() => const Text('Utilisateur');

  /// Creates a new content widget.
  Widget _createContentWidget(BuildContext context) => TextField(
    controller: _controller,
    onSubmitted: (username) => Navigator.pop(context),
    decoration: const InputDecoration(
      hintText: 'Nom d\'utilisateur',
    ),
  );

  /// Creates a new dialog actions widgets.
  List<Widget> createActionsWidgets(BuildContext context) => [
    TextButton(
      onPressed: () {
        comments.username = _controller.text;
        Navigator.pop(context);
      },
      child: Text('Valider'.toUpperCase()),
    ),
    TextButton(
      onPressed: () => Navigator.pop(context),
      child: Text('Annuler'.toUpperCase()),
    ),
  ];

  /// Shows the dialog.
  static void show(BuildContext context, {required LessonComments comments}) => showDialog(
    context: context,
    builder: (context) => UserDialog(comments: comments),
  );
}