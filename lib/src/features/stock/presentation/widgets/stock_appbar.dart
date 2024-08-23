import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:investlink/src/core/assets/colors/color_scheme.dart';
import 'package:investlink/src/core/assets/media_res/svg.dart';
import 'package:investlink/src/core/assets/text/text_extension.dart';
import 'package:investlink/src/l10n/app_localizations_x.dart';
import 'package:investlink/src/uikit/text/default_text.dart';

class StockAppbar extends StatelessWidget implements PreferredSizeWidget {
  const StockAppbar({required this.onPressed, super.key});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColorScheme.of(context).textFieldBackground,
      title: DText(
        context.l10n.stock,
        style: AppTextTheme.of(context).regular26,
      ),
      actions: [
        IconButton(
          onPressed: onPressed,
          icon: SvgPicture.asset(
            SvgRes.search,
            height: 25,
          ),
        ),
        const Gap(10),
      ],
      scrolledUnderElevation: 0,
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}
