import 'package:equatable/equatable.dart';

class SkillGroupModel extends Equatable {
  const SkillGroupModel({required this.category, required this.skills});

  final String category;
  final List<String> skills;

  @override
  List<Object?> get props => [category, skills];
}
