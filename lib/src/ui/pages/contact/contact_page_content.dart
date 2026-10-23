import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization/localization.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../config/resources/sizes.dart';
import '../../../core/resources/translations_constant.dart';
import '../../../presentation/widgets/feedback/error_view.dart';
import '../../../presentation/widgets/feedback/loading_view.dart';
import '../../../presentation/widgets/text/generic_label.dart';
import 'cubit/contact_cubit.dart';
import 'cubit/contact_ui_state.dart';
import 'widgets/contact_tile.dart';

/// "Contacto" tab content: ways to reach out.
class ContactPageContent extends StatelessWidget {
  const ContactPageContent({Key? key}) : super(key: key);

  static Future<void> _open(Uri uri) async {
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // An explicit empty TextStyle forces GenericLabel to inherit the
      // ambient AppBar title style instead of its own (unsuitable) default.
      appBar: AppBar(title: GenericLabel(label: CONTACT_TITLE.i18n(), style: const TextStyle())),
      body: BlocBuilder<ContactCubit, ContactUiState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const LoadingView();
          }
          if (state.hasError || state.contact == null) {
            return ErrorView(
              message: ERROR_CONTACT.i18n(),
              onRetry: () => context.read<ContactCubit>().loadData(),
            );
          }

          final contact = state.contact!;
          return ListView(
            padding: const EdgeInsets.all(paddingLG),
            children: [
              ContactTile(
                icon: Icons.email_outlined,
                title: CONTACT_EMAIL_LABEL.i18n(),
                subtitle: contact.email,
                onTap: () => _open(Uri(scheme: 'mailto', path: contact.email)),
              ),
              const SizedBox(height: paddingSM),
              ContactTile(
                icon: Icons.phone_outlined,
                title: CONTACT_PHONE_LABEL.i18n(),
                subtitle: contact.phone,
                onTap: () => _open(Uri(scheme: 'tel', path: contact.phone.replaceAll(' ', ''))),
              ),
              const SizedBox(height: paddingSM),
              ContactTile(
                icon: Icons.link,
                title: CONTACT_LINKEDIN_LABEL.i18n(),
                subtitle: contact.linkedinDisplay,
                onTap: () => _open(Uri.parse(contact.linkedinUrl)),
              ),
              const SizedBox(height: paddingSM),
              ContactTile(
                icon: Icons.code,
                title: CONTACT_GITHUB_LABEL.i18n(),
                subtitle: contact.githubUrl.replaceFirst('https://', ''),
                onTap: () => _open(Uri.parse(contact.githubUrl)),
              ),
              const SizedBox(height: paddingSM),
              ContactTile(
                icon: Icons.picture_as_pdf_outlined,
                title: CONTACT_DOWNLOAD_CV_LABEL.i18n(),
                subtitle: CONTACT_DOWNLOAD_CV_SUBTITLE.i18n(),
                onTap: () => _open(Uri.parse(contact.cvDownloadUrl)),
              ),
            ],
          );
        },
      ),
    );
  }
}
