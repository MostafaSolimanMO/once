import 'package:flutter/widgets.dart';

abstract class OnceBuilder {
  /// The main build method for OnceWidget methods
  static FutureBuilder<Widget?> build(
    Future<Widget?>? future,
    Widget? Function()? fallback,
  ) {
    return FutureBuilder<Widget?>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return snapshot.data!;
        } else {
          return fallback?.call() ?? const SizedBox.shrink();
        }
      },
    );
  }
}
