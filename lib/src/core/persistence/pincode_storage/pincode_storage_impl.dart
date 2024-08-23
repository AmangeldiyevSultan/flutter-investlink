import 'package:investlink/src/core/persistence/pincode_storage/i_pincode_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Persistent storage for pincode.
///
/// Based on SharedPreferences.
class PincodeStorageImpl implements IPincodeStorage {
  /// Create an instance [PincodeStorageImpl].
  PincodeStorageImpl(this._prefs);

  final SharedPreferences _prefs;

  @override
  Future<void> clear() async {
    await _prefs.remove(PincodeStorageKeys.pincode.keyName);
  }

  @override
  bool isKeyExist() {
    return _prefs.containsKey(PincodeStorageKeys.pincode.keyName);
  }

  @override
  Future<String?> getPincode() async {
    final pincode = _prefs.getString(PincodeStorageKeys.pincode.keyName);
    if (pincode?.isEmpty ?? true) return null;
    return pincode;
  }

  @override
  Future<bool> savePincode({required String pincode}) async {
    final isSaved = await _prefs.setString(PincodeStorageKeys.pincode.keyName, pincode);
    return isSaved;
  }
}

/// Keys for [PincodeStorageImpl]
enum PincodeStorageKeys {
  /// @nodoc
  pincode('app_pincode');

  const PincodeStorageKeys(this.keyName);

  /// Key name
  final String keyName;
}
