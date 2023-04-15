// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class AuthErrorModel extends Equatable {
  final String message;
  final Errors errors;

  const AuthErrorModel({
    required this.message,
    required this.errors,
  });

  AuthErrorModel copyWith({
    String? message,
    Errors? errors,
  }) {
    return AuthErrorModel(
      message: message ?? this.message,
      errors: errors ?? this.errors,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'errors': errors.toMap(),
    };
  }

  factory AuthErrorModel.fromMap(Map<String, dynamic> map) {
    return AuthErrorModel(
      message: map['message'] as String,
      errors: Errors.fromMap(map['errors'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthErrorModel.fromJson(String source) =>
      AuthErrorModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [message, errors];
}

class Errors extends Equatable {
  final List<String> name;
  final List<String> fname;
  final List<String> lname;
  final List<String> agree;
  final List<String> email;
  final List<String> idnType;
  final List<String> manType;
  final List<String> idnNum;
  final List<String> password;
  final List<String> phone;
  final List<String> country;
  final List<String> state;
  final List<String> city;
  final List<String> address;
  final List<String> type;
  final List<String> subject;
  final List<String> message;
  final List<String> review;

  final List<String> methodId;
  final List<String> withdrawAmount;
  final List<String> accountInfo;

  const Errors({
    required this.name,
    required this.fname,
    required this.lname,
    required this.email,
    required this.agree,
    required this.idnType,
    required this.manType,
    required this.idnNum,
    required this.password,
    required this.phone,
    required this.country,
    required this.state,
    required this.city,
    required this.address,
    required this.type,
    required this.subject,
    required this.message,
    required this.review,
    required this.methodId,
    required this.withdrawAmount,
    required this.accountInfo,
  });

  Errors copyWith({
    List<String>? name,
    List<String>? fname,
    List<String>? lname,
    List<String>? agree,
    List<String>? email,
    List<String>? idnType,
    List<String>? manType,
    List<String>? idnNum,
    List<String>? password,
    List<String>? phone,
    List<String>? country,
    List<String>? state,
    List<String>? city,
    List<String>? address,
    List<String>? type,
    List<String>? subject,
    List<String>? message,
    List<String>? review,
    List<String>? methodId,
    List<String>? withdrawAmount,
    List<String>? accountInfo,
  }) {
    return Errors(
      name: name ?? this.name,
      fname: fname ?? this.fname,
      lname: lname ?? this.lname,
      email: email ?? this.email,
      idnType: idnType ?? this.idnType,
      manType: manType ?? this.manType,
      agree: email ?? this.agree,
      idnNum: idnNum ?? this.idnNum,
      password: email ?? this.password,
      phone: phone ?? this.phone,
      country: country ?? this.country,
      state: state ?? this.state,
      city: city ?? this.city,
      address: address ?? this.address,
      type: type ?? this.type,
      subject: subject ?? this.subject,
      message: message ?? this.message,
      review: review ?? this.review,
      methodId: methodId ?? this.methodId,
      withdrawAmount: withdrawAmount ?? this.withdrawAmount,
      accountInfo: accountInfo ?? this.accountInfo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'fname': fname,
      'lname': lname,
      'email': email,
      'agree': agree,
      'idn_type': idnType,
      'man_type': manType,
      'idn_num': idnNum,
      'password': password,
      'phone': phone,
      'country': country,
      'state': state,
      'city': city,
      'address': address,
      'type': type,
      'subject': subject,
      'message': message,
      'review': review,
      'method_id': methodId,
      'withdraw_amount': withdrawAmount,
      'account_info': accountInfo,
    };
  }

  factory Errors.fromMap(Map<String, dynamic> map) {
    return Errors(
      name: map['name'] != null
          ? List<String>.from(map['name'].map((x) => x))
          : [],
      fname: map['fname'] != null
          ? List<String>.from(map['fname'].map((x) => x))
          : [],
      lname: map['lname'] != null
          ? List<String>.from(map['lname'].map((x) => x))
          : [],
      email: map['email'] != null
          ? List<String>.from(map['email'].map((x) => x))
          : [],
      agree: map['agree'] != null
          ? List<String>.from(map['agree'].map((x) => x))
          : [],
      idnType: map['idn_type'] != null
          ? List<String>.from(map['idn_type'].map((x) => x))
          : [],
      manType: map['man_type'] != null
          ? List<String>.from(map['man_type'].map((x) => x))
          : [],
      idnNum: map['idn_num'] != null
          ? List<String>.from(map['idn_num'].map((x) => x))
          : [],
      password: map['password'] != null
          ? List<String>.from(map['password'].map((x) => x))
          : [],
      phone: map['phone'] != null
          ? List<String>.from(map['phone'].map((x) => x))
          : [],
      country: map['country'] != null
          ? List<String>.from(map['country'].map((x) => x))
          : [],
      state: map['state'] != null
          ? List<String>.from(map['state'].map((x) => x))
          : [],
      city: map['city'] != null
          ? List<String>.from(map['city'].map((x) => x))
          : [],
      address: map['address'] != null
          ? List<String>.from(map['address'].map((x) => x))
          : [],
      type: map['type'] != null
          ? List<String>.from(map['type'].map((x) => x))
          : [],
      subject: map['subject'] != null
          ? List<String>.from(map['subject'].map((x) => x))
          : [],
      message: map['message'] != null
          ? List<String>.from(map['message'].map((x) => x))
          : [],
      review: map['review'] != null
          ? List<String>.from(map['review'].map((x) => x))
          : [],
      methodId: map['method_id'] != null
          ? List<String>.from(map['method_id'].map((x) => x))
          : [],
      withdrawAmount: map['withdraw_amount'] != null
          ? List<String>.from(map['withdraw_amount'].map((x) => x))
          : [],
      accountInfo: map['account_info'] != null
          ? List<String>.from(map['account_info'].map((x) => x))
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory Errors.fromJson(String source) =>
      Errors.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
        name,
        fname,
        lname,
        email,
        agree,
        idnType,
        manType,
        idnNum,
        password,
        phone,
        country,
        state,
        city,
        address,
        type,
        subject,
        message,
        review,
        methodId,
        withdrawAmount,
        accountInfo,
      ];
}
