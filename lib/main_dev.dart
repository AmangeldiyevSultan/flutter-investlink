import 'dart:async';

import 'package:investlink/runner.dart';
import 'package:investlink/src/core/common/utils/logger/logger.dart';
import 'package:investlink/src/core/config/environment/build_type.dart';
import 'package:investlink/src/core/config/environment/environment.dart';

/// Main entry point of app.
void main() {
  logger.runLogging(() {
    runZonedGuarded(
      () => run(const Environment(buildType: BuildType.dev)).ignore(),
      logger.logZoneError,
    );

    const LogOptions();
  });
}
