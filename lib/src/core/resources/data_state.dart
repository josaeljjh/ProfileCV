/// Generic result wrapper returned by repositories and use cases.
abstract class DataState<T> {
  const DataState({this.data, this.error});

  final T? data;
  final Object? error;
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T data) : super(data: data);
}

class DataError<T> extends DataState<T> {
  const DataError(Object error) : super(error: error);
}
