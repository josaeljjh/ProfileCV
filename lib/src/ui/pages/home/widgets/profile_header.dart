import 'package:flutter/material.dart';

import '../../../../config/resources/colors.dart';
import '../../../../config/resources/sizes.dart';
import '../../../../domain/models/profile_model.dart';
import '../../../../presentation/widgets/text/generic_label.dart';

/// Avatar, name, title and location shown in the Home header's expanded
/// (scrolled-to-top) state. The objective paragraph lives in the
/// scrollable body instead, since it's open-ended text that wouldn't fit
/// safely inside the collapsing header's fixed height.
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
              style: const TextStyle(fontSize: fontSize22, fontWeight: FontWeight.bold, color: black),
            ),
            const SizedBox(height: paddingXS),
            GenericLabel(
              label: profile.title,
              lines: null,
              softWrap: true,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: fontSize15, color: slateGray),
            ),
            GenericLabel(
              label: profile.location,
              lines: null,
              softWrap: true,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: fontSize15, color: slateGray),
            ),
          ],
        ),
      ),
    );
  }
}
