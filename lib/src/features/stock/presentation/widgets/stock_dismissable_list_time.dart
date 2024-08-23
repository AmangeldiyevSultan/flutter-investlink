import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:investlink/src/core/assets/colors/color_scheme.dart';
import 'package:investlink/src/core/assets/media_res/svg.dart';
import 'package:investlink/src/core/assets/text/text_extension.dart';
import 'package:investlink/src/features/database/di/database_scope.dart';
import 'package:investlink/src/features/stock_search/domain/entities/tickers_entity.dart';
import 'package:investlink/src/l10n/app_localizations_x.dart';
import 'package:investlink/src/uikit/text/default_text.dart';

class DismissableListTile extends StatelessWidget {
  const DismissableListTile({
    required this.ticker,
    required this.formattedTickerPrevDayO,
    required this.formattedChangePerc,
    required this.todaysChangePerc,
    required this.formattedChange,
    super.key,
  });

  final TickersEntity ticker;
  final String formattedTickerPrevDayO;
  final String formattedChangePerc;
  final double? todaysChangePerc;
  final String formattedChange;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(ticker.ticker!),
      direction: DismissDirection.endToStart,
      background: ColoredBox(
        color: AppColorScheme.of(context).failureRed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SvgPicture.asset(
              SvgRes.trash,
              fit: BoxFit.scaleDown,
            ),
            const Gap(10),
            DText(
              context.l10n.delete,
              style: AppTextTheme.of(context).regular16.copyWith(color: Colors.white),
            ),
            const Gap(25),
          ],
        ),
      ),
      onDismissed: (direction) {
        context.read<IDatabaseScope>().tickersCubit.removeFromFavorites(ticker.ticker!);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: DText(
                ticker.ticker ?? '',
                style: AppTextTheme.of(context).bold14,
              ),
            ),
            Row(
              children: [
                DText(
                  formattedTickerPrevDayO,
                  style: AppTextTheme.of(context).bold14.copyWith(
                        overflow: TextOverflow.ellipsis,
                      ),
                ),
                const Gap(10),
                SizedBox(
                  width: 70,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      DText(
                        formattedChangePerc,
                        style: AppTextTheme.of(context).bold14.copyWith(
                              overflow: TextOverflow.ellipsis,
                              color: todaysChangePerc == null
                                  ? AppColorScheme.of(context).greenAccent
                                  : todaysChangePerc! >= 0
                                      ? AppColorScheme.of(context).greenAccent
                                      : AppColorScheme.of(context).failureRed,
                            ),
                      ),
                      DText(
                        formattedChange,
                        style: AppTextTheme.of(context).regular10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
