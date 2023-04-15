import 'dart:convert';

import 'package:equatable/equatable.dart';

class SellerModel extends Equatable {
  final int id;
  final String userId;
  final double totalAmount;
  final String bannerImage;
  final String logo;
  final String phone;
  final String email;
  final String shopName;
  final String slug;
  final String openAt;
  final String closedAt;
  final String address;
  final String seoTitle;
  final String seoDescription;
  final String status;
  final String isFeatured;
  final String topRated;
  final String verifiedToken;
  final String isVerified;
  final String greetingMessage;
  final String createdAt;
  final String updatedAt;
  final double averageRating;

  const SellerModel({
    required this.id,
    required this.userId,
    required this.totalAmount,
    required this.bannerImage,
    required this.logo,
    required this.phone,
    required this.email,
    required this.shopName,
    required this.slug,
    required this.openAt,
    required this.closedAt,
    required this.address,
    required this.seoTitle,
    required this.seoDescription,
    required this.status,
    required this.isFeatured,
    required this.topRated,
    required this.verifiedToken,
    required this.isVerified,
    required this.greetingMessage,
    required this.createdAt,
    required this.updatedAt,
    required this.averageRating,
  });

  SellerModel copyWith({
    int? id,
    String? userId,
    double? totalAmount,
    String? bannerImage,
    String? logo,
    String? phone,
    String? email,
    String? shopName,
    String? slug,
    String? openAt,
    String? closedAt,
    String? address,
    String? seoTitle,
    String? seoDescription,
    String? status,
    String? isFeatured,
    String? topRated,
    String? verifiedToken,
    String? isVerified,
    String? greetingMessage,
    String? createdAt,
    String? updatedAt,
    double? averageRating,
  }) {
    return SellerModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      totalAmount: totalAmount ?? this.totalAmount,
      bannerImage: bannerImage ?? this.bannerImage,
      logo: logo ?? this.logo,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      shopName: shopName ?? this.shopName,
      slug: slug ?? this.slug,
      openAt: openAt ?? this.openAt,
      closedAt: closedAt ?? this.closedAt,
      address: address ?? this.address,
      seoTitle: seoTitle ?? this.seoTitle,
      seoDescription: seoDescription ?? this.seoDescription,
      status: status ?? this.status,
      isFeatured: isFeatured ?? this.isFeatured,
      topRated: topRated ?? this.topRated,
      verifiedToken: verifiedToken ?? this.verifiedToken,
      isVerified: isVerified ?? this.isVerified,
      greetingMessage: greetingMessage ?? this.greetingMessage,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      averageRating: averageRating ?? this.averageRating,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'total_amount': totalAmount,
      'banner_image': bannerImage,
      'logo': logo,
      'phone': phone,
      'email': email,
      'shopName': shopName,
      'slug': slug,
      'open_at': openAt,
      'closed_at': closedAt,
      'address': address,
      'seo_title': seoTitle,
      'seo_description': seoDescription,
      'status': status,
      'is_featured': isFeatured,
      'top_rated': topRated,
      'verified_token': verifiedToken,
      'is_verified': isVerified,
      'greeting_msg': greetingMessage,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'averageRating': averageRating,
    };
  }

  factory SellerModel.fromMap(Map<String, dynamic> map) {
    return SellerModel(
      id: map['id'] ?? 0,
      userId: map['userId'] ?? '',
      totalAmount:
          map['total_amount'] != null ? double.parse(map['total_amount']) : 0.0,
      bannerImage: map['banner_image'] ?? '',
      logo: map['logo'] ?? '',
      phone: map['phone'] ?? '',
      email: map['email'] ?? '',
      shopName: map['shop_name'] ?? '',
      slug: map['slug'] ?? '',
      openAt: map['open_at'] ?? '',
      closedAt: map['closed_at'] ?? '',
      address: map['address'] ?? '',
      seoTitle: map['seo_title'] ?? '',
      seoDescription: map['seo_description'] ?? '',
      status: map['status'] ?? '',
      isFeatured: map['is_featured'] ?? '',
      topRated: map['top_rated'] ?? '',
      verifiedToken: map['verified_token'] ?? '',
      isVerified: map['is_verified'] ?? '',
      greetingMessage: map['greeting_msg'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
      averageRating: map['averageRating'] != null
          ? double.parse(map['averageRating'])
          : 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory SellerModel.fromJson(String source) =>
      SellerModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      userId,
      totalAmount,
      bannerImage,
      logo,
      phone,
      email,
      shopName,
      slug,
      openAt,
      closedAt,
      address,
      seoTitle,
      seoDescription,
      status,
      isFeatured,
      topRated,
      verifiedToken,
      isVerified,
      greetingMessage,
      createdAt,
      updatedAt,
      averageRating,
    ];
  }
}
