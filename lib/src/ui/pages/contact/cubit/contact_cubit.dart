import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../domain/usecases/get_contact_use_case.dart';
import 'contact_ui_state.dart';

class ContactCubit extends Cubit<ContactUiState> {
  ContactCubit({required this.getContactUseCase}) : super(ContactUiState.initial());

  final GetContactUseCase getContactUseCase;

  Future<void> loadData() async {
    emit(state.copyWith(isLoading: true, hasError: false));

    final result = await getContactUseCase(params: const NoParams());

    if (result is DataSuccess) {
      emit(state.copyWith(isLoading: false, hasError: false, contact: result.data));
    } else {
      emit(state.copyWith(isLoading: false, hasError: true));
    }
  }
}
