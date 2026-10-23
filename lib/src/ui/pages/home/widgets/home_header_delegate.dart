import 'package:flutter/material.dart';

import '../../../../config/resources/colors.dart';
import '../../../../config/resources/sizes.dart';
import '../../../../domain/models/profile_model.dart';
import 'compact_profile_header.dart';
import 'profile_header.dart';

/// Drives Home's collapsing header by hand: at the top of the scroll view
/// only [ProfileHeader] (the big, expanded view) is visible; as the user
/// scrolls, it cross-fades into [CompactProfileHeader] (small avatar +
/// name/title). Implemented as a manual [SliverPersistentHeaderDelegate]
/// instead of [FlexibleSpaceBar] because FlexibleSpaceBar's built-in title
/// fade is tuned for a plain Text title and doesn't fully hide a custom
/// widget (like CompactProfileHeader's Row) at full expansion - it showed
/// both headers at once instead of starting on just the big one.
class HomeHeaderDelegate extends SliverPersistentHeaderDelegate {
  HomeHeaderDelegate({required this.profile, required this.topPadding});

  final ProfileModel profile;
  final double topPadding;

  @override
  double get minExtent => collapsedHeaderHeight + topPadding;

  @override
  double get maxExtent => expandedHeaderHeight + topPadding;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final range = maxExtent - minExtent;
    final fraction = range > 0 ? (shrinkOffset / range).clamp(0.0, 1.0) : 1.0;

    return Container(
      color: white,
      padding: EdgeInsets.only(top: topPadding),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Opacity(
            opacity: 1 - fraction,
            child: IgnorePointer(
              ignoring: fraction > 0.5,
              child: ProfileHeader(profile: profile),
            ),
          ),
          Positioned(
            left: paddingLG,
            right: paddingLG,
            bottom: paddingMD,
            child: Opacity(
              opacity: fraction,
              child: IgnorePointer(
                ignoring: fraction < 0.5,
                child: CompactProfileHeader(profile: profile),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(covariant HomeHeaderDelegate oldDelegate) {
    return oldDelegate.profile != profile || oldDelegate.topPadding != topPadding;
  }
}
