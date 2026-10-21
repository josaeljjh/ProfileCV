import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/di/service_locator.dart';
import 'contact_page_content.dart';
import 'cubit/contact_cubit.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ContactCubit>()..loadData(),
      child: const ContactPageContent(),
    );
  }
}
