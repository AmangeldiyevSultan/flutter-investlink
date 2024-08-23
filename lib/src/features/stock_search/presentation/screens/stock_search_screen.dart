import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:investlink/src/core/assets/colors/color_scheme.dart';
import 'package:investlink/src/core/assets/text/text_extension.dart';
import 'package:investlink/src/features/database/di/database_scope.dart';
import 'package:investlink/src/features/database/presentation/cubit/tickers_cubit.dart';
import 'package:investlink/src/features/snackbar_queue/presentation/snack_message_type.dart';
import 'package:investlink/src/features/snackbar_queue/presentation/snack_queue_provider.dart';
import 'package:investlink/src/features/stock_search/di/stock_search_scope.dart';
import 'package:investlink/src/features/stock_search/presentation/bloc/stock_search_bloc.dart';
import 'package:investlink/src/features/stock_search/presentation/widgets/stock_search_appbar.dart';
import 'package:investlink/src/uikit/buttons/custom_checkbox.dart';
import 'package:investlink/src/uikit/loader/stack_loader.dart';

/// {@template stock_search_screen.class}
/// StockSearchScreen.
/// {@endtemplate}
class StockSearchScreen extends StatefulWidget {
  /// {@macro stock_search_screen.class}
  const StockSearchScreen({super.key});

  @override
  State<StockSearchScreen> createState() => _StockSearchScreenState();
}

class _StockSearchScreenState extends State<StockSearchScreen> {
  final _searchController = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    FocusScope.of(context).autofocus(_focusNode);
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StockSearchBloc, StockSearchState>(
      bloc: context.read<IStockSearchScope>().stockSearchBloc,
      listener: (context, stockSearchState) {
        stockSearchState.whenOrNull(
          idle: (tickersResult, error) {
            if (error != null) {
              SnackQueueProvider.of(context).addSnack(
                error.toString(),
                messageType: SnackMessageType.error,
              );
              return;
            }
          },
        );
      },
      buildWhen: (previous, current) {
        return previous != current;
      },
      builder: (context, stockSearchState) {
        return Scaffold(
          backgroundColor: AppColorScheme.of(context).textFieldBackground,
          appBar: StockSearchAppbar(
            searchController: _searchController,
            focusNode: _focusNode,
            onChanged: (value) {
              context.read<IStockSearchScope>().stockSearchBloc.add(
                    StockSearchEvent.search(value),
                  );
              if (value.length < 2) setState(() {});
            },
            suffixOnPressed: () {
              _searchController.clear();
              context.read<IStockSearchScope>().stockSearchBloc.add(const StockSearchEvent.clear());
            },
          ),
          body: Column(
            children: [
              const Gap(7),
              Divider(
                color: AppColorScheme.of(context).textFieldBorderColor,
                thickness: 6,
                height: 6,
              ),
              BlocBuilder<TickersCubit, TickersState>(
                bloc: context.read<IDatabaseScope>().tickersCubit,
                builder: (context, tickersState) {
                  return Expanded(
                    child: LoadingStack(
                      isLoading: stockSearchState.isProcessing,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: ListView.separated(
                          itemCount: stockSearchState.tickersResult?.tickers?.length ?? 0,
                          itemBuilder: (context, index) {
                            final ticker = stockSearchState.tickersResult?.tickers?[index];
                            final isFavorite =
                                tickersState.tickers.any((e) => e.ticker == ticker?.ticker);
                            return ListTile(
                              title: Row(
                                children: [
                                  Expanded(
                                    child: RichText(
                                      text: TextSpan(
                                        children: _highlightOccurrences(
                                          ticker?.ticker ?? '',
                                          _searchController.text,
                                          AppColorScheme.of(context).defaultTextColor,
                                          AppColorScheme.of(context).greenAccent,
                                        ),
                                        style: AppTextTheme.of(context).regular16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              trailing: SizedBox(
                                width: 10,
                                child: CtmCheckBox(
                                  value: isFavorite,
                                  onChanged: (onChange) {
                                    if (ticker != null && ticker.ticker != null) {
                                      if (isFavorite) {
                                        context
                                            .read<IDatabaseScope>()
                                            .tickersCubit
                                            .removeFromFavorites(ticker.ticker!);
                                      } else {
                                        context
                                            .read<IDatabaseScope>()
                                            .tickersCubit
                                            .addToFavorites(ticker);
                                      }
                                    }
                                  },
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Divider(
                              color: AppColorScheme.of(context).dividerColor,
                              height: 1,
                              indent: 5,
                              endIndent: 5,
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  List<TextSpan> _highlightOccurrences(
    String text,
    String query,
    Color textColor,
    Color highlightColor,
  ) {
    if (query.isEmpty || !text.toLowerCase().contains(query.toLowerCase())) {
      return [TextSpan(text: text, style: TextStyle(color: textColor))];
    }
    final matches = query.toLowerCase().allMatches(text.toLowerCase());
    var lastMatchEnd = 0;
    final children = <TextSpan>[];
    for (final match in matches) {
      if (match.start != lastMatchEnd) {
        children.add(
          TextSpan(
            text: text.substring(lastMatchEnd, match.start),
            style: TextStyle(color: textColor),
          ),
        );
      }
      children.add(
        TextSpan(
          text: text.substring(match.start, match.end),
          style: AppTextTheme.of(context)
              .regular16
              .copyWith(color: highlightColor, fontWeight: FontWeight.bold),
        ),
      );
      lastMatchEnd = match.end;
    }
    if (lastMatchEnd != text.length) {
      children.add(
        TextSpan(
          text: text.substring(lastMatchEnd, text.length),
          style: AppTextTheme.of(context).regular16.copyWith(color: textColor),
        ),
      );
    }
    return children;
  }
}
