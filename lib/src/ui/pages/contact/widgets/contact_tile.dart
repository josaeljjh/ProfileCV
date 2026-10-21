import 'package:flutter/material.dart';

import '../../../../presentation/widgets/text/generic_label.dart';

/// One contact method row (email, phone or LinkedIn all share this shape).
class ContactTile extends StatelessWidget {
  const ContactTile({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  }) : super(key: key);

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: GenericLabel(label: title, style: const TextStyle()),
        subtitle: GenericLabel(label: subtitle, lines: null, softWrap: true, style: const TextStyle()),
        onTap: onTap,
      ),
    );
  }
}
