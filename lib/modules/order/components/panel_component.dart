import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopo_delivery/core/dummy_data/dummy_data.dart';
import 'package:shopo_delivery/utils/constants.dart';

import '../../../widgets/separator.dart';
import '../controller/cubit/cubit/order_details_cubit.dart';

class PanelComponent extends StatelessWidget {
  const PanelComponent({Key? key, required this.scrollController})
      : super(key: key);
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return Container
      (
      alignment: Alignment.center,
      color: lightningYellowColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Text("Slide Up",style: GoogleFonts.roboto(
            fontWeight: FontWeight.w700,
            fontSize: 16.0,
            color: const Color(0xFF0B2C3D),
          )),
          const SizedBox(width: 10),
          Icon(Icons.arrow_circle_up),
        ],
      ),
    );
  }


}
