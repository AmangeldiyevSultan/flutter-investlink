import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:investlink/src/features/pincode/data/repositories/pincode_repository.dart';

part 'pincode_cubit.freezed.dart';

@Freezed(equal: false)
class PincodeState with _$PincodeState {
  const PincodeState._();

  const factory PincodeState.pincodeSaved({
    Object? error,
  }) = _PincodeSavedState;

  const factory PincodeState.pincodeMatch({
    @Default(false) bool isMatch,
    Object? error,
  }) = _PincodeMatchState;

  const factory PincodeState.pincodeExist({
    @Default(false) bool isPincodeExist,
    Object? error,
  }) = _CheckIsPincodeExistState;

  /// Processing state.
  const factory PincodeState.processing() = _ProcessingPincodeState;

  /// Returns whether the state is processing or not.
  bool get isProcessing => maybeMap(
        orElse: () => false,
        processing: (_) => true,
      );
}

class PincodeCubit extends Cubit<PincodeState> {
  PincodeCubit({
    required PincodeRepository pincodeRepository,
  })  : _pincodeRepository = pincodeRepository,
        super(const PincodeState.processing());

  final PincodeRepository _pincodeRepository;

  Future<void> comparePincode(String pincode) async {
    emit(const PincodeState.processing());
    try {
      final savedPincode = await _pincodeRepository.getPincode();

      emit(PincodeState.pincodeMatch(isMatch: pincode == savedPincode));
    } catch (e) {
      emit(PincodeState.pincodeMatch(error: e));
    }
  }

  Future<void> savePincode(String pincode) async {
    emit(const PincodeState.processing());
    try {
      await _pincodeRepository.savePincode(pincode: pincode);

      emit(const PincodeState.pincodeSaved());
    } catch (e) {
      emit(PincodeState.pincodeSaved(error: e));
    }
  }

  void checkForPincodeExist() {
    try {
      final isKeyExist = _pincodeRepository.isKeyExist();
      emit(PincodeState.pincodeExist(isPincodeExist: isKeyExist));
    } catch (e) {
      emit(PincodeState.pincodeExist(error: e));
    }
  }
}
