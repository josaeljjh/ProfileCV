import 'package:equatable/equatable.dart';

class ContactModel extends Equatable {
  const ContactModel({
    required this.email,
    required this.phone,
    required this.linkedinDisplay,
    required this.linkedinUrl,
  });

  final String email;
  final String phone;
  final String linkedinDisplay;
  final String linkedinUrl;

  @override
  List<Object?> get props => [email, phone, linkedinDisplay, linkedinUrl];
}
