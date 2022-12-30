import 'package:bacomathiques/model/api/common.dart';
import 'package:bacomathiques/model/api/content.dart';
import 'package:bacomathiques/utils/utils.dart';
import 'package:bacomathiques/widgets/app_bar/actions/action_menu.dart';
import 'package:flutter/material.dart';

/// Action menu that allows to save the PDF of a given lesson content.
class SavePdfActionMenu extends ActionMenu {
  /// The lesson content.
  final LessonContent lessonContent;

  /// Creates a new "Save PDF" action menu.
  const SavePdfActionMenu({
    required this.lessonContent,
  }) : super(
          icon: Icons.save,
          label: 'Enregistrer le PDF',
        );

  @override
  void onTap(BuildContext context) => openUrl(API.baseUrl + lessonContent.pdf);
}
