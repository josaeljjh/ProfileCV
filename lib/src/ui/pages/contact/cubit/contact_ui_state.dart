import 'package:equatable/equatable.dart';

import '../../../../domain/models/contact_model.dart';

class ContactUiState extends Equatable {
  const ContactUiState({
    required this.isLoading,
    required this.hasError,
    required this.contact,
  });

  factory ContactUiState.initial() => const ContactUiState(
        isLoading: true,
        hasError: false,
        contact: null,
      );

  final bool isLoading;
  final bool hasError;
  final ContactModel? contact;

  ContactUiState copyWith({
    bool? isLoading,
    bool? hasError,
    ContactModel? contact,
  }) {
    return ContactUiState(
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      contact: contact ?? this.contact,
    );
  }

  @override
  List<Object?> get props => [isLoading, hasError, contact];
}
