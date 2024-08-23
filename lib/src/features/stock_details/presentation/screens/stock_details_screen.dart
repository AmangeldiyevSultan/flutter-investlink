import 'dart:math' as math;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:investlink/src/core/assets/colors/color_scheme.dart';
import 'package:investlink/src/core/assets/text/text_extension.dart';
import 'package:investlink/src/features/snackbar_queue/presentation/snack_message_type.dart';
import 'package:investlink/src/features/snackbar_queue/presentation/snack_queue_provider.dart';
import 'package:investlink/src/features/stock_details/di/stock_details_scope.dart';
import 'package:investlink/src/features/stock_details/presentation/cubit/stock_details_cubit.dart';
import 'package:investlink/src/features/stock_details/presentation/widgets/stock_detail_appbar.dart';
import 'package:investlink/src/features/stock_search/domain/entities/tickers_entity.dart';
import 'package:investlink/src/l10n/app_localizations_x.dart';
import 'package:investlink/src/uikit/buttons/custom_text_button.dart';
import 'package:investlink/src/uikit/loader/stack_loader.dart';
import 'package:investlink/src/uikit/text/default_text.dart';

enum DateRange { day, month, year }

/// {@template stock_details_screen.class}
/// StockDetailsScreen.
/// {@endtemplate}
class StockDetailsScreen extends StatefulWidget {
  /// {@macro stock_details_screen.class}
  const StockDetailsScreen({required this.ticker, super.key});

  final TickersEntity ticker;

  @override
  State<StockDetailsScreen> createState() => _StockDetailsScreenState();
}

class _StockDetailsScreenState extends State<StockDetailsScreen> {
  late TickersEntity _ticker;
  late String _formattedTickerPrevDayO;
  var _dateRange = DateRange.day;

  @override
  void initState() {
    super.initState();

    _ticker = widget.ticker;

    context.read<IStockDetailsScope>().stockDetailsCubit.getStockDetails(
          _dateRange,
          _ticker.ticker!,
        );

    final tickerPrevDayO = widget.ticker.prevDay?.o;

    // Format the dollar value
    _formattedTickerPrevDayO = NumberFormat.simpleCurrency(decimalDigits: 2).format(tickerPrevDayO);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<StockDetailsCubit, StockDetailsState>(
      bloc: context.read<IStockDetailsScope>().stockDetailsCubit,
      listener: (context, stockDetailsState) {
        stockDetailsState.whenOrNull(
          idle: (tickerResult, dateRange, error) {
            if (error != null) {
              SnackQueueProvider.of(context).addSnack(
                error.toString(),
                messageType: SnackMessageType.error,
              );
            }
          },
        );
      },
      child: BlocBuilder<StockDetailsCubit, StockDetailsState>(
        bloc: context.read<IStockDetailsScope>().stockDetailsCubit,
        builder: (context, stockDetailsState) {
          return LoadingStack(
            isLoading: stockDetailsState.isProcessing,
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: StockDetailAppbar(
                ticker: _ticker,
                formattedTickerPrevDayO: _formattedTickerPrevDayO,
              ),
              body: SafeArea(
                child: Column(
                  children: [
                    Divider(
                      color: AppColorScheme.of(context).dividerColor,
                      thickness: 10,
                      height: 10,
                    ),
                    _dateHeader(context),
                    Divider(
                      color: AppColorScheme.of(context).dividerColor,
                      thickness: 10,
                      height: 10,
                    ),
                    SizedBox(
                      height: 200,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: LineChart(
                          _mainData(stockDetailsState),
                        ),
                      ),
                    ),
                    Divider(
                      color: AppColorScheme.of(context).dividerColor,
                      thickness: 10,
                      height: 10,
                    ),
                    const Gap(10),
                    _FooterOfStockDetails(ticker: _ticker),
                    const Gap(10),
                    Divider(
                      color: AppColorScheme.of(context).dividerColor,
                      thickness: 10,
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  LineChartData _mainData(StockDetailsState stockDetailsState) {
    //  'results' is the list containing the data points

    // Extract 'o' values and create FlSpot list
    final spots = <FlSpot>[];
    for (var i = 0; i < (stockDetailsState.tickerResult?.results?.length ?? 0); i++) {
      final openValue = double.parse(stockDetailsState.tickerResult!.results![i].o.toString());
      spots.add(FlSpot(i.toDouble(), openValue));
    }

// Find min and max Y values for chart scaling
    var minY = spots.isNotEmpty ? spots[0].y : 0;
    var maxY = spots.isNotEmpty ? spots[0].y : 0;
    for (final spot in spots) {
      minY = math.min(minY, spot.y);
      maxY = math.max(maxY, spot.y);
    }

    return LineChartData(
      gridData: FlGridData(
        drawVerticalLine: false,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: AppColorScheme.of(context).dividerColor,
          );
        },
      ),
      titlesData: const FlTitlesData(
        rightTitles: AxisTitles(),
        topTitles: AxisTitles(),
        bottomTitles: AxisTitles(),
        leftTitles: AxisTitles(),
      ),
      borderData: FlBorderData(show: false),
      minX: 0,
      maxX: (stockDetailsState.tickerResult?.results?.length ?? 0 - 1).toDouble(),
      minY: minY * 0.9, // Add some padding
      maxY: maxY * 1.1, // Add some padding
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          color: AppColorScheme.of(context).greenAccent,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
        ),
      ],
    );
  }

  Padding _dateHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _DetailCtmTextBtn(
            onPressed: () {
              context.read<IStockDetailsScope>().stockDetailsCubit.getStockDetails(
                    DateRange.day,
                    _ticker.ticker!,
                  );
              _dateRange = DateRange.day;
              setState(() {});
            },
            isActive: _dateRange == DateRange.day,
            text: context.l10n.day,
          ),
          _DetailCtmTextBtn(
            onPressed: () {
              context.read<IStockDetailsScope>().stockDetailsCubit.getStockDetails(
                    DateRange.month,
                    _ticker.ticker!,
                  );
              _dateRange = DateRange.month;
              setState(() {});
            },
            isActive: _dateRange == DateRange.month,
            text: context.l10n.month,
          ),
          _DetailCtmTextBtn(
            onPressed: () {
              context.read<IStockDetailsScope>().stockDetailsCubit.getStockDetails(
                    DateRange.year,
                    _ticker.ticker!,
                  );
              _dateRange = DateRange.year;
              setState(() {});
            },
            isActive: _dateRange == DateRange.year,
            text: context.l10n.year,
          ),
        ],
      ),
    );
  }
}

