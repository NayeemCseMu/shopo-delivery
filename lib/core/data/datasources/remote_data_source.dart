import 'dart:async';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:shopo_delivery/modules/dashboard/model/order_model.dart';
import 'package:shopo_delivery/modules/order/model/order_details_model.dart';
import 'package:shopo_delivery/modules/profile/model/profile_model.dart';
import 'package:shopo_delivery/modules/withdraw/components/withdraw_dialog.dart';
import 'package:shopo_delivery/modules/withdraw/model/withdraw_model.dart';
import '../../../modules/dashboard/model/dashboard_model.dart';
import '../../../modules/setting/model/website_setup_model.dart';
import '../../../modules/withdraw/controller/create_withdraw/create_withdraw_state_model.dart';
import '../../../modules/withdraw/model/account_info_model.dart';
import '../../../modules/withdraw/model/method_model.dart';
import '../../remote_urls.dart';
import '/core/data/datasources/network_parser.dart';

import '../../../modules/authentication/models/set_password_model.dart';
import '../../../modules/authentication/models/user_login_response_model.dart';

Map<String, dynamic> myMap = {};

abstract class RemoteDataSource {
  Future<UserLoginResponseModel> signIn(Map<String, dynamic> body);
  Future<WebsiteSetupModel> websiteSetup();
  Future<String> logOut(String token);

  Future<DashboardModel> getDashboardData(String token);

  Future<String> sendForgotPassCode(Map<String, dynamic> body);

  Future<String> setPassword(SetPasswordModel body);

  Future<String> sendActiveAccountCode(String email);

  Future<String> activeAccountCodeSubmit(String code);

  Future<String> userRegister(Map<String, dynamic> userInfo);

  Future<DeliveryManProfile> deliveryManProfileInfo(String token);

  Future<String> profileUpdate(DeliveryMan deliveryMan, String token);

  Future<AccountInfoModel> getAccountInformation(String id, String token);

  Future<List<MethodModel>> getAllMethodList(String token);
  Future<List<WithdrawModel>> getAllWithdrawList(String token);

  Future<String> createWithdrawMethod(
      CreateWithdrawStateModel body, String token);

  Future<List<OrderModel>> getRequestOrders(String token);
  Future<List<OrderModel>> getRunningOrders(String token);
  Future<List<OrderModel>> getCompletedOrders(String token);
  Future<OrderDetailsModel> getOrderDetails(String id, String token);
  Future<String> orderRequestUpdate(
      String id, Map<String, String> map, String token);

  Future<String> orderRunningUpdate(
      String id, Map<String, String> map, String token);
}

typedef CallClientMethod = Future<http.Response> Function();

class RemoteDataSourceImpl implements RemoteDataSource {
  final http.Client client;
  final dio = Dio(
    BaseOptions(
      baseUrl: "http://10.0.2.2:8000",
      receiveTimeout: const Duration(seconds: 3),
      // 15 seconds
      connectTimeout: const Duration(seconds: 3),
      sendTimeout: const Duration(seconds: 3),
      headers: {
        Headers.acceptHeader: 'application/json',
        Headers.contentTypeHeader: 'application/json',
      },
    ),
  );

  RemoteDataSourceImpl({required this.client});

  @override
  Future<UserLoginResponseModel> signIn(Map body) async {
    final headers = {'Accept': 'application/json'};
    final uri = Uri.parse(RemoteUrls.userLogin);

    final clientMethod = client.post(uri, headers: headers, body: body);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return UserLoginResponseModel.fromMap(responseJsonBody);
  }

  @override
  Future<String> logOut(String token) async {
    final headers = {'Accept': 'application/json'};
    final uri = Uri.parse(RemoteUrls.userLogOut(token));

    final clientMethod = client.get(uri, headers: headers);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['notification'] as String;
  }

