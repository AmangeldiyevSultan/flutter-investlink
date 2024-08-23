import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:investlink/src/core/common/utils/logger/logger.dart';
import 'package:investlink/src/features/stock_search/data/repositories/stock_search_repository.dart';
import 'package:investlink/src/features/stock_search/domain/entities/tickers_result_entity.dart';
import 'package:rxdart/transformers.dart';

part 'stock_search_bloc.freezed.dart';

@freezed
class StockSearchEvent with _$StockSearchEvent {
  const factory StockSearchEvent.search(String query) = _SearchStockSearchEvent;

  const factory StockSearchEvent.clear() = _ClearStockSearchEvent;
}

@freezed
class StockSearchState with _$StockSearchState {
  const StockSearchState._();

  /// Initial state.
  const factory StockSearchState.initial({
    TickersResultEntity? tickersResult,
  }) = _InitialStockSearchState;

  /// Idle state.
  const factory StockSearchState.idle({
    TickersResultEntity? tickersResult,
    Object? error,
  }) = _IdleStockSearchState;

  /// Processing state.
  const factory StockSearchState.processing({
    TickersResultEntity? tickersResult,
  }) = _ProcessingStockSearchState;

  /// Returns whether the state is processing or not.
  bool get isProcessing => maybeMap(
        orElse: () => false,
        processing: (_) => true,
      );
}

EventTransformer<Event> debounceSequential<Event>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).asyncExpand(mapper);
}

class StockSearchBloc extends Bloc<StockSearchEvent, StockSearchState> {
  StockSearchBloc({
    required StockSearchRepository stockSearchRepository,
  })  : _stockSearchRepository = stockSearchRepository,
        super(const StockSearchState.initial()) {
    on<_SearchStockSearchEvent>(
      _tickersHandler,
      transformer: debounceSequential(const Duration(milliseconds: 300)),
    );
    on<_ClearStockSearchEvent>(_clearTickersHandler);
  }

  final StockSearchRepository _stockSearchRepository;

  Future<void> _clearTickersHandler(
    _ClearStockSearchEvent event,
    Emitter<StockSearchState> emit,
  ) async =>
      emit(const StockSearchState.idle());

  Future<void> _tickersHandler(
    _SearchStockSearchEvent event,
    Emitter<StockSearchState> emit,
  ) async {
    if (event.query.isNotEmpty) {
      emit(StockSearchState.processing(tickersResult: state.tickersResult));

      try {
        final tickersResult = await _stockSearchRepository.getStocks(event.query);

        emit(StockSearchState.idle(tickersResult: tickersResult));
      } catch (e, stackTrace) {
        logger.error('Error while fetching tickers: $e, $stackTrace');
        emit(StockSearchState.idle(error: e.toString()));
      }
    }
  }
}
