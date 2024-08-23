import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:investlink/src/core/assets/colors/color_scheme.dart';
import 'package:investlink/src/core/assets/media_res/svg.dart';
import 'package:investlink/src/core/assets/text/text_extension.dart';
import 'package:investlink/src/l10n/app_localizations_x.dart';
import 'package:investlink/src/uikit/buttons/custom_text_button.dart';
import 'package:investlink/src/uikit/text/default_text.dart';
import 'package:investlink/src/uikit/textfield/custom_text_field.dart';

class StockSearchAppbar extends StatelessWidget implements PreferredSizeWidget {
  const StockSearchAppbar({
    required TextEditingController searchController,
    required FocusNode focusNode,
    required void Function(String)? onChanged,
    required VoidCallback suffixOnPressed,
    super.key,
  })  : _searchController = searchController,
        _focusNode = focusNode,
        _onChanged = onChanged,
        _suffixOnPressed = suffixOnPressed;

  final TextEditingController _searchController;
  final FocusNode _focusNode;
  final void Function(String)? _onChanged;
  final VoidCallback _suffixOnPressed;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColorScheme.of(context).textFieldBackground,
      automaticallyImplyLeading: false,
      title: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: CtmTextField(
          focusNode: _focusNode,
          textAlignVertical: TextAlignVertical.center,
          onChanged: _onChanged,
          prefixIcon: SvgPicture.asset(
            SvgRes.textfieldSearch,
            fit: BoxFit.scaleDown,
          ),
          suffixIcon: _searchController.text.isNotEmpty
              ? GestureDetector(
                  onTap: _suffixOnPressed,
                  child: Container(
                    margin: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: AppColorScheme.of(context).secondartTextColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.close_outlined,
                      size: 12,
                      color: Colors.white,
                    ),
                  ),
                )
              : null,
          controller: _searchController,
          hintText: context.l10n.tickerName,
        ),
      ),
      titleSpacing: 0,
      actions: [
        CtmTextButton(
          onPressed: () => context.pop(),
          child: DText(
            context.l10n.cancel,
            style: AppTextTheme.of(context).regular16.copyWith(
                  color: _searchController.text.trim().isEmpty
                      ? AppColorScheme.of(context).defaultTextColor
                      : AppColorScheme.of(context).greenAccent,
                ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}
