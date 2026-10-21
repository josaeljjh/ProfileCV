import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// "Contacto" tab: ways to reach out.
class ContactPage extends StatelessWidget {
  const ContactPage({Key? key}) : super(key: key);

  static const String email = 'tu.correo@example.com';
  static const String phone = '+00 000 000 000';
  static const String linkedin = 'https://linkedin.com/in/tu-usuario';

  Future<void> _open(Uri uri) async {
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contacto')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              leading: const Icon(Icons.email_outlined),
              title: const Text('Correo'),
              subtitle: const Text(email),
              onTap: () => _open(Uri(scheme: 'mailto', path: email)),
            ),
          ),
          const SizedBox(height: 8),
          Card(
            child: ListTile(
              leading: const Icon(Icons.phone_outlined),
              title: const Text('Teléfono'),
              subtitle: const Text(phone),
              onTap: () => _open(Uri(scheme: 'tel', path: phone)),
            ),
          ),
          const SizedBox(height: 8),
          Card(
            child: ListTile(
              leading: const Icon(Icons.link),
              title: const Text('LinkedIn'),
              subtitle: const Text(linkedin),
              onTap: () => _open(Uri.parse(linkedin)),
            ),
          ),
        ],
      ),
    );
  }
}
