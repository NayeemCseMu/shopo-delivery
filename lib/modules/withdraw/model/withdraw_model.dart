import 'dart:convert';

import 'package:equatable/equatable.dart';

class WithdrawModel extends Equatable {
  final int id;
  final String deliveryManId;
  final String method;
  final String totalAmount;
  final String withdrawAmount;
  final String withdrawCharge;
  final String accountInfo;
  final String approvedDate;
  final String status;
  final String createdAt;
  final String updatedAt;

  const WithdrawModel({
    required this.id,
    required this.deliveryManId,
    required this.approvedDate,
    required this.method,
    required this.totalAmount,
    required this.withdrawAmount,
    required this.withdrawCharge,
    required this.accountInfo,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  WithdrawModel copyWith({
    int? id,
    String? deliveryManId,
    String? method,
    String? totalAmount,
    String? withdrawAmount,
    String? withdrawCharge,
    String? accountInfo,
    String? approvedDate,
    String? status,
    String? createdAt,
    String? updatedAt,
  }) {
    return WithdrawModel(
      id: id ?? this.id,
      deliveryManId: deliveryManId ?? this.deliveryManId,
      approvedDate: approvedDate ?? this.approvedDate,
      method: method ?? this.method,
      totalAmount: totalAmount ?? this.totalAmount,
      withdrawAmount: withdrawAmount ?? this.withdrawAmount,
      withdrawCharge: withdrawCharge ?? this.withdrawCharge,
      accountInfo: accountInfo ?? this.accountInfo,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'delivery_man_id': id,
      'method': method,
      'approved_date': approvedDate,
      'total_amount': totalAmount,
      'withdraw_amount': withdrawAmount,
      'withdraw_charge': withdrawCharge,
      'account_info': accountInfo,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory WithdrawModel.fromMap(Map<String, dynamic> json) {
    return WithdrawModel(
      id: json['id'] ?? 0,
      deliveryManId: json['delivery_man_id'] ?? '',
      approvedDate: json['approved_date'] ?? '',
      method: json['method'] ?? '',
      totalAmount: json['total_amount'] ?? '',
      withdrawAmount: json['withdraw_amount'] ?? '',
      withdrawCharge: json['withdraw_charge'] ?? '',
      accountInfo: json['account_info'] ?? '',
      status: json['status'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory WithdrawModel.fromJson(String source) =>
      WithdrawModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      deliveryManId,
      approvedDate,
      method,
      totalAmount,
      withdrawAmount,
      withdrawCharge,
      accountInfo,
      status,
      createdAt,
      updatedAt,
    ];
  }
}
