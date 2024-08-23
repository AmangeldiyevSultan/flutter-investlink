import 'package:investlink/src/features/stock_details/data/models/ticker_data_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ticker_result_model.g.dart';

/// {@template ticker_result_model.class}
/// Model for TickerResultModel.
/// {@endtemplate}
@JsonSerializable()
class TickerResultModel {
  /// {@macro ticker_result_model.class}
  const TickerResultModel({
    this.ticker,
    this.queryCount,
    this.resultsCount,
    this.adjusted,
    this.results,
  });

  /// Get Model object from json.
  factory TickerResultModel.fromJson(Map<String, dynamic> json) =>
      _$TickerResultModelFromJson(json);

  /// TickerResultModel
  final String? ticker;
  final int? queryCount;
  final int? resultsCount;
  final bool? adjusted;
  final List<TickerDataModel>? results;

  /// Convert a Model object to json.
  Map<String, dynamic> toJson() => _$TickerResultModelToJson(this);
}
