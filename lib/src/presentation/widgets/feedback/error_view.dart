import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

import '../../../config/resources/colors.dart';
import '../../../config/resources/sizes.dart';
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
              style: const TextStyle(fontSize: fontSize14, color: black),
            ),
            const SizedBox(height: paddingMD),
            ElevatedButton(
              onPressed: onRetry,
              child: GenericLabel(
                label: ACTION_RETRY.i18n(),
                style: const TextStyle(fontSize: fontSize14, color: white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
