import 'package:flutter/material.dart';

class AppBottomSheet extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;

  const AppBottomSheet({super.key, required this.child, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    final Color resolvedColor = backgroundColor ?? Theme.of(context).colorScheme.surface;
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: resolvedColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: child,
        ),
      ),
    );
  }
}
