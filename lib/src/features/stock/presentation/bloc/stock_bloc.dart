import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:investlink/src/features/stock/data/repositories/stock_repository.dart';

part 'stock_bloc.freezed.dart';

@freezed
class StockEvent with _$StockEvent {
  const factory StockEvent.initial() = _InitialStockEvent;
}

@freezed
class StockState with _$StockState {
  const StockState._();

  const factory StockState.idle({
    Object? error,
  }) = _IdleStockState;

  /// Processing state.
  const factory StockState.processing() = _ProcessingStockState;

  /// Returns whether the state is processing or not.
  bool get isProcessing => maybeMap(
        orElse: () => false,
        processing: (_) => true,
      );
}

class StockBloc extends Bloc<StockEvent, StockState> {
  StockBloc({
    required StockRepository stockRepository,
  })  : _stockRepository = stockRepository,
        super(const StockState.processing());

  // ignore: unused_field
  final StockRepository _stockRepository;
}
