import 'dart:convert';

import 'package:equatable/equatable.dart';

class CurrencyModel extends Equatable {
  final String icon;

  const CurrencyModel({
    required this.icon,
  });

  CurrencyModel copyWith({
    String? icon,
  }) {
    return CurrencyModel(
      icon: icon ?? this.icon,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'icon': icon,
    };
  }

  factory CurrencyModel.fromMap(Map<String, dynamic> map) {
    return CurrencyModel(
      icon: map['icon'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CurrencyModel.fromJson(String source) =>
      CurrencyModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [icon];
}
