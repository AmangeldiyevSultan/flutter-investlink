import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

final class MockHttpAdapter implements HttpClientAdapter {
  MockHttpAdapter();

  final _responses = <String, ResponseBody Function(RequestOptions options)>{};

  void registerResponse(
    String path,
    ResponseBody Function(RequestOptions options) response, {
    String? query,
  }) {
    _responses['$path/${query ?? ''}'] = response;
  }

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    final req = options.path.replaceAll('?', '');

    if (_responses.containsKey(req)) {
      final response = _responses[req]!;

      return response(options);
    }

    throw Exception('No key was specified');
  }

  @override
  void close({bool force = false}) {}
}
