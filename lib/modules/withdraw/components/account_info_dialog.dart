// import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:shopo_delivery/widgets/separator.dart';

import '../../../utils/constants.dart';
import '../../../utils/k_images.dart';
import '../../../widgets/custom_image.dart';
import '../model/account_info_model.dart';

class AccountInfoDialog extends StatelessWidget {
  const AccountInfoDialog({Key? key, required this.accountInfo})
      : super(key: key);
  final AccountInfoModel accountInfo;
  final space = const SizedBox(height: 10.0);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      icon: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Method Info",
            style: Theme.of(context)
                .textTheme
                .headline3!
                .copyWith(fontSize: 20.0, color: blackColor),
          ),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const CustomImage(
              path: Kimages.cancel,
              height: 15.0,
            ),
          ),
        ],
      ),
      //title: Text(accountInfo.name),
      content: Container(
        height: 220.0,
        width: 330.0,
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
        padding: const EdgeInsets.symmetric(horizontal: 0.0),
        decoration: BoxDecoration(
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            space,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Min Amount'),
                      Text(accountInfo.minAmount),
                    ],
                  ),
                  const Padding(
                    padding:  EdgeInsets.symmetric(vertical: 8),
                    child:  MySeparator(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Max Amount'),
                      Text(accountInfo.maxAmount),
                    ],
                  ),
                  const Padding(
                    padding:  EdgeInsets.symmetric(vertical: 8),
                    child:  MySeparator(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Withdraw Charge'),
                      Text('${accountInfo.withdrawCharge}%'),
                    ],
                  ),
                  const Padding(
                    padding:  EdgeInsets.symmetric(vertical: 8),
                    child:  MySeparator(),
                  ),
                ],
              ),
            ),
            // space,
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     const Text('Status'),
            //     Text(accountInfo.status),
            //   ],
            // ),
            space,

            Html(
              data: accountInfo.description,
              style: {
                "p": Style(
                    color: blackColor,
                    padding: EdgeInsets.zero,
                    margin: Margins.zero,
                    textAlign: TextAlign.start,
                    lineHeight: LineHeight.em(1.2),
                    whiteSpace: WhiteSpace.normal)
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _withdrawInfo(String title, String value) {
    return SizedBox(
      height: 30.0,
      width: 300.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title),
            // DottedLine(
            //   dashColor: blackColor,
            // ),
            Text(value),
          ],
        ),
      ),
    );
  }
}
