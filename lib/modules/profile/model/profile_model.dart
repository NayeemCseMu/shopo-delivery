// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../controller/cubit/cubit/profile_edit_cubit.dart';

class DeliveryManProfile extends Equatable {
  final DeliveryMan deliveryman;
  final int completeOrder;
  final int runingOrder;
  final double totaEarn;
  final double deliveryManWithdraw;
  final double currentProductAmount;
  const DeliveryManProfile({
    required this.deliveryman,
    required this.completeOrder,
    required this.runingOrder,
    required this.totaEarn,
    required this.deliveryManWithdraw,
    required this.currentProductAmount,
  });

  DeliveryManProfile copyWith({
    DeliveryMan? deliveryman,
    int? completeOrder,
    int? runingOrder,
    double? totaEarn,
    double? deliveryManWithdraw,
    double? currentProductAmount,
  }) {
    return DeliveryManProfile(
      deliveryman: deliveryman ?? this.deliveryman,
      completeOrder: completeOrder ?? this.completeOrder,
      runingOrder: runingOrder ?? this.runingOrder,
      totaEarn: totaEarn ?? this.totaEarn,
      deliveryManWithdraw: deliveryManWithdraw ?? this.deliveryManWithdraw,
      currentProductAmount: currentProductAmount ?? this.currentProductAmount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'deliveryman': deliveryman.toMap(),
      'completeOrder': completeOrder,
      'runingOrder': runingOrder,
      'tota_earn': totaEarn,
      'deliveryManWithdraw': deliveryManWithdraw,
      'current_product_amount': currentProductAmount,
    };
  }

  factory DeliveryManProfile.fromMap(Map<String, dynamic> map) {
    return DeliveryManProfile(
      deliveryman:
          DeliveryMan.fromMap(map['deliveryman'] as Map<String, dynamic>),
      completeOrder: map['completeOrder'] as int,
      runingOrder: map['runingOrder'] as int,
      totaEarn: map['tota_earn'] != null
          ? double.parse(map['tota_earn'].toString())
          : 0.0,
      deliveryManWithdraw: map['deliveryManWithdraw'] != null
          ? double.parse(map['deliveryManWithdraw'].toString())
          : 0,
      currentProductAmount: map['current_product_amount'] != null
          ? double.parse(map['current_product_amount'].toString())
          : 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory DeliveryManProfile.fromJson(String source) =>
      DeliveryManProfile.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      deliveryman,
      completeOrder,
      runingOrder,
      totaEarn,
      deliveryManWithdraw,
      currentProductAmount,
    ];
  }
}

class DeliveryMan extends Equatable {
  final int id;
  final String manImage;
  final String fname;
  final String lname;
  final String email;
  final String mayType;
  final String idnType;
  final String idnNum;
  final String idnImage;
  final String phone;
  final int status;
  final String createdAt;
  final String updatedAt;
  final ProfileEditState state;
  const DeliveryMan({
    this.id = 0,
    this.manImage = '',
    this.fname = '',
    this.lname = '',
    this.email = '',
    this.mayType = '',
    this.idnType = '',
    this.idnNum = '',
    this.idnImage = '',
    this.phone = '',
    this.status = 0,
    this.createdAt = '',
    this.updatedAt = '',
    this.state = const ProfileEditInitial(),
  });

  DeliveryMan copyWith({
    int? id,
    String? manImage,
    String? fname,
    String? lname,
    String? email,
    String? mayType,
    String? idnType,
    String? idnNum,
    String? idnImage,
    String? phone,
    int? status,
    String? createdAt,
    String? updatedAt,
    ProfileEditState? state,
  }) {
    return DeliveryMan(
      id: id ?? this.id,
      manImage: manImage ?? this.manImage,
      fname: fname ?? this.fname,
      lname: lname ?? this.lname,
      email: email ?? this.email,
      mayType: mayType ?? this.mayType,
      idnType: idnType ?? this.idnType,
      idnNum: idnNum ?? this.idnNum,
      idnImage: idnImage ?? this.idnImage,
      phone: phone ?? this.phone,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      state: state ?? this.state,
    );
  }

  Map<String, String> toMap() {
    return <String, String>{
      'fname': fname,
      'lname': lname,
      'email': email,
      'man_type': mayType,
      'idn_type': idnType,
      'idn_num': idnNum,
      'phone': phone,
    };
  }

  factory DeliveryMan.fromMap(Map<String, dynamic> map) {
    return DeliveryMan(
      id: map['id'] as int,
      manImage: map['man_image'] as String,
      fname: map['fname'] as String,
      lname: map['lname'] as String,
      email: map['email'] as String,
      mayType: map['man_type'] as String,
      idnType: map['idn_type'] as String,
      idnNum: map['idn_num'] as String,
      idnImage: map['idn_image'] as String,
      phone: map['phone'] as String,
      status: map['status'] != null ? int.parse(map['status'].toString()) : 0,
      createdAt: map['created_at'] as String,
      updatedAt: map['updated_at'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory DeliveryMan.fromJson(String source) =>
      DeliveryMan.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      manImage,
      fname,
      lname,
      email,
      mayType,
      idnType,
      idnNum,
      idnImage,
      phone,
      status,
      createdAt,
      updatedAt,
      state,
    ];
  }
}
