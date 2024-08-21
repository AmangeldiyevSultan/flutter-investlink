/// {@template converter.class}
/// Base class for converters.
/// {@endtemplate}
abstract base class Converter<TResult, TFrom> {
  /// {@macro converter.class}
  const Converter();

  /// Convert TFrom to TResult.
  TResult convert(TFrom input);
}
