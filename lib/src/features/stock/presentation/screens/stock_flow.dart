import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investlink/src/core/common/widgets/di_scope.dart';
import 'package:investlink/src/features/database/di/database_scope.dart';
import 'package:investlink/src/features/snackbar_queue/presentation/snack_message_type.dart';
import 'package:investlink/src/features/snackbar_queue/presentation/snack_queue_provider.dart';
import 'package:investlink/src/features/socket/di/socket_scope.dart';
import 'package:investlink/src/features/socket/presentation/bloc/socket_bloc.dart';
import 'package:investlink/src/features/stock/di/stock_scope.dart';
import 'package:investlink/src/features/stock/presentation/screens/stock_screen.dart';

/// {@template stock_flow.class}
/// Entry point to feature .
/// {@endtemplate}
class StockFlow extends StatefulWidget {
  /// {@macro stock_flow.class}
  const StockFlow({super.key});

  static const String routePath = '/stock';
  static const String routeName = 'stock';

  @override
  State<StockFlow> createState() => _StockFlowState();
}

class _StockFlowState extends State<StockFlow> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<ISocketScope>().socketBloc.add(
          const SocketEvent.connect(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SocketBloc, SocketState>(
      bloc: context.read<ISocketScope>().socketBloc,
      listener: _socketListener,
      child: DiScope<IStockScope>(
        factory: (_) => StockScope.create(context),
        onDispose: (scope) => scope.dispose(),
        child: const StockScreen(),
      ),
    );
  }

  void _socketListener(_, SocketState state) {
    state.whenOrNull(
      recievedMessage: (socketMessage) {
        context.read<IDatabaseScope>().tickersCubit.changeTickerFromFavorites(socketMessage);
      },
      connected: (error) {
        if (error != null) {
          SnackQueueProvider.of(context).addSnack(
            error.toString(),
            messageType: SnackMessageType.error,
          );
          return;
        }
        context.read<ISocketScope>().socketBloc.add(const SocketEvent.listen());
      },
    );
  }
}
