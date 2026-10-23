import 'package:flutter/material.dart';

import '../../../../config/resources/app_colors.dart';
import '../../../../config/resources/colors.dart';
import '../../../../config/resources/sizes.dart';
import '../../../../domain/models/profile_model.dart';
import '../../../../presentation/widgets/text/generic_label.dart';

/// Compact header shown once the user scrolls Home: a smaller avatar on
/// the left, name and title on the right. Cross-fades in as [ProfileHeader]
/// (the expanded state) fades out, driven by [HomeHeaderDelegate].
class CompactProfileHeader extends StatelessWidget {
  const CompactProfileHeader({Key? key, required this.profile}) : super(key: key);

  final ProfileModel profile;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: avatarRadiusSM,
          backgroundColor: selago,
          backgroundImage: AssetImage(profile.avatarAsset),
        ),
        const SizedBox(width: paddingMD),
        Flexible(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GenericLabel(
                label: profile.name,
                style: TextStyle(fontSize: fontSize16, fontWeight: FontWeight.bold, color: colors.textPrimary),
              ),
              GenericLabel(
                label: profile.title,
                style: TextStyle(fontSize: fontSize12, color: colors.textSecondary),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