  @override
  Future<WebsiteSetupModel> websiteSetup() async {
    final uri = Uri.parse(RemoteUrls.websiteSetup);

    final clientMethod = client.get(
      uri,
      headers: {'Content-Type': 'application/json'},
    );
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    Map<String, dynamic> data = responseJsonBody['language'];
    data.forEach((key, value) {
      var newKey = key
          .toString()
          .replaceAll("-", " ")
          .replaceAll(",", "")
          .replaceAll(".", "")
          .replaceAll("'", "")
          .replaceAll("!", "")
          .replaceAll(' ', '_');
      myMap[newKey] = value;
    });
    return WebsiteSetupModel.fromMap(responseJsonBody);
  }

  @override
  Future<String> sendForgotPassCode(Map<String, dynamic> body) async {
    final uri = Uri.parse(RemoteUrls.sendForgetPassword);

    final clientMethod = client.post(
      uri,
      headers: {'Accept': 'application/json'},
      body: body,
    );
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['notification'];
  }

  @override
  Future<String> setPassword(SetPasswordModel body) async {
    final uri = Uri.parse(RemoteUrls.storeResetPassword(body.code));

    final clientMethod = client.post(
      uri,
      headers: {'Accept': 'application/json'},
      body: body.toMap(),
    );
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['notification'];
  }

  @override
  Future<String> sendActiveAccountCode(String email) async {
    final uri = Uri.parse(RemoteUrls.resendRegisterCode);

    final clientMethod = client.post(
      uri,
      headers: {'Accept': 'application/json'},
      body: {'email': email},
    );
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['notification'];
  }

  @override
  Future<String> activeAccountCodeSubmit(String code) async {
    final uri = Uri.parse(RemoteUrls.userVerification(code));

    final clientMethod =
        client.get(uri, headers: {'Accept': 'application/json'});

    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['notification'];
  }

  @override
  Future<String> userRegister(Map<String, dynamic> userInfo) async {
    final uri = Uri.parse(RemoteUrls.userRegister);

    final clientMethod = client.post(
      uri,
      headers: {'Accept': 'application/json'},
      body: userInfo,
    );
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['notification'];
  }

  @override
  Future<DashboardModel> getDashboardData(String token) async {
    final uri = Uri.parse(RemoteUrls.getDashboardData(token));
    final headers = {'Accept': 'application/json'};
    final clientMethod = client.get(uri, headers: headers);
    final callClientMethod =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return DashboardModel.fromMap(callClientMethod);
  }

  @override
  Future<DeliveryManProfile> deliveryManProfileInfo(String token) async {
    final url = Uri.parse(RemoteUrls.deliveryManProfileUrl(token));
    final headers = {'Accept': 'application/json'};
    final clientMethod = client.get(url, headers: headers);
    final sellerResponse =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return DeliveryManProfile.fromMap(sellerResponse);
  }

  @override
  Future<String> profileUpdate(DeliveryMan deliveryMan, String token) async {
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    final uri = Uri.parse(RemoteUrls.updateProfile(token));
    print("test: ${deliveryMan.toMap()}");

    final request = http.MultipartRequest('POST', uri);
    request.fields.addAll(deliveryMan.toMap());

    request.headers.addAll(headers);
    if (deliveryMan.manImage.isNotEmpty) {
      final file =
          await http.MultipartFile.fromPath('man_image', deliveryMan.manImage);
      request.files.add(file);
    }

    http.StreamedResponse response = await request.send();
    final clientMethod = http.Response.fromStream(response);

    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['message']['messege'] as String;
  }

  @override
  Future<List<OrderModel>> getRequestOrders(String token) async {
    final headers = {'Accept': 'application/json'};
    final uri = Uri.parse(RemoteUrls.requesetOrderUrl(token));

    final clientMethod = client.get(uri, headers: headers);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    final mapList = responseJsonBody['orders'] as List;

    return List<OrderModel>.from(mapList.map((e) => OrderModel.fromMap(e)));
  }

