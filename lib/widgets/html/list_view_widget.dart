import 'package:flutter/material.dart';

/// Allows to put the content in a list view.
class ListViewWidget extends StatefulWidget {
  /// The list view will automatically scroll to the element with this key.
  final GlobalKey? scrollToThisKey;

  /// The children.
  final List<Widget> children;

  /// Creates a new list view widget.
  const ListViewWidget({
    this.scrollToThisKey,
    required this.children,
  });

  @override
  State<StatefulWidget> createState() => _ListViewWidgetState();
}

/// The list view widget state.
class _ListViewWidgetState extends State<ListViewWidget> {
  /// The scroll controller.
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();

    scrollController = ScrollController();
    if (widget.scrollToThisKey != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        double screenHeight = scrollController.position.viewportDimension;
        while (scrollController.offset < scrollController.position.maxScrollExtent) {
          await scrollController.position.moveTo(scrollController.offset + screenHeight, duration: const Duration(milliseconds: 100));
          RenderObject? renderObject = widget.scrollToThisKey?.currentContext?.findRenderObject();
          if (renderObject != null) {
            await scrollController.position.ensureVisible(renderObject);
            return;
          }
        }
        await scrollController.position.moveTo(0);
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

/// Marks a "scroll" point.
class ScrollToThis extends StatelessWidget {
  /// Creates a new "scroll to this" widget instance.
  const ScrollToThis(GlobalKey key)
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) => const Offstage();
}
