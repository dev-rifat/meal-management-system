import 'package:flutter/material.dart'
    show StatefulWidget, IconButton, Icons, Colors, Card;
import 'package:flutter/widgets.dart';
import 'package:mass_management/utils/app_color.dart';

class BalanceCardSwitcher extends StatefulWidget {
  const BalanceCardSwitcher({super.key});

  @override
  State<BalanceCardSwitcher> createState() => _BalanceCardSwitcherState();
}

class _BalanceCardSwitcherState extends State<BalanceCardSwitcher> {
  bool _showPrimary = true;

  void _toggleCard() {
    setState(() {
      _showPrimary = !_showPrimary;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1.0, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
          child: _showPrimary
              ? _balanceCard(
                  key: const ValueKey('primary'),
                  title: "Mess Balance",
                  balance: "৳ -1300.00",
                  deposit: "৳ 0.00",
                  expense: "৳ 1300.00",
                  gradient: const LinearGradient(
                    colors: [
                      AppColor.primaryColor,
                      AppColor.primaryColor,
                      AppColor.secondaryColor,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                )
              : _balanceCard(
                  key: const ValueKey('personal'),
                  title: "Personal Balance",
                  balance: "৳ 2000.00",
                  deposit: "৳ 1500.00",
                  expense: "৳ 500.00",
                  gradient: const LinearGradient(
                    colors: [Colors.indigo, Colors.purple],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
        ),
      ],
    );
  }

  Widget _balanceCard({
    required Key key,
    required String title,
    required String balance,
    required String deposit,
    required String expense,
    required Gradient gradient,
  }) {
    return GestureDetector(
      onTap: _toggleCard,
      child: Container(
        key: key,
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    Text(
                      title,
                      style: const TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: Icon(Icons.swap_horiz, color: Colors.white),
                        onPressed: _toggleCard,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  balance,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _balanceItem(Icons.arrow_downward, "Deposit", deposit),
                    _balanceItem(Icons.arrow_upward, "Expense", expense),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _balanceItem(IconData icon, String label, String amount) {
    return Row(
      children: [
        Icon(icon, color: Colors.orange, size: 20),
        const SizedBox(width: 4),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),
            Text(
              amount,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
