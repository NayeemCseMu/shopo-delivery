// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:shopo_delivery/modules/setting/model/setting_model.dart';

class WebsiteSetupModel extends Equatable {
  final SettingModel setting;

  const WebsiteSetupModel({
    required this.setting,
  });

  WebsiteSetupModel copyWith({
    SettingModel? setting,
  }) {
    return WebsiteSetupModel(
      setting: setting ?? this.setting,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'setting': setting.toMap(),
    };
  }

  factory WebsiteSetupModel.fromMap(Map<String, dynamic> map) {
    return WebsiteSetupModel(
      setting: SettingModel.fromMap(map['setting'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory WebsiteSetupModel.fromJson(String source) =>
      WebsiteSetupModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      setting,
    ];
  }
}
