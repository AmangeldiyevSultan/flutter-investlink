import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:investlink/src/features/database/data/repositories/database_repository.dart';
import 'package:investlink/src/features/database/domain/repositories/i_database_repository.dart';
import 'package:investlink/src/features/stock_search/domain/entities/tickers_entity.dart';

part 'tickers_cubit.freezed.dart';

@freezed
class TickersState with _$TickersState {
  const TickersState._();

  const factory TickersState.initial({
    @Default([]) List<TickersEntity> tickers,
  }) = _InitialState;
  const factory TickersState.processing({
    @Default([]) List<TickersEntity> tickers,
  }) = _ProcessingState;
  const factory TickersState.idle({
    @Default([]) List<TickersEntity> tickers,
    Object? error,
  }) = IdleState;

  /// Returns whether the state is processing or not.
  bool get isProcessing => maybeMap(
        orElse: () => false,
        processing: (_) => true,
      );
}

class TickersCubit extends Cubit<TickersState> {
  TickersCubit({
    required DatabaseRepository databaseRepository,
  })  : _databaseRepository = databaseRepository,
        super(const TickersState.initial()) {
    _listenToTickersStream();
  }

  final IDatabaseRepository _databaseRepository;

  var _sortOrder = SortOrder.ascending;

  void _listenToTickersStream() {
    emit(const TickersState.processing());
    _databaseRepository.tickersStream.listen(
      (tickers) {
        emit(TickersState.idle(tickers: tickers));
      },
      onError: (Object? error) {
        emit(
          TickersState.idle(error: error),
        );
      },
    );
  }

  Future<void> loadFavoriteTickers({
    TickersSorting tickersSorting = TickersSorting.price,
    bool toggleSortOrder = false,
  }) async {
    emit(TickersState.processing(tickers: state.tickers));
    try {
      if (toggleSortOrder) {
        if (_sortOrder == SortOrder.ascending) {
          _sortOrder = SortOrder.descending;
        } else {
          _sortOrder = SortOrder.ascending;
        }
      }

      final initialTickers = await _databaseRepository.loadFavouriteTickers(
        tickersSorting,
        _sortOrder,
      );
      emit(TickersState.idle(tickers: initialTickers));
    } catch (e) {
      emit(TickersState.idle(tickers: state.tickers, error: e));
    }
  }

  Future<void> addToFavorites(TickersEntity ticker) async {
    try {
      await _databaseRepository.addTickerToFavorites(ticker);
    } catch (e) {
      emit(TickersState.idle(tickers: state.tickers, error: e));
    }
  }

  Future<void> removeFromFavorites(String symbol) async {
    try {
      await _databaseRepository.removeTickerFromFavorites(symbol);
    } catch (e) {
      emit(TickersState.idle(tickers: state.tickers, error: e));
    }
  }
}
