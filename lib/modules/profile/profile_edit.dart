import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopo_delivery/modules/profile/controller/cubit/cubit/profile_edit_cubit.dart';
import 'package:shopo_delivery/modules/profile/controller/cubit/profile_cubit.dart';
import 'package:shopo_delivery/utils/constants.dart';
import 'package:shopo_delivery/widgets/rounded_app_bar.dart';

import '../../utils/language_string.dart';
import '../../utils/utils.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/primary_button.dart';
import 'model/profile_model.dart';
import 'profile_edit_form.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({Key? key}) : super(key: key);

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RoundedAppBar(titleText: "Edit Profile"),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileEditStateLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ProfileStateError) {
            Utils.errorSnackBar(context, state.message);
            return Center(child: Text(state.message));
          } else if (state is ProfileStateLoaded) {
            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
              child: ProfileEditForm(
                  deliveryMan: state.deliveryManProfile.deliveryman),
            );
          }
          return const SizedBox();
        },
      ),
      bottomNavigationBar: Container(
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: BlocConsumer<ProfileEditCubit, DeliveryMan>(
          listener: (c, s) {
            final currentState = s.state;
            if (currentState is ProfileEditStateLoaded) {
              Navigator.pop(context);
              context.read<ProfileCubit>().getProfileInfo();
              Utils.showSnackBar(context, currentState.message);
            }
            if (currentState is ProfileEditStateError) {
              Utils.errorSnackBar(context, currentState.message);
            }
          },
          builder: (context, state) {
            final currentState = state.state;
            if (currentState is ProfileEditStateLoading) {
              return const Center(child:  CircularProgressIndicator(
                color: primaryColor
              ));
            }
            return PrimaryButton(
              text: Language.update,
              borderRadiusSize: 4,
              fontSize: 18,
              onPressed: () {
                context.read<ProfileEditCubit>().submitForm();
              },
            );
          },
        ),
      ),
    );
  }
}
