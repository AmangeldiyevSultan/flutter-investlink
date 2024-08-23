import 'package:investlink/src/features/database/presentation/cubit/tickers_cubit.dart';

/// {@template database_scope.class}
/// Implementation of [IDatabaseScope].
/// {@endtemplate}
final class DatabaseScope implements IDatabaseScope {
  /// {@macro database_scope.class}
  /// Factory constructor for [IDatabaseScope].
  const DatabaseScope({
    required this.tickersCubit,
  });

  @override
  final TickersCubit tickersCubit;
}

/// Scope dependencies of the DatabaseScope feature.
abstract interface class IDatabaseScope {
  TickersCubit get tickersCubit;
}
