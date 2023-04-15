import 'package:equatable/equatable.dart';
import 'package:shopo_delivery/utils/k_images.dart';

import '../../modules/profile/model/type_model.dart';
import '../../utils/language_string.dart';

class DummyDashboardModel extends Equatable {
  final String image;
  final String name;

  const DummyDashboardModel({required this.name, required this.image});

  @override
  List<Object?> get props => [
        image,
        name,
      ];
}

final List<DummyDashboardModel> dummyData = [
  const DummyDashboardModel(
    name: Language.orderRequest,
    image: Kimages.orderRequest,
  ),
  const DummyDashboardModel(
    name: Language.acceptedOrders,
    image: Kimages.acceptedOrder,
  ),
  const DummyDashboardModel(
    name: Language.completedOrders,
    image: Kimages.completedOrders,
  ),
  const DummyDashboardModel(
    name: Language.declinedOrder,
    image: Kimages.declineOrders,
  ),
  const DummyDashboardModel(
    name: Language.monthlyEarning,
    image: Kimages.monthlyEarning,
  ),
  const DummyDashboardModel(
    name: Language.totalEarning,
    image: Kimages.totalEarning,
  ),
];

const List<TypeMode> idnTypeList = [
  TypeMode(name: "Passwort", value: "passport"),
  TypeMode(name: "Driving License", value: "driving license"),
  TypeMode(name: "NID", value: "nid"),

];

const List<TypeMode> manTypeList = [
  TypeMode(name: "Freelancer", value: "freelancer"),
  TypeMode(name: "Salary Based", value: "passport"),

];

final List<Map<String, String>> paymentStatusList = [
  {"name": "Pending", "value": "0"},
  {"name": "Success", "value": "1"},
];

final List<Map<String, String>> orderStatusList = [
  {"name": "Completed", "value": "3"},
  {"name": "Declined", "value": "4"},
];
