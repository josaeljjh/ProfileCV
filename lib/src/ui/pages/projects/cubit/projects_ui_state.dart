import 'package:equatable/equatable.dart';

import '../../../../domain/models/project_model.dart';

class ProjectsUiState extends Equatable {
  const ProjectsUiState({
    required this.isLoading,
    required this.hasError,
    required this.projects,
  });

  factory ProjectsUiState.initial() => const ProjectsUiState(
        isLoading: true,
        hasError: false,
        projects: [],
      );

  final bool isLoading;
  final bool hasError;
  final List<ProjectModel> projects;

  ProjectsUiState copyWith({
    bool? isLoading,
    bool? hasError,
    List<ProjectModel>? projects,
  }) {
    return ProjectsUiState(
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      projects: projects ?? this.projects,
    );
  }

  @override
  List<Object?> get props => [isLoading, hasError, projects];
}
