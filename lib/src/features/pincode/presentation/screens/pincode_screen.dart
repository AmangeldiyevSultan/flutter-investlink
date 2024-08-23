// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import 'package:investlink/src/core/assets/colors/color_scheme.dart';
import 'package:investlink/src/core/assets/media_res/svg.dart';
import 'package:investlink/src/core/assets/text/text_extension.dart';
import 'package:investlink/src/features/auth/presentation/screens/auth_flow.dart';
import 'package:investlink/src/features/pincode/di/pincode_scope.dart';
import 'package:investlink/src/features/pincode/presentation/cubit/pincode_cubit.dart';
import 'package:investlink/src/features/pincode/presentation/widgets/pincode_keyboard.dart';
import 'package:investlink/src/features/snackbar_queue/presentation/snack_message_type.dart';
import 'package:investlink/src/features/snackbar_queue/presentation/snack_queue_provider.dart';
import 'package:investlink/src/features/stock/presentation/screens/stock_flow.dart';
import 'package:investlink/src/l10n/app_localizations_x.dart';
import 'package:investlink/src/uikit/buttons/custom_text_button.dart';
import 'package:investlink/src/uikit/loader/stack_loader.dart';
import 'package:investlink/src/uikit/text/default_text.dart';

/// {@template pincode_screen.class}
/// PincodeScreen.
/// {@endtemplate}
class PincodeScreen extends StatefulWidget {
  /// {@macro pincode_screen.class}
  const PincodeScreen(this.isPincodeCreationRequired, {super.key});

  final bool isPincodeCreationRequired;

  @override
  State<PincodeScreen> createState() => _PincodeScreenState();
}

class _PincodeScreenState extends State<PincodeScreen> {
  final _pincodeController = TextEditingController();
  bool _isPincodeExist = false;
  bool _shouldConfirmPincode = false;
  String _createdPassword = '';
  bool _isMatch = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<IPincodeScope>().pincodeCubit.checkForPincodeExist();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pincodeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PincodeCubit, PincodeState>(
      bloc: context.read<IPincodeScope>().pincodeCubit,
      listener: _pincodeListener,
      builder: (context, pincodeState) {
        return LoadingStack(
          isLoading: pincodeState.isProcessing,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: SvgPicture.asset(
                    SvgRes.pincode,
                  ),
                ),
                Column(
                  children: [
                    _PincodeHeaderWIdget(
                      widget.isPincodeCreationRequired,
                      _isPincodeExist,
                      _shouldConfirmPincode,
                    ),
                    const Gap(20),
                    PincodeKeyboard(
                      isNotMatched: !_isMatch,
                      pincodeController: _pincodeController,
                      onChangedPin: (pin) {
                        if (pin.length == 4) {
                          if (widget.isPincodeCreationRequired || !_isPincodeExist) {
                            if (_shouldConfirmPincode) {
                              if (_createdPassword == pin) {
                                context.read<IPincodeScope>().pincodeCubit.savePincode(pin);
                              } else {
                                _isMatch = false;
                                _shouldConfirmPincode = false;
                                _createdPassword = '';
                                Future.delayed(const Duration(milliseconds: 100), () {
                                  _pincodeController.clear();
                                  setState(() {});
                                });
                              }
                            } else {
                              _isMatch = true;
                              _shouldConfirmPincode = true;
                              _createdPassword = pin;
                              setState(() {});
                              Future.delayed(const Duration(milliseconds: 300), () {
                                _pincodeController.clear();
                                setState(() {});
                              });
                            }
                          } else {
                            context.read<IPincodeScope>().pincodeCubit.comparePincode(pin);
                          }
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _pincodeListener(_, PincodeState pincodeState) {
    pincodeState.whenOrNull(
      pincodeExist: (isPincodeExist, error) {
        if (error != null) {
          SnackQueueProvider.of(context).addSnack(
            error.toString(),
            messageType: SnackMessageType.error,
          );
          return;
        }
        _isPincodeExist = isPincodeExist;
        setState(() {});
      },
      pincodeMatch: (isMatch, error) {
        if (error != null) {
          SnackQueueProvider.of(context).addSnack(
            error.toString(),
            messageType: SnackMessageType.error,
          );
          return;
        }
        if (isMatch) {
          context.go(StockFlow.routePath);
        } else {
          _isMatch = false;
          Future.delayed(const Duration(milliseconds: 300), () {
            _pincodeController.clear();
            setState(() {});
          });
        }
      },
      pincodeSaved: (error) {
        if (error != null) {
          SnackQueueProvider.of(context).addSnack(
            error.toString(),
            messageType: SnackMessageType.error,
          );
          return;
        }
        context.go(StockFlow.routePath);
      },
    );
  }
}

class _PincodeHeaderWIdget extends StatelessWidget {
  const _PincodeHeaderWIdget(
    this.isPincodeCreationRequired,
    this.isPincodeExist,
    this.shouldConfirmPincode,
  );

  final bool isPincodeCreationRequired;
  final bool isPincodeExist;
  final bool shouldConfirmPincode;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (isPincodeCreationRequired || !isPincodeExist) ...[
              Align(
                alignment: Alignment.centerRight,
                child: CtmTextButton(
                  onPressed: () => context.go(StockFlow.routePath),
                  child: DText(
                    context.l10n.skip,
                    style: AppTextTheme.of(context).medium16.copyWith(
                          color: AppColorScheme.of(context).helpBlue,
                        ),
                  ),
                ),
              ),
            ] else ...[
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: () {
                    context.go(AuthFlow.routePath);
                  },
                  icon: const Icon(
                    Icons.close_outlined,
                    size: 30,
                  ),
                ),
              ),
            ],
            const Gap(180),
            if (isPincodeCreationRequired || !isPincodeExist) ...[
              DText(
                shouldConfirmPincode ? context.l10n.repeatPincodeSetup : context.l10n.pincodeSetup,
                textAlign: TextAlign.end,
                style: AppTextTheme.of(context).medium26,
              ),
              DText(
                shouldConfirmPincode
                    ? context.l10n.reenterPincodeToEnter
                    : context.l10n.createPincodeToEnter,
                textAlign: TextAlign.end,
                style: AppTextTheme.of(context).medium16,
              ),
            ] else ...[
              DText(
                context.l10n.enterPincode,
                textAlign: TextAlign.end,
                style: AppTextTheme.of(context).medium26,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
