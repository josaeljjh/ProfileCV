import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

import '../../../config/resources/sizes.dart';
import '../../../config/theme/app_theme.dart';
import '../../../core/resources/translations_constant.dart';
import '../text/generic_label.dart';

/// Shared error state for every screen's BlocBuilder: a message plus a
/// retry action.
class ErrorView extends StatelessWidget {
  const ErrorView({Key? key, required this.message, required this.onRetry}) : super(key: key);

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(paddingXL),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GenericLabel(
              label: message,
              lines: null,
              softWrap: true,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: fontSize14, color: context.colors.textPrimary),
            ),
            const SizedBox(height: paddingMD),
            ElevatedButton(
              onPressed: onRetry,
              // No explicit color: it inherits the button's own foreground
              // color (colorScheme.onPrimary), which is already legible
              // against the button's background in both themes.
              child: GenericLabel(
                label: ACTION_RETRY.i18n(),
                style: const TextStyle(fontSize: fontSize14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
