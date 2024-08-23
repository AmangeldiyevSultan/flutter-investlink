import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:investlink/src/core/assets/colors/color_scheme.dart';
import 'package:investlink/src/core/assets/media_res/svg.dart';
import 'package:investlink/src/core/assets/text/text_extension.dart';
import 'package:investlink/src/uikit/text/default_text.dart';

class PincodeKeyboard extends StatefulWidget {
  const PincodeKeyboard({
    required this.pincodeController,
    required this.onChangedPin,
    required this.isNotMatched,
    super.key,
  });

  final TextEditingController pincodeController;

  final bool isNotMatched;

  /// Callback onChange
  final void Function(String pin) onChangedPin;

  @override
  State<PincodeKeyboard> createState() => PincodeKeyboardState();
}

class PincodeKeyboardState extends State<PincodeKeyboard> {
  final ScrollController _listController = ScrollController();

  bool animate = false;

  int currentPinLength() => widget.pincodeController.text.length;

  Future<void> _onPressed(int num) async {
    if (currentPinLength() >= 4) {
      await HapticFeedback.lightImpact();
      return;
    }
    setState(() {
      animate = false;
      widget.pincodeController.text += num.toString();
    });
    widget.onChangedPin(widget.pincodeController.text);
    await Future<void>.delayed(const Duration(milliseconds: 80));
    setState(() {
      animate = true;
    });
    await Future<void>.delayed(Duration.zero);
    _listController.jumpTo(_listController.position.maxScrollExtent);
  }

  void _onRemove() {
    if (currentPinLength() == 0) {
      return;
    }

    setState(
      () => widget.pincodeController.text = widget.pincodeController.text.substring(
        0,
        widget.pincodeController.text.length - 1,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _listController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          SizedBox(
            height: 40,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 1, 30, 0),
              child: ListView.builder(
                controller: _listController,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 4,
                itemBuilder: (context, index) {
                  const size = 20.0;

                  if (index > widget.pincodeController.text.length - 1 && !widget.isNotMatched) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                      child: Container(
                        width: size,
                        height: size,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColorScheme.of(context).textFieldBackground,
                          border: Border.all(
                            color: AppColorScheme.of(context).pincodeBorder,
                          ),
                        ),
                      ),
                    );
                  }

                  if (index > widget.pincodeController.text.length - 1 && widget.isNotMatched) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                      child: Container(
                        width: size,
                        height: size,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColorScheme.of(context).textFieldBackground,
                          border: Border.all(
                            color: AppColorScheme.of(context).danger,
                          ),
                        ),
                      ),
                    );
                  }

                  if (widget.isNotMatched) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                      child: AnimatedContainer(
                        width: animate ? size : size + 5,
                        height: !animate ? size : size + 5,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColorScheme.of(context).failureRed,
                        ),
                      ),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                      child: AnimatedContainer(
                        width: animate ? size : size + 5,
                        height: !animate ? size : size + 5,
                        duration: const Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColorScheme.of(context).successGreen,
                          border: Border.all(
                            color: AppColorScheme.of(context).successGreen,
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
          const Spacer(),
          Container(
            alignment: Alignment.bottomCenter,
            height: 350,
            decoration: BoxDecoration(
              color: AppColorScheme.of(context).textFieldBackground,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  mainAxisSpacing: 15,
                  childAspectRatio: 2,
                  physics: const NeverScrollableScrollPhysics(),
                  children: List.generate(
                    growable: false,
                    12,
                    (index) {
                      const marginRight = 15.0;
                      const marginLeft = 15.0;
                      const marginBottom = 1.0;

                      if (index == 9) {
                        return const SizedBox.shrink();
                      } else if (index == 10) {
                        index = 0;
                      } else if (index == 11) {
                        return Container(
                          margin: const EdgeInsets.only(
                            left: marginLeft,
                            right: marginRight,
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              surfaceTintColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              backgroundColor: Colors.transparent,
                              side: BorderSide.none,
                              foregroundColor: AppColorScheme.of(context).warningYellow,
                              shape: const CircleBorder(),
                            ),
                            onPressed: _onRemove,
                            // child: deleteIconImage
                            child: SvgPicture.asset(SvgRes.back),
                          ),
                        );
                      } else {
                        index++;
                      }
                      return Container(
                        margin: const EdgeInsets.only(
                          left: marginLeft,
                          right: marginRight,
                          bottom: marginBottom,
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            surfaceTintColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            backgroundColor: Colors.transparent,
                            foregroundColor: AppColorScheme.of(context).warningYellow,
                            side: BorderSide.none,
                            shape: const CircleBorder(),
                          ),
                          onPressed: () => _onPressed(index),
                          child: DText(
                            '$index',
                            style: AppTextTheme.of(context).medium26.copyWith(
                                  color: AppColorScheme.of(context).defaultTextColor,
                                  // style: widget.numbersStyle,
                                ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
