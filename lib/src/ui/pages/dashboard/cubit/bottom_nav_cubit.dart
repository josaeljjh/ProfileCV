import 'package:flutter_bloc/flutter_bloc.dart';

/// Tracks which tab is selected in [DashBoardScreen]'s bottom navigation.
class BottomNavCubit extends Cubit<int> {
  BottomNavCubit() : super(0);

  void updateIndex(int index) => emit(index);
}
