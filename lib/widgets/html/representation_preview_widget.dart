import 'package:bacomathiques/utils/utils.dart';
import 'package:bacomathiques/widgets/fade_stack_widget.dart';
import 'package:flutter/material.dart';

/// Allows to preview representations.
class RepresentationPreviewWidget extends StatelessWidget {
  /// The image URL.
  final String imageUrl;

  /// The GeoGebra id.
  final String geogebraId;

  /// Creates a new representation preview instance.
  const RepresentationPreviewWidget({
    required this.imageUrl,
    required this.geogebraId,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: ButtonAboveWidget(
          url: 'https://www.geogebra.org/m/$geogebraId',
          buttonText: 'Voir sur GeoGebra.org',
          child: FadeInImage.memoryNetwork(
            image: imageUrl,
            placeholder: kTransparentImage,
            fit: BoxFit.cover,
          ),
        ),
      );
}
