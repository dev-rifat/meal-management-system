import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mass_management/core/widgets/custom_app_bar.dart';
import 'package:mass_management/core/widgets/custom_onloading.dart';
import 'package:mass_management/features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:mass_management/features/dashboard/presentation/cubit/dashboard_state.dart';
import 'package:mass_management/features/dashboard/presentation/widgets/balance_swap_card.dart';
import 'package:mass_management/features/dashboard/presentation/widgets/operation_grid.dart';
import 'package:mass_management/utils/app_color.dart';
import 'package:mass_management/utils/app_style.dart';
import 'package:mass_management/utils/dimensions.dart';
import 'transaction_history.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.instance<DashboardCubit>()..load(),
      child: const _DashboardView(),
    );
  }
}

class _DashboardView extends StatelessWidget {
  const _DashboardView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: _appBarTitle(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BalanceCardSwitcher(),
            const SizedBox(height: 30),
            _titleText("Operations"),
            const SizedBox(height: 10),
            const OperationGrid(),
            _titleText("Transaction History"),
            const SizedBox(height: 10),
            BlocBuilder<DashboardCubit, DashboardState>(
              builder: (context, state) {
                if (state is DashboardLoaded) {
                  return TransactionScreen(transactions: state.transactions);
                }
                if (state is DashboardError) {
                  return Text(state.message);
                }
                return LoadingHelper.defaultLoading();
              },
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget? _appBarTitle() {
    return CustomAppBar(
      backgroundColor: AppColor.backgroundColor,
      titleWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Welcome",
            style: AppStyle.titleText.copyWith(
              fontSize: Dimensions.fontSizeSmall,
              color: AppColor.hintColor,
            ),
          ),
          Text(
            "devZone",
            style: AppStyle.titleText.copyWith(
              fontSize: Dimensions.fontSizeMid,
            ),
          ),
        ],
      ),
      centerTitle: false,
      leading: CircleAvatar(
        radius: 40,
        backgroundColor: Colors.blueAccent,
        child: Image.network("https://cdn.pixabay.com/photo/2023/01/31/01/50/crown-7756927_1280.png"),
      ),
      actions: const [Icon(Icons.notifications_none), SizedBox(width: 10)],
    );
  }

  Widget _titleText(String s) => Text(
        s,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      );
}
