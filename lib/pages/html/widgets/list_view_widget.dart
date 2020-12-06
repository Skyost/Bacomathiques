import 'package:flutter/material.dart';

/// Allows to put the content in a list view.
class ListViewWidget extends StatefulWidget {
  /// The list view will automatically scroll to the element with this key.
  final GlobalKey scrollToThisKey;

  /// The children.
  final List<Widget> children;

  /// Creates a new list view widget.
  const ListViewWidget({
    this.scrollToThisKey,
    @required this.children,
  });

  @override
  State<StatefulWidget> createState() => _ListViewWidgetState();
}

/// The list view widget state.
class _ListViewWidgetState extends State<ListViewWidget> {
  /// The scroll controller.
  ScrollController scrollController;

  @override
  void initState() {
    super.initState();

    scrollController = ScrollController();
    if (widget.scrollToThisKey != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        scrollController.position.ensureVisible(widget.scrollToThisKey.currentContext.findRenderObject());
      });
    }
  }

  @override
  Widget build(BuildContext context) => ListView(
        controller: scrollController,
        shrinkWrap: true,
        padding: const EdgeInsets.all(20),
        children: widget.children,
      );

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
