import 'package:investlink/src/core/config/url.dart';

/// {@template app_config.class}
/// Application configuration.
/// {@endtemplate}
class AppConfig {
  /// {@macro app_config.class}
  const AppConfig({
    required this.url,
    required this.socketUrl,
    this.proxyUrl,
  });

  /// Server url.
  final Url url;

  /// Server url.
  final SocketUrl socketUrl;

  /// Proxy url.
  final String? proxyUrl;
}
