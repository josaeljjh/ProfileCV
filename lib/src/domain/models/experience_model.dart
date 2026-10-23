import 'package:equatable/equatable.dart';

class RoleModel extends Equatable {
  const RoleModel({
    required this.title,
    required this.period,
    required this.duration,
    required this.skills,
    this.employmentType,
  });

  final String title;
  final String? employmentType;
  final String period;
  final String duration;
  final String skills;

  @override
  List<Object?> get props => [title, employmentType, period, duration, skills];
}

/// [logoColorKey] is a plain string identifier resolved to a Color only in
/// the UI layer, keeping the domain layer Flutter-free. [logoAsset], when
/// set, is the company's real logo image and takes priority over the
/// initials+color placeholder.
class CompanyExperienceModel extends Equatable {
  const CompanyExperienceModel({
    required this.company,
    required this.logoInitials,
    required this.logoColorKey,
    required this.roles,
    this.totalDuration,
    this.logoAsset,
  });

  final String company;
  final String logoInitials;
  final String logoColorKey;
  final String? logoAsset;
  final String? totalDuration;
  final List<RoleModel> roles;

  @override
  List<Object?> get props => [company, logoInitials, logoColorKey, logoAsset, totalDuration, roles];
}
