class RemoteUrls {
  static const String rootUrl = "https://api.websolutionus.com/shopo-test/";
  // static const String rootUrl = "https://shopotest.minionionbd.com/";
  // static const String rootUrl = "https://api.websolutionus.com/shopo-v3/";

  static const String baseUrl = '${rootUrl}api/';
  static const String homeUrl = baseUrl;
  static const String userRegister = '${baseUrl}store-register';
  static const String userLogin = '${baseUrl}deliveryman/login';

  static String userLogOut(String token) =>
      '${baseUrl}deliveryman/logout?token=$token';
  static const String sendForgetPassword = '${baseUrl}send-forget-password';
  static const String resendRegisterCode = '${baseUrl}resend-register-code';

  static String storeResetPassword(String code) =>
      '${baseUrl}store-reset-password/$code';

  static String userVerification(String code) =>
      '${baseUrl}user-verification/$code';

  static const String websiteSetup = '${baseUrl}website-setup';

  static String getDashboardData(String token) =>
      "${baseUrl}deliveryman/dashboard?token=$token";

  static String deliveryManProfileUrl(String token) =>
      "${baseUrl}deliveryman/my-profile?token=$token";

  static String updateProfile(String token) =>
      '${baseUrl}deliveryman/update-profile?token=$token';

  static String allWithdrawList(String token) =>
      "${baseUrl}deliveryman/withdraw?token=$token";

  static String createWithdrawMethod(String token) =>
      "${baseUrl}deliveryman/withdraw?token=$token";

  static String getAccountInformation(String id, String token) =>
      "${baseUrl}deliveryman/get-withdraw-account-info/$id?token=$token";

  static String getAllMethodList(String token) =>
      "${baseUrl}deliveryman/withdraw/create?token=$token";

  static String requesetOrderUrl(String token) =>
      "${baseUrl}deliveryman/order-request?token=$token";

  static String runningOrderUrl(String token) =>
      "${baseUrl}deliveryman/orders?token=$token";

  static String completeOrderUrl(String token) =>
      "${baseUrl}deliveryman/completed-order?token=$token";

  static String orderDetailsUrl(String id, String token) =>
      "${baseUrl}deliveryman/order-show/$id?token=$token";

  static String orderRequestUpdateUrl(String id, String token) =>
      "${baseUrl}deliveryman/order-request-status/$id?token=$token";

  static String orderRunningUpdateUrl(String id, String token) =>
      "${baseUrl}deliveryman/update-order-status/$id?token=$token";

  static imageUrl(String imageUrl) => rootUrl + imageUrl;
}
