import 'package:flutter/material.dart';

/// Shared loading state for every screen's BlocBuilder: a centered spinner.
class LoadingView extends StatelessWidget {
  const LoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}
