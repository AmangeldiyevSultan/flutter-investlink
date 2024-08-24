import 'package:json_annotation/json_annotation.dart';

part 'socket_message_model.g.dart';

/// {@template socket_message_model.class}
/// Model for SocketMessageModel.
/// {@endtemplate}
@JsonSerializable()
class SocketMessageModel {
  /// {@macro socket_message_model.class}
  const SocketMessageModel({
    this.ev,
    this.sym,
    this.v,
    this.av,
    this.op,
    this.vw,
    this.o,
    this.c,
    this.h,
    this.l,
    this.a,
    this.z,
    this.s,
    this.e,
  });

  /// Get Model object from json.
  factory SocketMessageModel.fromJson(Map<String, dynamic> json) =>
      _$SocketMessageModelFromJson(json);

  /// SocketMessageModel
  final String? ev;
  final String? sym;
  final String? v;
  final String? av;
  final String? op;
  final String? vw;
  final String? o;
  final String? c;
  final String? h;
  final String? l;
  final String? a;
  final String? z;
  final String? s;
  final String? e;
}
