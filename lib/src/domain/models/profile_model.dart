import 'package:equatable/equatable.dart';

class ProfileModel extends Equatable {
  const ProfileModel({
    required this.name,
    required this.title,
    required this.location,
    required this.objective,
    required this.avatarAsset,
  });

  final String name;
  final String title;
  final String location;
  final String objective;
  final String avatarAsset;

  @override
  List<Object?> get props => [name, title, location, objective, avatarAsset];
}
