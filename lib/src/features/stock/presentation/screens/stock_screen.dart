import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:investlink/src/core/assets/colors/color_scheme.dart';
import 'package:investlink/src/core/assets/media_res/svg.dart';
import 'package:investlink/src/core/assets/text/text_extension.dart';
import 'package:investlink/src/features/database/data/repositories/database_repository.dart';
import 'package:investlink/src/features/database/di/database_scope.dart';
import 'package:investlink/src/features/database/presentation/cubit/tickers_cubit.dart';
import 'package:investlink/src/features/snackbar_queue/presentation/snack_message_type.dart';
import 'package:investlink/src/features/snackbar_queue/presentation/snack_queue_provider.dart';
import 'package:investlink/src/features/socket/di/socket_scope.dart';
import 'package:investlink/src/features/socket/presentation/bloc/socket_bloc.dart';
import 'package:investlink/src/features/stock/presentation/widgets/stock_appbar.dart';
import 'package:investlink/src/features/stock/presentation/widgets/stock_dismissable_list_time.dart';
import 'package:investlink/src/features/stock_details/presentation/screens/stock_details_flow.dart';
import 'package:investlink/src/features/stock_search/presentation/screens/stock_search_flow.dart';
import 'package:investlink/src/l10n/app_localizations_x.dart';
import 'package:investlink/src/uikit/buttons/custom_text_button.dart';
import 'package:investlink/src/uikit/loader/stack_loader.dart';
import 'package:investlink/src/uikit/text/default_text.dart';

/// {@template stock_screen.class}
/// StockScreen.
/// {@endtemplate}
class StockScreen extends StatefulWidget {
  /// {@macro stock_screen.class}
  const StockScreen({super.key});

  @override
  State<StockScreen> createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<IDatabaseScope>().tickersCubit.loadFavoriteTickers();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SocketBloc, SocketState>(
      bloc: context.read<ISocketScope>().socketBloc,
      listener: (context, state) {
        state.whenOrNull();
      },
      child: Scaffold(
        backgroundColor: AppColorScheme.of(context).textFieldBackground,
        appBar: StockAppbar(
          onPressed: () => context.push(StockSearchFlow.routePath),
        ),
        body: BlocConsumer<TickersCubit, TickersState>(
          bloc: context.read<IDatabaseScope>().tickersCubit,
          listener: (context, tickersState) {
            tickersState.whenOrNull(
              idle: (tickers, error) {
                if (error != null) {
                  SnackQueueProvider.of(context).addSnack(
                    error.toString(),
                    messageType: SnackMessageType.error,
                  );
                }
                if (tickers.isNotEmpty) {
                  context.read<ISocketScope>().socketBloc.add(
                        SocketEvent.send(
                          tickers: tickers.map((e) => e.ticker!).toList(),
                        ),
                      );
                }
              },
            );
          },
          builder: (context, tickersState) {
            return Column(
              children: [
                const _StockHeader(),
                Divider(
                  color: AppColorScheme.of(context).dividerColor,
                  thickness: .4,
                  height: 1,
                ),
                Expanded(
                  child: LoadingStack(
                    isLoading: tickersState.isProcessing,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: ListView.separated(
                        itemCount: tickersState.tickers.length,
                        itemBuilder: (context, index) {
                          final ticker = tickersState.tickers[index];

                          final todaysChangePerc = ticker.todaysChangePerc;
                          final todaysChange = ticker.todaysChange;
                          final tickerPrevDayO = ticker.prevDay?.o;

                          // Format the percentage value
                          var formattedChangePerc =
                              NumberFormat.decimalPercentPattern(decimalDigits: 2)
                                  .format(todaysChangePerc);

                          // Format the num value
                          var formattedChange = NumberFormat.decimalPatternDigits(decimalDigits: 2)
                              .format(todaysChange);

                          // Format the dollar value
                          final formattedTickerPrevDayO =
                              NumberFormat.simpleCurrency(decimalDigits: 2).format(tickerPrevDayO);

                          // Add the + sign if the value is positive
                          if ((todaysChangePerc ?? 0) > 0) {
                            formattedChangePerc = '+$formattedChangePerc';
                          }

                          // Add the + sign if the value is positive
                          if ((todaysChange ?? 0) > 0) {
                            formattedChange = '+$formattedChange';
                          }

                          return Builder(
                            builder: (context) {
                              return DismissableListTile(
                                ticker: ticker,
                                formattedTickerPrevDayO: formattedTickerPrevDayO,
                                formattedChangePerc: formattedChangePerc,
                                todaysChangePerc: todaysChangePerc,
                                formattedChange: formattedChange,
                                onTap: () => context.push(
                                  StockDetailsFlow.routePath,
                                  extra: ticker,
                                ),
                              );
                            },
                          );
                        },
                        separatorBuilder: (context, index) => Divider(
                          color: AppColorScheme.of(context).secondartTextColor,
                          thickness: .4,
                          height: 1,
                          indent: 5,
                          endIndent: 5,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _StockHeader extends StatelessWidget {
  const _StockHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Gap(10),
        SvgPicture.asset(
          SvgRes.edit,
          height: 15,
        ),
        const Gap(4),
        DText(
          context.l10n.tickerName,
          style: AppTextTheme.of(context).regular12.copyWith(
                color: AppColorScheme.of(context).secondartTextColor,
              ),
        ),
        const Spacer(),
        _changePriceSortingOrder(context),
        _changeChangesPrecSortingOrder(context),
        const Gap(10),
      ],
    );
  }

  CtmTextButton _changeChangesPrecSortingOrder(BuildContext context) {
    return CtmTextButton(
      onPressed: () => context
          .read<IDatabaseScope>()
          .tickersCubit
          .loadFavoriteTickers(tickersSorting: TickersSorting.changes, toggleSortOrder: true),
      child: Row(
        children: [
          DText(
            '${context.l10n.changes}. %/\$',
            style: AppTextTheme.of(context).regular12.copyWith(
                  color: AppColorScheme.of(context).secondartTextColor,
                ),
          ),
          const Gap(5),
          SvgPicture.asset(
            SvgRes.sort,
          ),
        ],
      ),
    );
  }

  CtmTextButton _changePriceSortingOrder(BuildContext context) {
    return CtmTextButton(
      onPressed: () =>
          context.read<IDatabaseScope>().tickersCubit.loadFavoriteTickers(toggleSortOrder: true),
      child: Row(
        children: [
          DText(
            context.l10n.price,
            style: AppTextTheme.of(context).regular12.copyWith(
                  color: AppColorScheme.of(context).secondartTextColor,
                ),
          ),
          const Gap(5),
          SvgPicture.asset(
            SvgRes.sort,
          ),
        ],
      ),
    );
  }
}
