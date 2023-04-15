import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/constants.dart';
import '../../../utils/language_string.dart';
import '../../../utils/utils.dart';
import '../../withdraw/components/withdraw_dialog.dart';
import '../model/dashboard_model.dart';

class BalanceAndWithdrawCard extends StatelessWidget {
  const BalanceAndWithdrawCard({
    super.key,
    required this.dashboardModel,
  });

  final DashboardModel dashboardModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.0,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      margin: const EdgeInsets.symmetric(
          horizontal: 18.0, vertical: 0.0),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                Language.currentBalance,
                style: GoogleFonts.inter(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                    color: primaryColor),
              ),
              const SizedBox(height: 4.0),
              Text(
                Utils.formatAmount(dashboardModel.totalEarning),
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  fontSize: 30.0,
                ),
              )
            ],
          ),
          InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) => const WithdrawDialog());
            },
            child: Container(
              height: 40.0,
              width: 104.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: greenColor,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                Language.withdraw,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
