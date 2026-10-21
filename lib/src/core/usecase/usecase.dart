import 'dart:ui' show Locale;

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

/// Params for use cases whose result depends on the current locale (e.g.
/// returning Spanish or English CV prose). Only `dart:ui`'s [Locale] is
/// imported here, not Flutter's widgets/material layer, to keep this file
/// as framework-light as a Clean Architecture core layer reasonably can be
/// while still using Flutter's own locale type instead of reinventing one.
class LocaleParams extends Equatable {
  const LocaleParams(this.locale);

  final Locale locale;

  @override
  List<Object?> get props => [locale];
}
