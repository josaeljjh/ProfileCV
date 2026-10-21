import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../config/resources/colors.dart';

class _Project {
  const _Project(this.name, this.description, this.tech, this.url);

  final String name;
  final String description;
  final String tech;
  final String url;
}

/// "Proyectos" tab: personal GitHub repositories.
class ProjectsPage extends StatelessWidget {
  const ProjectsPage({Key? key}) : super(key: key);

  static const List<_Project> _projects = [
    _Project(
      'ProfileCV',
      'App de currículum hecha en Flutter (este proyecto).',
      'Flutter · Dart',
      'https://github.com/josaeljjh/ProfileCV',
    ),
    _Project(
      'PokeAppFlutter',
      'Pokédex construida con Flutter y arquitectura limpia.',
      'Flutter · Dart',
      'https://github.com/josaeljjh/PokeAppFlutter',
    ),
    _Project(
      'PokeApp2',
      'Pokédex nativa para Android con Kotlin, MVVM y Koin.',
      'Kotlin · Android',
      'https://github.com/josaeljjh/PokeApp2',
    ),
    _Project(
      'PokeAppIOS',
      'Pokédex nativa para iOS con Swift.',
      'Swift · iOS',
      'https://github.com/josaeljjh/PokeAppIOS',
    ),
    _Project(
      'ListDataBinding',
      'Ejemplo de listas en Android usando Data Binding.',
      'Kotlin · Android',
      'https://github.com/josaeljjh/ListDataBinding',
    ),
    _Project(
      'ListSwiftMVVM',
      'Ejemplo de listas en iOS con arquitectura MVVM.',
      'Swift · iOS',
      'https://github.com/josaeljjh/ListSwiftMVVM',
    ),
  ];

  Future<void> _open(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Proyectos')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _projects.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final project = _projects[index];
          return Card(
            child: ListTile(
              leading: const Icon(Icons.code, color: niagara),
              title: Text(
                project.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text(project.description),
                  const SizedBox(height: 4),
                  Text(
                    project.tech,
                    style: const TextStyle(fontSize: 12, color: slateGray),
                  ),
                ],
              ),
              trailing: const Icon(Icons.open_in_new, size: 18, color: slateGray),
              isThreeLine: true,
              onTap: () => _open(project.url),
            ),
          );
        },
      ),
    );
  }
}
