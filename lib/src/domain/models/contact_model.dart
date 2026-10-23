import 'package:equatable/equatable.dart';

class ContactModel extends Equatable {
  const ContactModel({
    required this.email,
    required this.phone,
    required this.linkedinDisplay,
    required this.linkedinUrl,
    required this.githubUrl,
    required this.cvDownloadUrl,
  });

  final String email;
  final String phone;
  final String linkedinDisplay;
  final String linkedinUrl;
  final String githubUrl;
  final String cvDownloadUrl;

  @override
  List<Object?> get props => [email, phone, linkedinDisplay, linkedinUrl, githubUrl, cvDownloadUrl];
}
