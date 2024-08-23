import 'package:investlink/src/core/architecture/data/converter/converter.dart';
import 'package:investlink/src/features/stock_details/data/models/ticker_result_model.dart';
import 'package:investlink/src/features/stock_details/domain/entities/ticker_data_entity.dart';
import 'package:investlink/src/features/stock_details/domain/entities/ticker_result_entity.dart';

/// Converter for [TickerResultEntity].
typedef ITickerDetailResultConverter = Converter<TickerResultEntity, TickerResultModel>;

/// {@template ticker_result_converter.class}
/// Implementation of [ITickerDetailResultConverter].
/// {@endtemplate}
final class TickerDetailResultConverter extends ITickerDetailResultConverter {
  /// {@macro ticker_result_converter.class}
  const TickerDetailResultConverter();

  @override
  TickerResultEntity convert(TickerResultModel input) {
    return TickerResultEntity(
      ticker: input.ticker,
      queryCount: input.queryCount,
      resultsCount: input.resultsCount,
      adjusted: input.adjusted,
      results: input.results
          ?.map(
            (e) => TickerDataEntity(
              v: e.v,
              vw: e.vw,
              o: e.o,
              c: e.c,
              h: e.h,
              l: e.l,
              t: e.t,
              n: e.n,
            ),
          )
          .toList(),
    );
  }
}