  @override
  Future<List<OrderModel>> getRunningOrders(String token) async {
    final headers = {'Accept': 'application/json'};
    final uri = Uri.parse(RemoteUrls.runningOrderUrl(token));

    final clientMethod = client.get(uri, headers: headers);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    final mapList = responseJsonBody['orders'] as List;

    return List<OrderModel>.from(mapList.map((e) => OrderModel.fromMap(e)));
  }

  @override
  Future<List<OrderModel>> getCompletedOrders(String token) async {
    final headers = {'Accept': 'application/json'};
    final uri = Uri.parse(RemoteUrls.completeOrderUrl(token));

    final clientMethod = client.get(uri, headers: headers);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    final mapList = responseJsonBody['orders'] as List;

    return List<OrderModel>.from(mapList.map((e) => OrderModel.fromMap(e)));
  }

  @override
  Future<OrderDetailsModel> getOrderDetails(String id, String token) async {
    final url = Uri.parse(RemoteUrls.orderDetailsUrl(id, token));
    final headers = {
      'Accept': 'application/json',
      //'Content-Type': 'application/json'
    };
    final clientMethod = client.get(url);
    final responseBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);

    return OrderDetailsModel.fromMap(responseBody['order']);
  }

  @override
  Future<String> orderRequestUpdate(
      String id, Map<String, String> map, String token) async {
    final url = Uri.parse(RemoteUrls.orderRequestUpdateUrl(id, token));
    final headers = {
      'Accept': 'application/json',
      //'Content-Type': 'application/json'
    };
    final clientMethod = client.put(url, body: map, headers: headers);
    final responseBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);

    return responseBody['message']['messege'];
  }

  @override
  Future<List<WithdrawModel>> getAllWithdrawList(String token) async {
    final url = Uri.parse(RemoteUrls.allWithdrawList(token));
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    final clientMethod = client.get(url, headers: headers);
    final responseBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    final methodList = responseBody["withdraws"] as List;

    return List<WithdrawModel>.from(
        methodList.map((e) => WithdrawModel.fromMap(e)));
  }

  @override
  Future<String> createWithdrawMethod(
      CreateWithdrawStateModel body, String token) async {
    final url = Uri.parse(RemoteUrls.createWithdrawMethod(token));
    final headers = {
      'Accept': 'application/json',
      //'Content-Type': 'application/json'
    };
    final clientMethod = client.post(url, headers: headers, body: body.toMap());
    final responseBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);

    return responseBody["notification"] as String;
  }

  @override
  Future<AccountInfoModel> getAccountInformation(
      String id, String token) async {
    final url = Uri.parse(RemoteUrls.getAccountInformation(id, token));
    final headers = {
      'Accept': 'application/json',
      //'Content-Type': 'application/json'
    };
    final clientMethod = client.get(url);
    final responseBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);

    return AccountInfoModel.fromMap(responseBody["method"]);
  }

  @override
  Future<List<MethodModel>> getAllMethodList(String token) async {
    final url = Uri.parse(RemoteUrls.getAllMethodList(token));
    final headers = {
      'Accept': 'application/json',
      //'Content-Type': 'application/json'
    };
    final clientMethod = client.get(url);
    final responseBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    final methodList = responseBody["methods"] as List;

    return List<MethodModel>.from(
        methodList.map((account) => MethodModel.fromMap(account))).toList();
  }

  @override
  Future<String> orderRunningUpdate(String id, Map<String, String> map, String token)async {
    final url = Uri.parse(RemoteUrls.orderRunningUpdateUrl(id, token));
    final headers = {
      'Accept': 'application/json',
      //'Content-Type': 'application/json'
    };
    final clientMethod = client.put(url, body: map, headers: headers);
    final responseBody =
    await NetworkParser.callClientWithCatchException(() => clientMethod);

    return responseBody['message']['messege'];
  }
}
