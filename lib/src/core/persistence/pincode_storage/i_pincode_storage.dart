/// Persistent storage for theme mode.
abstract interface class IPincodeStorage {
  /// Returns saved pin code.
  Future<String?> getPincode();

  /// Clear pin code
  Future<void> clear();

  /// Check is Pincode Key Exits
  bool isKeyExist();

  /// Save selected pin code.
  Future<bool> savePincode({required String pincode});
}
