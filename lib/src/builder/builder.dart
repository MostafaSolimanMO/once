import 'package:flutter/widgets.dart';

abstract class OnceBuilder {
  /// The main build method for OnceWidget methods
  static Widget build(
    Key? key,
    Future<Widget?>? future,
    Widget? Function()? fallback,
  ) {
    return OnceWidget(
      key: key,
      future: future,
      fallback: fallback,
    );
  }
}

class OnceWidget extends StatefulWidget {
  final Future<Widget?>? future;
  final Widget? Function()? fallback;

  const OnceWidget({
    super.key,
    this.future,
    this.fallback,
  });

  @override
  State<OnceWidget> createState() => _OnceWidgetState();
}

class _OnceWidgetState extends State<OnceWidget> {
  late final Future<Widget?>? future;
  late final Widget? Function()? fallback;

  @override
  void initState() {
    future = widget.future;
    fallback = widget.fallback;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget?>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox.shrink();
        } else if (snapshot.hasData) {
          return snapshot.data!;
        } else {
          return widget.fallback?.call() ?? const SizedBox.shrink();
        }
      },
    );
  }
}