class _FooterOfStockDetails extends StatelessWidget {
  const _FooterOfStockDetails({
    required this.ticker,
  });

  final TickersEntity ticker;

  @override
  Widget build(BuildContext context) {
    final tickerPrevDayH = ticker.prevDay?.h;

    // Format the dollar value
    final formattedTickerPrevDayH =
        NumberFormat.simpleCurrency(decimalDigits: 2).format(tickerPrevDayH);

    final tickerPrevDayL = ticker.prevDay?.l;

    // Format the dollar value
    final formattedTickerPrevDayL =
        NumberFormat.simpleCurrency(decimalDigits: 2).format(tickerPrevDayL);

    final tickerPrevDayO = ticker.prevDay?.l;

    // Format the dollar value
    final formattedTickerPrevDayO =
        NumberFormat.simpleCurrency(decimalDigits: 2).format(tickerPrevDayO);

    final tickerPrevDayC = ticker.prevDay?.l;

    // Format the dollar value
    final formattedTickerPrevDayC =
        NumberFormat.simpleCurrency(decimalDigits: 2).format(tickerPrevDayC);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    DText(
                      '${context.l10n.high.toUpperCase()}:',
                      style: AppTextTheme.of(context).regular14.copyWith(
                            color: AppColorScheme.of(context).secondartTextColor,
                          ),
                    ),
                    const Gap(20),
                    DText(
                      formattedTickerPrevDayH,
                      style: AppTextTheme.of(context).medium14.copyWith(
                            color: AppColorScheme.of(context).defaultTextColor,
                          ),
                    ),
                  ],
                ),
                const Gap(20),
                Row(
                  children: [
                    DText(
                      '${context.l10n.low.toUpperCase()}: ',
                      style: AppTextTheme.of(context).regular14.copyWith(
                            color: AppColorScheme.of(context).secondartTextColor,
                          ),
                    ),
                    const Gap(20),
                    DText(
                      formattedTickerPrevDayL,
                      style: AppTextTheme.of(context).medium14.copyWith(
                            color: AppColorScheme.of(context).defaultTextColor,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    DText(
                      '${context.l10n.open.toUpperCase()}: ',
                      style: AppTextTheme.of(context).regular14.copyWith(
                            color: AppColorScheme.of(context).secondartTextColor,
                          ),
                    ),
                    const Gap(20),
                    DText(
                      formattedTickerPrevDayO,
                      style: AppTextTheme.of(context).medium14.copyWith(
                            color: AppColorScheme.of(context).defaultTextColor,
                          ),
                    ),
                  ],
                ),
                const Gap(20),
                Row(
                  children: [
                    DText(
                      '${context.l10n.close.toUpperCase()}:',
                      style: AppTextTheme.of(context).regular14.copyWith(
                            color: AppColorScheme.of(context).secondartTextColor,
                          ),
                    ),
                    const Gap(20),
                    DText(
                      formattedTickerPrevDayC,
                      style: AppTextTheme.of(context).medium14.copyWith(
                            color: AppColorScheme.of(context).defaultTextColor,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _DetailCtmTextBtn extends StatelessWidget {
  const _DetailCtmTextBtn({
    required this.onPressed,
    required this.isActive,
    required this.text,
  });

  final VoidCallback onPressed;
  final bool isActive;
  final String text;

  @override
  Widget build(BuildContext context) {
    return CtmTextButton(
      onPressed: onPressed,
      backgroundColor: isActive ? AppColorScheme.of(context).greenAccent : Colors.transparent,
      minimumSize: const Size(70, 25),
      maximumSize: const Size(100, 25),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      child: DText(
        text.toUpperCase(),
        style: AppTextTheme.of(context).medium14.copyWith(
              color: isActive ? null : AppColorScheme.of(context).defaultTextColor,
            ),
      ),
    );
  }
}
