import 'package:flutter/material.dart';

class FavoriteButtonIcon extends StatelessWidget {
  const FavoriteButtonIcon(
    this.iconData, {
    super.key,
    required this.onPressed,
  });

  final IconData iconData;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: onPressed, icon: Icon(iconData));
  }
}
