import 'package:bacomathiques/model/api/common.dart';
import 'package:bacomathiques/widgets/app_bar/app_bar.dart';
import 'package:bacomathiques/widgets/centered_circular_progress_indicator.dart';
import 'package:bacomathiques/widgets/dialogs/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A scaffold that allows to request remote objects.
abstract class RequestScaffold<R extends APIEndpointResult> extends ConsumerStatefulWidget {
  /// The API endpoint.
  final APIEndpoint<R> endpoint;

  /// Creates a new request scaffold instance.
  const RequestScaffold({
    super.key,
    required this.endpoint,
  });
}

/// The request scaffold state.
abstract class RequestScaffoldState<R extends APIEndpointResult, W extends RequestScaffold<R>> extends ConsumerState<W> {
  /// The current request state.
  AsyncValue<R> _request = const AsyncLoading();

  /// When the request fails.
  String failMessage;

  /// Fail dialog options.
  FailDialogOptions failDialogOptions;

  /// Whether to cache requests.
  bool cacheRequest;

  /// Creates a new loading scaffold instance.
  RequestScaffoldState({
    required this.failMessage,
    this.failDialogOptions = const FailDialogOptions(),
    this.cacheRequest = true,
  });

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        triggerRequest();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final R? currentResult = result;
    Widget body = switch (_request) {
      AsyncData(:final value) => createBody(context, value),
      AsyncError() => createNoObjectBody(context),
      _ => const CenteredCircularProgressIndicator(message: 'Téléchargement…'),
    };

    return Scaffold(
      appBar: currentResult == null
          ? AppBar(
              title: Text(loading ? 'Chargement…' : 'Erreur'),
            )
          : createAppBar(context),
      body: body,
    );
  }

  /// Sets whether the screen is currently loading.
  set loading(bool loading) {
    if (loading) {
      setState(() => _request = const AsyncLoading());
    }
  }

  /// Returns whether the current screen is loading.
  bool get loading => _request is AsyncLoading<R>;

  /// Triggers a request.
  Future<void> triggerRequest() async {
    setState(() => _request = const AsyncLoading());

    try {
      R result = await widget.endpoint.request(cache: cacheRequest);
      this.result = result;
      onSuccess(result);
      return;
    } catch (error, stackTrace) {
      if (mounted) {
        setState(() => _request = AsyncError(error, stackTrace));
      }
    }

    if (mounted) {
      if (failDialogOptions.show) {
        await MessageDialog.show(
          context,
          title: 'Erreur',
          message: '$failMessage\nVeuillez vérifier votre connexion internet et réessayer plus tard.',
          okButtonPressed: () => Navigator.pop(context),
          onCancelled: failDialogOptions.callback ?? () => Navigator.pop(context),
        );
      }
    }
  }

  /// Creates the app bar.
  AppBar? createAppBar(BuildContext context) => BacomathiquesAppBar();

  /// Creates the body with a non-null object.
  Widget createBody(BuildContext context, R result);

  /// Creates the body with a null object.
  Widget createNoObjectBody(BuildContext context) => const SizedBox.shrink();

  /// Returns the current result.
  R? get result => switch (_request) {
    AsyncData(:final value) => value,
    _ => null,
  };

  /// Updates the current result.
  set result(R? result) {
    if (result == null) {
      return;
    }

    void callback() => _request = AsyncData(result);

    if (mounted) {
      setState(callback);
    } else {
      callback();
    }
  }

  /// Triggered when the request has succeeded.
  void onSuccess(R result) {}

  /// Returns the last request error.
  Object? get error => switch (_request) {
    AsyncError(:final error) => error,
    _ => null,
  };
}

/// Options for the fail dialog.
class FailDialogOptions {
  /// Whether to show it.
  final bool show;

  /// The dialog callback.
  final VoidCallback? callback;

  /// Creates a new fail dialog options instance.
  const FailDialogOptions({
    this.show = true,
    this.callback,
  });
}
