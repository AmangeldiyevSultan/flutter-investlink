import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:investlink/src/features/{{{path}}}/domain/repositories/i_{{name.snakeCase()}}_repository.dart';

part '{{name.snakeCase()}}_bloc.freezed.dart';

@freezed
class {{name.pascalCase()}}Event with _${{name.pascalCase()}}Event {
  const factory {{name.pascalCase()}}Event.initial() = _Initial{{name.pascalCase()}}Event;
}

@freezed
class {{name.pascalCase()}}State with _${{name.pascalCase()}}State {
  const {{name.pascalCase()}}State._();

  const factory {{name.pascalCase()}}State.idle({
    Object? error,
  }) = _Idle{{name.pascalCase()}}State; 

  /// Processing state.
  const factory {{name.pascalCase()}}State.processing() = _Processing{{name.pascalCase()}}State;


  /// Returns whether the state is processing or not.
  bool get isProcessing => maybeMap(
        orElse: () => false,
        processing: (_) => true,
      );

}

class {{name.pascalCase()}}Bloc extends Bloc<{{name.pascalCase()}}Event, {{name.pascalCase()}}State> {
  {{name.pascalCase()}}Bloc({
    required I{{name.pascalCase()}}Repository {{name.camelCase()}}Repository,
  })  : _{{name.camelCase()}}Repository = {{name.camelCase()}}Repository,
        super(const {{name.pascalCase()}}State.processing());

  final I{{name.pascalCase()}}Repository _{{name.camelCase()}}Repository;

}
