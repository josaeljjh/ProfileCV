import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:localization/localization.dart';
import 'package:mocktail/mocktail.dart';
import 'package:profile_cv/src/domain/models/contact_model.dart';
import 'package:profile_cv/src/ui/pages/contact/contact_page_content.dart';
import 'package:profile_cv/src/ui/pages/contact/cubit/contact_cubit.dart';
import 'package:profile_cv/src/ui/pages/contact/cubit/contact_ui_state.dart';

class MockContactCubit extends MockCubit<ContactUiState> implements ContactCubit {}

void main() {
  late MockContactCubit mockCubit;

  setUpAll(() {
    LocalJsonLocalization.delegate.directories = ['res/i18n'];
  });

  setUp(() {
    mockCubit = MockContactCubit();
  });

  Widget buildTestWidget(ContactUiState state) {
    when(() => mockCubit.state).thenReturn(state);
    when(() => mockCubit.stream).thenAnswer((_) => Stream.value(state));
    return MaterialApp(
      locale: const Locale('es', 'ES'),
      supportedLocales: const [Locale('es', 'ES'), Locale('en', 'US')],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        LocalJsonLocalization.delegate,
      ],
      home: BlocProvider<ContactCubit>.value(
        value: mockCubit,
        child: const ContactPageContent(),
      ),
    );
  }

  group('ContactPageContent', () {
    testWidgets('shows a loading indicator when loading', (tester) async {
      await tester.pumpWidget(buildTestWidget(ContactUiState.initial()));
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('shows a retry button on error', (tester) async {
      final errorState = ContactUiState.initial().copyWith(isLoading: false, hasError: true);
      await tester.pumpWidget(buildTestWidget(errorState));
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('Reintentar'), findsOneWidget);
    });

    testWidgets('shows contact info when loaded', (tester) async {
      const loadedState = ContactUiState(
        isLoading: false,
        hasError: false,
        contact: ContactModel(
          email: 'test@example.com',
          phone: '+1 234',
          linkedinDisplay: 'linkedin.com/in/test',
          linkedinUrl: 'https://linkedin.com/in/test',
          githubUrl: 'https://github.com/test',
          cvDownloadUrl: 'https://example.com/cv.pdf',
        ),
      );
      await tester.pumpWidget(buildTestWidget(loadedState));
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('test@example.com'), findsOneWidget);
      expect(find.text('+1 234'), findsOneWidget);
      expect(find.text('linkedin.com/in/test'), findsOneWidget);
    });
  });
}
