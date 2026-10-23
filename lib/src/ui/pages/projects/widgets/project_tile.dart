import 'package:flutter/material.dart';

import '../../../../config/resources/colors.dart';
import '../../../../config/resources/sizes.dart';
import '../../../../domain/models/project_model.dart';
import '../../../../presentation/widgets/text/generic_label.dart';

/// One GitHub repository entry.
class ProjectTile extends StatelessWidget {
  const ProjectTile({Key? key, required this.project, required this.onTap}) : super(key: key);

  final ProjectModel project;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.code_rounded, color: niagara),
        title: GenericLabel(
          label: project.name,
          lines: null,
          softWrap: true,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: paddingXS),
            GenericLabel(label: project.description, lines: null, softWrap: true, style: const TextStyle()),
            const SizedBox(height: paddingXS),
            GenericLabel(
              label: project.tech,
              lines: null,
              softWrap: true,
              style: const TextStyle(fontSize: fontSize12, color: slateGray),
            ),
          ],
        ),
        trailing: const Icon(Icons.open_in_new_rounded, size: iconSizeMD, color: slateGray),
        isThreeLine: true,
        onTap: onTap,
      ),
    );
  }
}
