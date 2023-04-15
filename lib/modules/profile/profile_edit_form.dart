import 'dart:developer';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopo_delivery/core/dummy_data/dummy_data.dart';
import 'package:shopo_delivery/modules/profile/model/profile_model.dart';
import 'package:shopo_delivery/modules/profile/model/type_model.dart';
import 'package:shopo_delivery/utils/constants.dart';
import '../../widgets/loading_widget.dart';
import '../authentication/widgets/sign_up_form.dart';
import '/utils/language_string.dart';
import '/widgets/capitalized_word.dart';
import '../../../core/remote_urls.dart';
import '../../../utils/utils.dart';
import '../../../widgets/custom_image.dart';
import '../../../widgets/primary_button.dart';
import 'controller/cubit/cubit/profile_edit_cubit.dart';

class ProfileEditForm extends StatefulWidget {
  const ProfileEditForm({
    Key? key,
    required this.deliveryMan,
  }) : super(key: key);
  final DeliveryMan deliveryMan;

  @override
  State<ProfileEditForm> createState() => _ProfileEditFormState();
}

class _ProfileEditFormState extends State<ProfileEditForm> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() {
    context.read<ProfileEditCubit>().changeFirstName(widget.deliveryMan.fname);
    context.read<ProfileEditCubit>().changeLastName(widget.deliveryMan.lname);
    context.read<ProfileEditCubit>().changeEmail(widget.deliveryMan.email);
    context.read<ProfileEditCubit>().changePhone(widget.deliveryMan.phone);
    context.read<ProfileEditCubit>().changeManType(widget.deliveryMan.mayType);
    context.read<ProfileEditCubit>().changeIdnType(widget.deliveryMan.idnType);
    context.read<ProfileEditCubit>().changeIdnNumber(widget.deliveryMan.idnNum);


  }

  @override
  Widget build(BuildContext context) {
    final profileEdBlc = context.read<ProfileEditCubit>();

    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      _buildImage(),
      Text(
        widget.deliveryMan.fname,
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
      ),
      const SizedBox(height: 20),
      Row(
        children: [
          Expanded(
            child: BlocBuilder<ProfileEditCubit, DeliveryMan>(
              // buildWhen: (p, c) => true,
              builder: (context, state) {
                final edit = state.state;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.name,
                      initialValue: widget.deliveryMan.fname,
                      onChanged: profileEdBlc.changeFirstName,
                      decoration: InputDecoration(
                          hintText: Language.name.capitalizeByWord()),
                    ),
                    const SizedBox(width: 10),
                    if (edit is ProfileEditFormValidState) ...[
                      if (edit.errors.fname.isNotEmpty)
                        FittedBox(
                            child: ErrorText(text: edit.errors.fname.first)),
                    ]
                  ],
                );
              },
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: BlocBuilder<ProfileEditCubit, DeliveryMan>(
              // buildWhen: (p, c) => true,
              builder: (context, state) {
                final edit = state.state;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.name,
                      initialValue: widget.deliveryMan.lname,
                      onChanged: profileEdBlc.changeLastName,
                      decoration: InputDecoration(
                          hintText: Language.name.capitalizeByWord()),
                    ),
                    const SizedBox(width: 10),
                    if (edit is ProfileEditFormValidState) ...[
                      if (edit.errors.lname.isNotEmpty)
                        FittedBox(
                            child: ErrorText(text: edit.errors.lname.first)),
                    ]
                  ],
                );
              },
            ),
          ),
        ],
      ),
      const SizedBox(height: 16),
      BlocBuilder<ProfileEditCubit, DeliveryMan>(
        builder: (context, state) {
          final edit = state.state;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                initialValue: widget.deliveryMan.email,
                onChanged: profileEdBlc.changeEmail,
                // validator: (String? v) {
                //   if (v == null || v.isEmpty)
                //     return '*Address is Required';
                //   return null;
                // },
                decoration:
                    const InputDecoration(hintText: Language.emailAddress),
              ),
              if (edit is ProfileEditFormValidState) ...[
                if (edit.errors.email.isNotEmpty)
                  ErrorText(text: edit.errors.email.first),
              ]
            ],
          );
        },
      ),
      const SizedBox(height: 16),
      BlocBuilder<ProfileEditCubit, DeliveryMan>(
        builder: (context, state) {
          final edit = state.state;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                keyboardType: TextInputType.phone,
                onChanged: profileEdBlc.changePhone,
                initialValue: widget.deliveryMan.phone,
                decoration: InputDecoration(
                  hintText: Language.phoneNumber.capitalizeByWord(),
                  prefixIcon: CountryCodePicker(
                    padding: const EdgeInsets.only(bottom: 8),
                    onChanged: (country) {
                      profileEdBlc.changePhone;
                    },
                    flagWidth: 35,
                    initialSelection: 'BD',
                    favorite: const ['+88', 'BD'],
                    showCountryOnly: false,
                    showOnlyCountryWhenClosed: false,
                    alignLeft: false,
                  ),
                ),
              ),
              if (edit is ProfileEditFormValidState) ...[
                if (edit.errors.phone.isNotEmpty)
                  ErrorText(text: edit.errors.phone.first),
              ]
            ],
          );
        },
      ),
      const SizedBox(height: 16),
      BlocBuilder<ProfileEditCubit, DeliveryMan>(
        builder: (context, state) {
          final edit = state.state;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButtonFormField<TypeMode>(
                  hint: const Text("Delivery Man Type"),
                  decoration: const InputDecoration(
                    isDense: true,
                    border: OutlineInputBorder(
                      // borderSide: BorderSide(width: 1, color: CustomColors.lineColor),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                  ),
                  isDense: true,
                  isExpanded: true,
                  value: manTypeList.first,
                  items: manTypeList
                      .map((e) => DropdownMenuItem<TypeMode>(
                          value: e, child: Text(e.name)))
                      .toList(),
                  onChanged: (v) {
                    print(v!);
                    profileEdBlc.changeManType(v.value);
                  }),
              if (edit is ProfileEditFormValidState) ...[
                if (edit.errors.manType.isNotEmpty)
                  FittedBox(child: ErrorText(text: edit.errors.manType.first)),
              ]
            ],
          );
        },
      ),
      const SizedBox(height: 16),
      Row(
        children: [
          Expanded(
            child: BlocBuilder<ProfileEditCubit, DeliveryMan>(
              builder: (context, state) {
                final edit = state.state;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DropdownButtonFormField<TypeMode>(
                        hint: const Text("Identity Type"),
                        decoration: const InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(
                            // borderSide: BorderSide(width: 1, color: CustomColors.lineColor),
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                        ),
                        isDense: true,
                        isExpanded: true,
                        value: idnTypeList.first,
                        items: idnTypeList
                            .map((e) => DropdownMenuItem<TypeMode>(
                                value: e, child: Text(e.name)))
                            .toList(),
                        onChanged: (v) {
                          print(v!);
                          profileEdBlc.changeIdnType(v.value);
                        }),
                    if (edit is ProfileEditFormValidState) ...[
                      if (edit.errors.idnType.isNotEmpty)
                        FittedBox(
                            child: ErrorText(text: edit.errors.idnType.first)),
                    ]
                  ],
                );
              },
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: BlocBuilder<ProfileEditCubit, DeliveryMan>(
              builder: (context, state) {
                final edit = state.state;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      initialValue: widget.deliveryMan.idnNum,
                      onChanged: profileEdBlc.changeIdnNumber,
                      // validator: (String? v) {
                      //   if (v == null || v.isEmpty)
                      //     return '*Address is Required';
                      //   return null;
                      // },
                      decoration: const InputDecoration(
                          hintText: Language.emailAddress),
                    ),
                    if (edit is ProfileEditFormValidState) ...[
                      if (edit.errors.idnNum.isNotEmpty)
                        FittedBox(
                            child: ErrorText(text: edit.errors.idnNum.first)),
                    ]
                  ],
                );
              },
            ),
          ),
        ],
      ),
      const SizedBox(height: 20),
    ]);
  }

  Widget _buildImage() {
    return BlocBuilder<ProfileEditCubit, DeliveryMan>(
      buildWhen: (previous, current) => previous.manImage != current.manImage,
      builder: (context, state) {
        String profileImage = widget.deliveryMan.manImage.isNotEmpty
            ? RemoteUrls.imageUrl(widget.deliveryMan.manImage)
            : RemoteUrls.imageUrl(
                "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.istockphoto.com%2Fphotos%2Fdefault-image&psig=AOvVaw1Kfzrvn8Rr67nRJ46Uvs_r&ust=1680547597672000&source=images&cd=vfe&ved=0CA8QjRxqFwoTCMCHoubti_4CFQAAAAAdAAAAABAE");

        profileImage =
            state.manImage.isNotEmpty ? state.manImage : profileImage;

        return Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: const Color(0xff333333).withOpacity(.18),
                blurRadius: 70,
              ),
            ],
          ),
          child: Center(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CustomImage(
                    path: profileImage,
                    height: 170,
                    width: 170,
                    fit: BoxFit.cover,
                    isFile: state.manImage.isNotEmpty,
                  ),
                ),
                Positioned(
                  right: 10,
                  bottom: 10,
                  child: InkWell(
                    onTap: () async {
                      final imageSourcePath = await Utils.pickSingleImage();
                      context
                          .read<ProfileEditCubit>()
                          .changeImage(imageSourcePath!);
                    },
                    child: const CircleAvatar(
                      backgroundColor: Color(0xff18587A),
                      child: Icon(Icons.edit, color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
