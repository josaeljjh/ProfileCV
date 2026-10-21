import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization/localization.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../config/resources/sizes.dart';
import '../../../core/resources/translations_constant.dart';
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
      appBar: AppBar(title: Text(CONTACT_TITLE.i18n())),
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
                  Text(ERROR_CONTACT.i18n()),
                  const SizedBox(height: paddingMD),
                  ElevatedButton(
                    onPressed: () => context.read<ContactCubit>().loadData(),
                    child: Text(ACTION_RETRY.i18n()),
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
                  title: Text(CONTACT_EMAIL_LABEL.i18n()),
                  subtitle: Text(contact.email),
                  onTap: () => _open(Uri(scheme: 'mailto', path: contact.email)),
                ),
              ),
              const SizedBox(height: paddingSM),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.phone_outlined),
                  title: Text(CONTACT_PHONE_LABEL.i18n()),
                  subtitle: Text(contact.phone),
                  onTap: () => _open(Uri(scheme: 'tel', path: contact.phone.replaceAll(' ', ''))),
                ),
              ),
              const SizedBox(height: paddingSM),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.link),
                  title: Text(CONTACT_LINKEDIN_LABEL.i18n()),
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
