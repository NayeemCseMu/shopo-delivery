import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopo_delivery/widgets/capitalized_word.dart';
import '../../core/router_name.dart';
import '../../utils/constants.dart';
import '../../utils/k_images.dart';
import '../../utils/language_string.dart';
import '../../widgets/action_dialog.dart';
import '../../widgets/custom_image.dart';
import '../../widgets/loading_widget.dart';
import '../authentication/controller/login/login_bloc.dart';
import 'components/profile_topbar.dart';
import 'model/profile_model.dart';
import 'controller/cubit/profile_cubit.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileStateLoading) {
          return const LoadingWidget();
        } else if (state is ProfileStateError) {
          return Center(child: Text(state.message));
        } else if (state is ProfileStateLoaded) {
          return LoadedProfile(profile: state.deliveryManProfile);
        }
        return const SizedBox();
      },
    );
  }
}

class LoadedProfile extends StatelessWidget {
  const LoadedProfile({
    super.key,
    required this.profile,
  });
  final DeliveryManProfile profile;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileTopBar(profile: profile),
        SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
          child: Column(
            children: [

               ElementTile(
                    title: Language.editProfile.capitalizeByWord(),
                    press: () {
                      Navigator.pushNamed(context, RouteNames.editProfileScreen);
                    },
                    iconPath: Kimages.editProfileIcon,
                  ),
              const Divider(),
              ElementTile(
                title: Language.withdraw.capitalizeByWord(),
                press: () {
                  Navigator.pushNamed(context, RouteNames.withdraw);
                },
                iconPath: Kimages.withdrawIcon,
              ),

              const Divider(),

              BlocBuilder<LoginBloc, LoginModelState>(
                    buildWhen: (previous, current) => previous.state != current.state,
                    builder: (context, state) {
                      final loginBloc = context.read<LoginBloc>();
                      if (state.state is LoginStateLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return ElementTile(
                        title: Language.logout.capitalizeByWord(),
                        press: () {
                          loginBloc.add(const LoginEventLogout());

                          showDialog(
                            context: context,
                            builder: (context) => ActionDialog(
                              title: "${Language.areYouSureYouWantToLogOut}?",
                              image: Kimages.logout,
                              deleteText: Language.logout,
                              textColor: primaryColor,
                              onTap: () {
                                loginBloc.add(const LoginEventLogout());
                                Navigator.pushReplacementNamed(
                                    context, RouteNames.authenticationScreen);
                              },
                            ),
                          );
                        },
                        iconPath: Kimages.profileLogOutIcon,
                      );
                    },
                  ),
            ],
          ),
        ),
      ],
    );
  }
}

class ElementTile extends StatelessWidget {
  const ElementTile({
    Key? key,
    this.title,
    this.press,
    this.iconPath,
  }) : super(key: key);
  final String? title;
  final VoidCallback? press;
  final String? iconPath;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minLeadingWidth: 0,
      onTap: press,
      contentPadding: EdgeInsets.zero,
      leading: CustomImage(
        path: iconPath!,
        height: 22.0,
        color: lightningYellowColor,
      ),
      title: Text(
        title!,
        style: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
