import 'package:flutter/material.dart';

import '../../../../config/resources/sizes.dart';
import '../../../../config/theme/app_theme.dart';
import '../../../../presentation/widgets/text/generic_label.dart';

/// A section heading on Home. When [onTap] is given it renders as a
/// tappable shortcut (chevron affordance + InkWell) to that section's own
/// screen; otherwise it's a plain heading (used for "Experiencia", which
/// has no destination screen).
class SectionTitle extends StatelessWidget {
  const SectionTitle({Key? key, required this.text, this.onTap}) : super(key: key);

  final String text;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final title = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GenericLabel(
          label: text,
          style: TextStyle(fontSize: fontSize20, fontWeight: FontWeight.bold, color: context.colors.textPrimary),
        ),
        if (onTap != null) ...[
          const SizedBox(width: paddingXS),
          Icon(Icons.chevron_right, color: context.colors.iconMuted),
        ],
      ],
    );

    if (onTap == null) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: paddingXL),
        child: title,
      );
    }

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: paddingXL, vertical: paddingXS),
        child: title,
      ),
    );
  }
}
