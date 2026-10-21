import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../config/resources/sizes.dart';
import 'cubit/contact_cubit.dart';
import 'cubit/contact_ui_state.dart';

/// "Contacto" tab content: ways to reach out.
class ContactPageContent extends StatelessWidget {
  const ContactPageContent({Key? key}) : super(key: key);

  Future<void> _open(Uri uri) async {
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contacto')),
      body: BlocBuilder<ContactCubit, ContactUiState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.hasError || state.contact == null) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('No se pudo cargar el contacto.'),
                  const SizedBox(height: paddingMD),
                  ElevatedButton(
                    onPressed: () => context.read<ContactCubit>().loadData(),
                    child: const Text('Reintentar'),
                  ),
                ],
              ),
            );
          }

          final contact = state.contact!;
          return ListView(
            padding: const EdgeInsets.all(paddingLG),
            children: [
              Card(
                child: ListTile(
                  leading: const Icon(Icons.email_outlined),
                  title: const Text('Correo'),
                  subtitle: Text(contact.email),
                  onTap: () => _open(Uri(scheme: 'mailto', path: contact.email)),
                ),
              ),
              const SizedBox(height: paddingSM),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.phone_outlined),
                  title: const Text('Teléfono'),
                  subtitle: Text(contact.phone),
                  onTap: () => _open(Uri(scheme: 'tel', path: contact.phone.replaceAll(' ', ''))),
                ),
              ),
              const SizedBox(height: paddingSM),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.link),
                  title: const Text('LinkedIn'),
                  subtitle: Text(contact.linkedinDisplay),
                  onTap: () => _open(Uri.parse(contact.linkedinUrl)),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
