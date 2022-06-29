import 'package:flutter/material.dart';

class PaginatorButton extends StatelessWidget {
  const PaginatorButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.tooltip,
  });

  final void Function()? onPressed;
  final Widget icon;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: icon,
      tooltip: tooltip,
      splashRadius: 20,
      color: Theme.of(context).textTheme.caption?.color,
    );
  }
}
