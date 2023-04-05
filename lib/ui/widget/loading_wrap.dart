import 'package:flutter/material.dart';

class LoadingWrap extends StatelessWidget {
  const LoadingWrap({
    Key? key,
    required this.child,
    required this.visible,
  }) : super(key: key);

  final Widget child;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Opacity(opacity: visible ? 0.5 : 1.0, child: child),
        Visibility(
          visible: visible,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ],
    );
  }
}
