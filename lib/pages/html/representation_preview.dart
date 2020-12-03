import 'package:bacomathiques/utils/fade_stack_widget.dart';
import 'package:bacomathiques/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// Allows to preview representations.
class RepresentationPreview extends StatelessWidget {
  /// The image path.
  final String imagesDirectoryURL;

  /// The representation id.
  final String representationId;

  /// The GeoGebra id.
  final String geogebraId;

  /// Creates a new representation preview instance.
  const RepresentationPreview({
    @required this.imagesDirectoryURL,
    @required this.representationId,
    @required this.geogebraId,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: AboveWidgetFade(
          above: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(color: Colors.black.withAlpha(175)),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: OutlineButton(
              child: const Text('Voir sur GeoGebra.org'),
              textColor: Colors.white,
              borderSide: const BorderSide(color: Colors.white),
              splashColor: Colors.white24,
              highlightedBorderColor: Colors.white,
              onPressed: () async {
                String url = 'https://www.geogebra.org/m/$geogebraId';
                if (await canLaunch(url)) {
                  await launch(url);
                }
              },
            ),
          ),
          under: Container(
            width: double.infinity,
            color: Colors.black.withAlpha(30),
            child: FadeInImage.memoryNetwork(
              image: '$imagesDirectoryURL/$representationId.png',
              placeholder: kTransparentImage,
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
}
