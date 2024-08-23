import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:investlink/src/features/stock_search/data/models/day_model.dart';
import 'package:investlink/src/features/stock_search/data/models/last_quote_model.dart';
import 'package:investlink/src/features/stock_search/data/models/last_trade_model.dart';
import 'package:investlink/src/features/stock_search/data/models/min_model.dart';
import 'package:investlink/src/features/stock_search/data/models/prevday_model.dart';

part 'tickers_model.g.dart';

/// {@template TickersModel.class}
/// Model for TickersModel.
/// {@endtemplate}
@JsonSerializable()
@HiveType(typeId: 0)
class TickersModel {
  /// {@macro tickers_model.class}
  const TickersModel({
    this.ticker,
    this.todaysChangePerc,
    this.todaysChange,
    this.updated,
    this.day,
    this.lastQuote,
    this.lastTrade,
    this.min,
    this.prevDay,
  });

  /// Get Model object from json.
  factory TickersModel.fromJson(Map<String, dynamic> json) => _$TickersModelFromJson(json);

  /// TickersModel
  @HiveField(0)
  final String? ticker;
  @HiveField(1)
  final double? todaysChangePerc;
  @HiveField(2)
  final double? todaysChange;
  @HiveField(3)
  final double? updated;
  @HiveField(4)
  final DayModel? day;
  @HiveField(5)
  final LastQuoteModel? lastQuote;
  @HiveField(6)
  final LastTradeModel? lastTrade;
  @HiveField(7)
  final MinModel? min;
  @HiveField(8)
  final PrevdayModel? prevDay;

  /// Convert a Model object to json.
  Map<String, dynamic> toJson() => _$TickersModelToJson(this);
}
