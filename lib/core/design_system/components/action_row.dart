import 'package:flutter/material.dart';

import '../spacings.dart';

class ActionRow extends StatelessWidget {
  const ActionRow({
    Key? key,
    this.leading,
    this.trailing,
    this.primary,
    this.secondary,
    this.onTap,
  }) : super(key: key);

  final Widget? leading;
  final Widget? trailing;
  final Widget? primary;
  final Widget? secondary;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(x4),
        child: Row(
          children: [
            if (leading != null) ...[
              leading!,
              const SizedBox(width: x4),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (primary != null) primary!,
                  if (secondary != null) ...[
                    const SizedBox(height: x1),
                    secondary!,
                  ],
                ],
              ),
            ),
            if (trailing != null) ...[
              const SizedBox(width: x4),
              trailing!,
            ],
          ],
        ),
      ),
    );
  }
}
