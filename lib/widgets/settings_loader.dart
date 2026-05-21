import 'package:bacomathiques/model/settings.dart';
import 'package:bacomathiques/widgets/centered_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Builds a widget once settings are loaded.
class SettingsLoader extends ConsumerWidget {
  /// The widget builder.
  final Widget Function(BuildContext context, AppSettings settings) builder;

  /// Message shown while settings are loading.
  final String? loadingMessage;

  /// Creates a settings loader.
  const SettingsLoader({
    super.key,
    required this.builder,
    this.loadingMessage,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) => ref
      .watch(settingsModelProvider)
      .when(
        data: (settings) => builder(context, settings),
        loading: () => CenteredCircularProgressIndicator(message: loadingMessage),
        error: (error, stackTrace) => const Center(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              'Impossible de charger les préférences.',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
}
