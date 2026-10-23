import 'package:flutter/material.dart';

import '../../../../config/resources/colors.dart';
import '../../../../config/resources/sizes.dart';
import '../../../../config/theme/app_theme.dart';
import '../../../../domain/models/profile_model.dart';
import '../../../../presentation/widgets/text/generic_label.dart';

/// Avatar, name, title, location and objective paragraph at the top of Home.
class ProfileHeader extends StatelessWidget {
  const ProfileHeader({Key? key, required this.profile}) : super(key: key);

  final ProfileModel profile;

  @override
  Widget build(BuildContext context) {
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
              style: TextStyle(fontSize: fontSize22, fontWeight: FontWeight.bold, color: context.colors.textPrimary),
            ),
            const SizedBox(height: paddingXS),
            GenericLabel(
              label: profile.title,
              lines: null,
              softWrap: true,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: fontSize15, color: context.colors.textSecondary),
            ),
            GenericLabel(
              label: profile.location,
              lines: null,
              softWrap: true,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: fontSize15, color: context.colors.textSecondary),
            ),
            const SizedBox(height: paddingLG),
            GenericLabel(
              label: profile.objective,
              lines: null,
              softWrap: true,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: fontSize13, color: context.colors.textTertiary),
            ),
          ],
        ),
      ),
    );
  }
}
