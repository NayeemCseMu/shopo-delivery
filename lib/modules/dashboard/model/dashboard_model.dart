// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../setting/model/setting_model.dart';
import 'order_model.dart';

class DashboardModel extends Equatable {
  final int totalOrderRequest;
  final int todayAcceptOrders;
  final int runnignOrder;
  final int totalCompletedOrder;
  final int totalDeclinedOrder;
  final int todayEarning;
  final int thisMonthEarning;
  final int thisYearEarning;
  final int totalEarning;
  final int deliveryManWithdraw;
  final int deliveryManPendingWithdraw;
  final List<OrderModel> runningOrder;
  final List<OrderModel> orders;
  final SettingModel setting;
  const DashboardModel({
    required this.totalOrderRequest,
    required this.todayAcceptOrders,
    required this.runnignOrder,
    required this.totalCompletedOrder,
    required this.totalDeclinedOrder,
    required this.todayEarning,
    required this.thisMonthEarning,
    required this.thisYearEarning,
    required this.totalEarning,
    required this.deliveryManWithdraw,
    required this.deliveryManPendingWithdraw,
    required this.runningOrder,
    required this.orders,
    required this.setting,
  });

  DashboardModel copyWith({
    int? totalOrderRequest,
    int? todayAcceptOrders,
    int? runnignOrder,
    int? totalCompletedOrder,
    int? totalDeclinedOrder,
    int? todayEarning,
    int? thisMonthEarning,
    int? thisYearEarning,
    int? totalEarning,
    int? deliveryManWithdraw,
    int? deliveryManPendingWithdraw,
    List<OrderModel>? runningOrder,
    List<OrderModel>? orders,
     SettingModel? setting,
  }) {
    return DashboardModel(
      totalOrderRequest: totalOrderRequest ?? this.totalOrderRequest,
      todayAcceptOrders: todayAcceptOrders ?? this.todayAcceptOrders,
      runnignOrder: runnignOrder ?? this.runnignOrder,
      totalCompletedOrder: totalCompletedOrder ?? this.totalCompletedOrder,
      totalDeclinedOrder: totalDeclinedOrder ?? this.totalDeclinedOrder,
      todayEarning: todayEarning ?? this.todayEarning,
      thisMonthEarning: thisMonthEarning ?? this.thisMonthEarning,
      thisYearEarning: thisYearEarning ?? this.thisYearEarning,
      totalEarning: totalEarning ?? this.totalEarning,
      deliveryManWithdraw: deliveryManWithdraw ?? this.deliveryManWithdraw,
      deliveryManPendingWithdraw:
          deliveryManPendingWithdraw ?? this.deliveryManPendingWithdraw,
      runningOrder: runningOrder ?? this.runningOrder,
      orders: orders ?? this.orders,
      setting: setting ?? this.setting,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'totalOrderRequest': totalOrderRequest,
      'todayAcceptOrders': todayAcceptOrders,
      'runnignOrder': runnignOrder,
      'totalCompletedOrder': totalCompletedOrder,
      'totalDeclinedOrder': totalDeclinedOrder,
      'todayEarning': todayEarning,
      'thisMonthEarning': thisMonthEarning,
      'thisYearEarning': thisYearEarning,
      'totalEarning': totalEarning,
      'deliveryManWithdraw': deliveryManWithdraw,
      'deliveryManPendingWithdraw': deliveryManPendingWithdraw,
      'runningOrder': runningOrder.map((x) => x.toMap()).toList(),
      'orders': orders.map((x) => x.toMap()).toList(),
      'setting': setting.toMap(),
    };
  }

  factory DashboardModel.fromMap(Map<String, dynamic> map) {
    return DashboardModel(
      totalOrderRequest:map['totalOrderRequest'] != null
          ? int.parse(map['totalOrderRequest'].toString())
          : 0, 
      todayAcceptOrders:map['todayAcceptOrders'] != null
          ? int.parse(map['todayAcceptOrders'].toString())
          : 0, 
      runnignOrder:map['runnignOrder'] != null
          ? int.parse(map['runnignOrder'].toString())
          : 0, 
      totalCompletedOrder:map['totalCompletedOrder'] != null
          ? int.parse(map['totalCompletedOrder'].toString())
          : 0, 
      totalDeclinedOrder:map['totalDeclinedOrder'] != null
          ? int.parse(map['totalDeclinedOrder'].toString())
          : 0, 
      todayEarning:map['todayEarning'] != null
          ? int.parse(map['todayEarning'].toString())
          : 0, 
      thisMonthEarning:map['thisMonthEarning'] != null
          ? int.parse(map['thisMonthEarning'].toString())
          : 0, 
      thisYearEarning: map['thisYearEarning'] != null
          ? int.parse(map['thisYearEarning'].toString())
          : 0,
      totalEarning: map['totalEarning'] != null
          ? int.parse(map['totalEarning'].toString())
          : 0,
      deliveryManWithdraw: map['deliveryManWithdraw'] != null
          ? int.parse(map['deliveryManWithdraw'].toString())
          : 0,
      deliveryManPendingWithdraw:map['deliveryManPendingWithdraw'] != null
          ? int.parse(map['deliveryManPendingWithdraw'].toString())
          : 0,
      runningOrder: List<OrderModel>.from(
        (map['runningOrder'] as List<dynamic>).map<OrderModel>(
          (x) => OrderModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      orders: List<OrderModel>.from(
        (map['orders'] as List<dynamic>).map<OrderModel>(
          (x) => OrderModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      setting: SettingModel.fromMap(map['setting'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory DashboardModel.fromJson(String source) =>
      DashboardModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      totalOrderRequest,
      todayAcceptOrders,
      runnignOrder,
      totalCompletedOrder,
      totalDeclinedOrder,
      todayEarning,
      thisMonthEarning,
      thisYearEarning,
      totalEarning,
      deliveryManWithdraw,
      deliveryManPendingWithdraw,
      runningOrder,
      orders,
      setting,
    ];
  }
}
