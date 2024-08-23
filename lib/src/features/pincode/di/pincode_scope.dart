import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investlink/src/core/common/utils/disposable_object/disposable_object.dart';
import 'package:investlink/src/core/common/utils/disposable_object/i_disposable_object.dart';
import 'package:investlink/src/core/persistence/pincode_storage/pincode_storage_impl.dart';
import 'package:investlink/src/features/app/di/app_scope.dart';
import 'package:investlink/src/features/pincode/data/repositories/pincode_repository.dart';
import 'package:investlink/src/features/pincode/presentation/cubit/pincode_cubit.dart';

/// {@template pincode_scope.class}
/// Implementation of [IPincodeScope].
/// {@endtemplate}
final class PincodeScope extends DisposableObject implements IPincodeScope {
  /// {@macro pincode_scope.class}
  /// Factory constructor for [IPincodeScope].
  PincodeScope({
    required PincodeCubit pincodeCubit,
  }) : _pincodeCubit = pincodeCubit;

  /// Factory constructor for [IPincodeScope].
  factory PincodeScope.create(BuildContext context) {
    final scope = context.read<IAppScope>();

    final pincodeRepository = PincodeRepository(
      PincodeStorageImpl(scope.sharedPreferences),
    );

    return PincodeScope(
      pincodeCubit: PincodeCubit(
        pincodeRepository: pincodeRepository,
      ),
    );
  }

  /// Private field to hold the bloc instance.
  final PincodeCubit _pincodeCubit;

  @override
  late final PincodeCubit pincodeCubit = _pincodeCubit;
}

/// Scope dependencies of the Pincode feature.
abstract interface class IPincodeScope implements IDisposableObject {
  /// PincodeCubit.
  PincodeCubit get pincodeCubit;
}
