import 'package:investlink/src/core/config/environment/build_type.dart';
import 'package:investlink/src/core/config/url.dart';

/// {@template environment.class}
/// Environment configuration.
/// Only static configurations that are known at compile time are allowed here.
/// {@endtemplate}
class Environment {
  /// {@macro environment.class}
  const Environment({
    required this.buildType,
  });

  /// Build type.
  final BuildType buildType;

  /// Is this application running in dev mode.
  bool get isDev => buildType == BuildType.dev;

  /// Is this application running in prod mode.
  bool get isProd => buildType == BuildType.prod;
}

/// [BuildType] extension for default url.
extension BuildTypeX on BuildType {
  /// Default url for build type.
  Url get defaultUrl => switch (this) {
        BuildType.dev => Url.dev,
        BuildType.prod => Url.prod,
      };

  /// Default url for build type.
  SocketUrl get defaultSocketUrl => switch (this) {
        BuildType.dev => SocketUrl.dev,
        BuildType.prod => SocketUrl.prod,
      };
}
