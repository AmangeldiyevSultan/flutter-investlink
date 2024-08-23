import 'package:freezed_annotation/freezed_annotation.dart';

part 'last_quote_entity.freezed.dart';

/// {@template last_quote_entity.class}
/// Last quote entity.
/// {@endtemplate}
@freezed
class LastQuoteEntity with _$LastQuoteEntity {
  /// {@macro last_quote_entity.class}
  const factory LastQuoteEntity({
    double? P,
    double? S,
    double? p,
    double? s,
    double? t,
  }) = _LastQuoteEntity;
}
