// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class TypeMode extends Equatable {
  final String name;
  final String value;
  const TypeMode({
    required this.name,
    required this.value,
  });

  TypeMode copyWith({
    String? name,
    String? value,
  }) {
    return TypeMode(
      name: name ?? this.name,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'value': value,
    };
  }

  factory TypeMode.fromMap(Map<String, dynamic> map) {
    return TypeMode(
      name: map['name'] as String,
      value: map['value'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TypeMode.fromJson(String source) =>
      TypeMode.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [name, value];
}
