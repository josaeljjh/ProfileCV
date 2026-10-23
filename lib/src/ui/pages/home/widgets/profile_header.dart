import 'package:flutter/material.dart';

import '../../../../config/resources/app_colors.dart';
import '../../../../config/resources/colors.dart';
import '../../../../config/resources/sizes.dart';
import '../../../../domain/models/profile_model.dart';
import '../../../../presentation/widgets/text/generic_label.dart';

/// Avatar, name, title, location and objective paragraph shown in the
/// Home header's expanded (scrolled-to-top) state. Laid out inside an
/// OverflowBox by HomeHeaderDelegate, so it's safe for this to exceed the
/// header's collapsed height - it's already fading to opacity 0 by the
/// time that happens.
class ProfileHeader extends StatelessWidget {
  const ProfileHeader({Key? key, required this.profile}) : super(key: key);

  final ProfileModel profile;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: paddingXXL),
        child: Column(
          children: [
            CircleAvatar(
              radius: avatarRadiusLG,
              backgroundColor: selago,
              backgroundImage: AssetImage(profile.avatarAsset),
            ),
            const SizedBox(height: paddingLG),
            GenericLabel(
              label: profile.name,
              lines: null,
              softWrap: true,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: fontSize22, fontWeight: FontWeight.bold, color: colors.textPrimary),
            ),
            const SizedBox(height: paddingXS),
            GenericLabel(
              label: profile.title,
              lines: null,
              softWrap: true,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: fontSize15, color: colors.textSecondary),
            ),
            GenericLabel(
              label: profile.location,
              lines: null,
              softWrap: true,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: fontSize15, color: colors.textSecondary),
            ),
            const SizedBox(height: paddingLG),
            GenericLabel(
              label: profile.objective,
              lines: 5,
              softWrap: true,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: fontSize13, color: colors.textTertiary),
            ),
          ],
        ),
      ),
    );
  }
}
