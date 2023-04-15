import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/remote_urls.dart';
import '../../../core/router_name.dart';
import '../../../utils/constants.dart';
import '../../profile/controller/cubit/profile_cubit.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20)
          .copyWith(top: 40),
      color: primaryColor,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(text:

          TextSpan(
              text: "Welcome To",
              style: GoogleFonts.inter(
                  color: blackColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 18.0,
                  height: 1.5
              ),
              children: [
                TextSpan(
                  text: "\nYour Dashboard",
                  style: GoogleFonts.inter(
                    color: blackColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 24.0,
                  ),
                ),
              ]
          )),

          BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              if (state is ProfileStateLoaded) {
                return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                          context, RouteNames.editProfileScreen);
                    },
                    child: CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(RemoteUrls.imageUrl(
                          state.deliveryManProfile.deliveryman
                              .manImage)),
                    ));
              }
              return const CircleAvatar();
            },
          ),
        ],
      ),
    );
  }
}