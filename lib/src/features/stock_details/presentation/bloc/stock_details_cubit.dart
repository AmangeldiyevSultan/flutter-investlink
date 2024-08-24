import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';
import 'package:investlink/src/core/common/entity/query_params_entity.dart';
import 'package:investlink/src/features/stock_details/domain/entities/ticker_result_entity.dart';
import 'package:investlink/src/features/stock_details/domain/repositories/i_stock_details_repository.dart';
import 'package:investlink/src/features/stock_details/presentation/screens/stock_details_screen.dart';

part 'stock_details_cubit.freezed.dart';

@freezed
class StockDetailsState with _$StockDetailsState {
  const StockDetailsState._();

  const factory StockDetailsState.idle({
    TickerResultEntity? tickerResult,
    DateRange? dateRange,
    Object? error,
  }) = _IdleStockDetailsState;

  /// Processing state.
  const factory StockDetailsState.processing({
    TickerResultEntity? tickerResult,
  }) = _ProcessingStockDetailsState;

  /// Returns whether the state is processing or not.
  bool get isProcessing => maybeMap(
        orElse: () => false,
        processing: (_) => true,
      );
}

class StockDetailsCubit extends Cubit<StockDetailsState> {
  StockDetailsCubit({
    required IStockDetailsRepository stockDetailsRepository,
  })  : _stockDetailsRepository = stockDetailsRepository,
        super(const StockDetailsState.processing());

  // ignore: unused_field
  final IStockDetailsRepository _stockDetailsRepository;

  /// Get stock details.
  Future<void> getStockDetails(DateRange dateRange, String ticker) async {
    emit(const StockDetailsState.processing());

    try {
      late String timePeriod;
// Get the current date
      final now = DateTime.now();
      final dateFormat = DateFormat('yyyy-MM-dd');

      switch (dateRange) {
        case DateRange.day:
          timePeriod =
              '1/hour/${dateFormat.format(now.copyWith(day: now.day - 1))}/${dateFormat.format(now)}';
        case DateRange.month:
          timePeriod =
              '1/day/${dateFormat.format(now.copyWith(month: now.month - 1))}/${dateFormat.format(now)}';
        case DateRange.year:
          timePeriod =
              '1/week/${dateFormat.format(now.copyWith(year: now.year - 1))}/${dateFormat.format(now)}';
      }
      final tickerResult = await _stockDetailsRepository.getStockDetails(
        QueryParamsEntity(
          ticker: ticker,
          timePeriod: timePeriod,
        ),
      );
      emit(StockDetailsState.idle(tickerResult: tickerResult, dateRange: dateRange));
    } catch (e) {
      emit(StockDetailsState.idle(error: e));
    }
  }
}
