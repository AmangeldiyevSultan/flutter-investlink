import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:investlink/src/core/assets/colors/color_scheme.dart';
import 'package:investlink/src/core/assets/text/text_extension.dart';
import 'package:investlink/src/features/stock_search/domain/entities/tickers_entity.dart';
import 'package:investlink/src/l10n/app_localizations_x.dart';
import 'package:investlink/src/uikit/text/default_text.dart';

class StockDetailAppbar extends StatelessWidget implements PreferredSizeWidget {
  const StockDetailAppbar({
    required TickersEntity ticker,
    required String formattedTickerPrevDayO,
    super.key,
  })  : _ticker = ticker,
        _formattedTickerPrevDayO = formattedTickerPrevDayO;

  final TickersEntity _ticker;
  final String _formattedTickerPrevDayO;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      scrolledUnderElevation: 0,
      titleSpacing: 0,
      leading: IconButton(
        onPressed: () => context.pop(),
        icon: const Icon(
          Icons.arrow_back_ios_new_outlined,
        ),
      ),
      title: DText(
        _ticker.ticker ?? '',
        style: AppTextTheme.of(context).medium26,
      ),
      bottom: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '${context.l10n.price.toUpperCase()}:  ',
                style: AppTextTheme.of(context).medium14.copyWith(
                      color: AppColorScheme.of(context).secondartTextColor,
                    ),
              ),
              TextSpan(
                text: _formattedTickerPrevDayO,
                style: AppTextTheme.of(context).medium26.copyWith(
                      color: AppColorScheme.of(context).defaultTextColor,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size(AppBar().preferredSize.width * 2, AppBar().preferredSize.height * 2);
}
