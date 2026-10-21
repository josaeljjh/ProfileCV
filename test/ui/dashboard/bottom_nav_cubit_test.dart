import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:profile_cv/src/ui/pages/dashboard/cubit/bottom_nav_cubit.dart';

void main() {
  late BottomNavCubit cubit;

  setUp(() => cubit = BottomNavCubit());
  tearDown(() => cubit.close());

  group('BottomNavCubit', () {
    test('initial state is 0', () {
      expect(cubit.state, 0);
    });

    blocTest<BottomNavCubit, int>(
      'emits the new index when updateIndex is called',
      build: () => cubit,
      act: (cubit) => cubit.updateIndex(2),
      expect: () => [2],
    );
  });
}
