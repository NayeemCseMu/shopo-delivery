import 'dart:convert';

import 'package:equatable/equatable.dart';

class SingleOrderedProductModel extends Equatable {
  final int id;
  final String orderId;
  final String productId;
  final String sellerId;
  final String productName;
  final double unitPrice;
  final int qty;
  final String createdAt;
  final String updatedAt;

  const SingleOrderedProductModel({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.sellerId,
    required this.productName,
    required this.unitPrice,
    required this.qty,
    required this.createdAt,
    required this.updatedAt,
  });

  SingleOrderedProductModel copyWith({
    int? id,
    String? orderId,
    String? productId,
    String? sellerId,
    String? productName,
    double? unitPrice,
    int? qty,
    String? createdAt,
    String? updatedAt,
  }) {
    return SingleOrderedProductModel(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      productId: productId ?? this.productId,
      sellerId: sellerId ?? this.sellerId,
      productName: productName ?? this.productName,
      unitPrice: unitPrice ?? this.unitPrice,
      qty: qty ?? this.qty,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'order_id': orderId,
      'product_id': productId,
      'seller_id': sellerId,
      'product_name': productName,
      'unit_price': unitPrice,
      'qty': qty,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory SingleOrderedProductModel.fromMap(Map<String, dynamic> map) {
    return SingleOrderedProductModel(
      id: map['id'] ?? 0,
      orderId: map['order_id'] ?? '',
      productId: map['product_id'] ?? '',
      sellerId: map['seller_id'] ?? '',
      productName: map['product_name'] ?? '',
      unitPrice: map['unit_price'] != null
          ? double.parse(map['unit_price'].toString())
          : 0.0,
      qty: map['qty'] != null ? int.parse(map['qty'].toString()) : 0,
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SingleOrderedProductModel.fromJson(String source) =>
      SingleOrderedProductModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      orderId,
      productId,
      sellerId,
      productName,
      unitPrice,
      qty,
      createdAt,
      updatedAt,
    ];
  }
}
