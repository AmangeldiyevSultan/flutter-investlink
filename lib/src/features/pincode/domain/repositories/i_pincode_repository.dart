import 'package:investlink/src/features/pincode/data/repositories/pincode_repository.dart';

/// Interface for [PincodeRepository].
abstract interface class IPincodeRepository {
  /// Returns saved pin code.
  Future<String?> getPincode();

  /// Clear pin code
  Future<void> clear();

  /// Check is Pincode Key Exits
  bool isKeyExist();

  /// Save selected pin code.
  Future<bool> savePincode({required String pincode});
}
