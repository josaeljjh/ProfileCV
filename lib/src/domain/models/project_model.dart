import 'package:equatable/equatable.dart';

class ProjectModel extends Equatable {
  const ProjectModel({
    required this.name,
    required this.description,
    required this.tech,
    required this.url,
  });

  final String name;
  final String description;
  final String tech;
  final String url;

  @override
  List<Object?> get props => [name, description, tech, url];
}
