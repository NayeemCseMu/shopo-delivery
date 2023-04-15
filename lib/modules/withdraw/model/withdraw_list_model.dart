import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'currency_model.dart';
import 'withdraw_model.dart';

class WithdrawListModel extends Equatable {
  final CurrencyModel? currencyIcon;
  final List<WithdrawModel>? withdraw;

  const WithdrawListModel({
    this.currencyIcon,
    this.withdraw,
  });

  WithdrawListModel copyWith({
    CurrencyModel? currencyIcon,
    List<WithdrawModel>? withdraw,
  }) {
    return WithdrawListModel(
      currencyIcon: currencyIcon ?? this.currencyIcon,
      withdraw: withdraw ?? this.withdraw,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'currency_icon': currencyIcon!.toMap(),
      'withdraws': withdraw!.map((x) => x.toMap()).toList(),
    };
  }

  factory WithdrawListModel.fromMap(Map<String, dynamic> map) {
    return WithdrawListModel(
      currencyIcon: map['currency_icon'] != null
          ? CurrencyModel.fromMap(map['currency_icon'] as Map<String, dynamic>)
          : null,
      withdraw: map['withdraws'] != null
          ? List<WithdrawModel>.from(
              (map['withdraws'] as List<dynamic>).map<WithdrawModel>(
                (x) => WithdrawModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory WithdrawListModel.fromJson(String source) =>
      WithdrawListModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
        currencyIcon!,
        withdraw!,
      ];
}
