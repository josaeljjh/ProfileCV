import 'package:equatable/equatable.dart';

/// Base contract every use case implements: one business operation, taking
/// optional [Params] and returning a [Type] (typically a `DataState<T>`).
abstract class UseCase<Type, Params> {
  Future<Type> call({Params? params});
}

/// Marker params for use cases that don't need any input.
class NoParams extends Equatable {
  const NoParams();

  @override
  List<Object> get props => [];
}
