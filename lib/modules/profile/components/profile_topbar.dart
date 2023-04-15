import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopo_delivery/core/remote_urls.dart';
import 'package:shopo_delivery/core/router_name.dart';
import 'package:shopo_delivery/modules/dashboard/controller/dashboard_cubit.dart';
import 'package:shopo_delivery/modules/profile/model/profile_model.dart';
import 'package:shopo_delivery/utils/constants.dart';

import '../../../widgets/custom_image.dart';
import '../../animated_splash_screen/controller/app_setting_cubit/app_setting_cubit.dart';

class ProfileTopBar extends StatelessWidget {
  const ProfileTopBar({
    super.key,
    required this.profile,
  });

  final DeliveryManProfile profile;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
      child: Stack(
        children: [
          NameAndImage(profile: profile),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: FloatingInfo(profile: profile),
          ),
        ],
      ),
    );
  }
}

class NameAndImage extends StatelessWidget {
  const NameAndImage({
    super.key,
    required this.profile,
  });

  final DeliveryManProfile profile;

  @override
  Widget build(BuildContext context) {
    final appSetting = context.read<AppSettingCubit>();
    return Container(
      width: double.infinity,
      height: 150,
      decoration: const BoxDecoration(
        color: primaryColor,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomImage(
            path: RemoteUrls.imageUrl(
                context.read<AppSettingCubit>().settingModel!.setting.logo),
            height: 30,
            width: 128,
            color: Colors.black,
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, RouteNames.editProfileScreen);
            },
            child: CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(
                  RemoteUrls.imageUrl(profile.deliveryman.manImage)),
            ),
          ),
        ],
      ),
    );
  }
}

class FloatingInfo extends StatelessWidget {
  const FloatingInfo({
    super.key,
    required this.profile,
  });

  final DeliveryManProfile profile;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 120,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          offset: const Offset(0, 7),
          color: const Color(0xff333333).withOpacity(0.06),
          blurRadius: 6,
        )
      ]),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        CircleElement(
          count: profile.runingOrder.toInt(),
          title: "Running",
        ),
        CircleElement(
          count: profile.completeOrder.toInt(),
          title: "Complete",
        ),
        CircleElement(
          count: profile.totaEarn.toInt(),
          title: "Total Earn",
        ),
        CircleElement(
          count: profile.deliveryManWithdraw.toInt(),
          title: "Withdraw",
        ),
      ]),
    );
  }
}

class CircleElement extends StatelessWidget {
  const CircleElement({
    super.key,
    required this.count,
    required this.title,
  });

  final int count;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: const Color(0xffE8EEF2),
            child: FittedBox(
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Text(
                  "$count",
                  style: const TextStyle(
                      color: Color(0xff000000),
                      fontSize: 24,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: const TextStyle(
                color: textGreyColor,
                fontSize: 13,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
