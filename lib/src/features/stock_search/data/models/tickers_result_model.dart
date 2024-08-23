import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:investlink/src/features/stock_search/data/models/tickers_model.dart';

part 'tickers_result_model.g.dart';

/// {@template TickersResultModel.class}
/// Model for TickersResultModel.
/// {@endtemplate}
@JsonSerializable()
class TickersResultModel {
  /// {@macro tickers_result_model.class}
  const TickersResultModel({
    this.tickers,
    this.status,
    this.requestId,
    this.count,
  });

  /// Get Model object from json.
  factory TickersResultModel.fromJson(Map<String, dynamic> json) =>
      _$TickersResultModelFromJson(json);

  /// TickersResultModel
  final List<TickersModel>? tickers;
  final String? status;
  @JsonKey(name: 'request_id')
  final String? requestId;
  final int? count;

  /// Convert a Model object to json.
  Map<String, dynamic> toJson() => _$TickersResultModelToJson(this);
}
