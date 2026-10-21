import 'package:equatable/equatable.dart';

import '../../../../domain/models/skill_group_model.dart';

class SkillsUiState extends Equatable {
  const SkillsUiState({
    required this.isLoading,
    required this.hasError,
    required this.skillGroups,
  });

  factory SkillsUiState.initial() => const SkillsUiState(
        isLoading: true,
        hasError: false,
        skillGroups: [],
      );

  final bool isLoading;
  final bool hasError;
  final List<SkillGroupModel> skillGroups;

  SkillsUiState copyWith({
    bool? isLoading,
    bool? hasError,
    List<SkillGroupModel>? skillGroups,
  }) {
    return SkillsUiState(
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      skillGroups: skillGroups ?? this.skillGroups,
    );
  }

  @override
  List<Object?> get props => [isLoading, hasError, skillGroups];
}
