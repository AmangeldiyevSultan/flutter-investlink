import 'package:investlink/src/core/persistence/pincode_storage/i_pincode_storage.dart';
import 'package:investlink/src/features/pincode/domain/repositories/i_pincode_repository.dart';

/// {@template pincode_repository.class}
/// Implementation of [IPincodeRepository].
/// {@endtemplate}
final class PincodeRepository implements IPincodeRepository {
  /// {@macro pincode_repository.class}
  const PincodeRepository(this._pincodeStorage);

  final IPincodeStorage _pincodeStorage;

  @override
  Future<void> clear() async {
    await _pincodeStorage.clear();
  }

  @override
  Future<String?> getPincode() async {
    return _pincodeStorage.getPincode();
  }

  @override
  bool isKeyExist() {
    return _pincodeStorage.isKeyExist();
  }

  @override
  Future<bool> savePincode({required String pincode}) async {
    return _pincodeStorage.savePincode(pincode: pincode);
  }
}
