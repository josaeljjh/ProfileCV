import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../domain/usecases/get_portfolio_use_case.dart';
import 'portfolio_ui_state.dart';

/// [GetPortfolioUseCase] is [NoParams] — portfolio entries are brand/app
/// names, proper nouns with nothing to translate — so unlike Home/Skills/
/// Projects this cubit needs no [Locale] argument (same reasoning as
/// [ContactCubit]).
class PortfolioCubit extends Cubit<PortfolioUiState> {
  PortfolioCubit({required this.getPortfolioUseCase}) : super(PortfolioUiState.initial());

  final GetPortfolioUseCase getPortfolioUseCase;

  Future<void> loadData() async {
    emit(state.copyWith(isLoading: true, hasError: false));

    final result = await getPortfolioUseCase(params: const NoParams());

    if (result is DataSuccess) {
      emit(state.copyWith(isLoading: false, hasError: false, portfolio: result.data));
    } else {
      emit(state.copyWith(isLoading: false, hasError: true));
    }
  }
}
