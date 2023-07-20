class NetworkConfig {
  //static const String baseUrl = "https://api.dev.1mile.space/";
  static const String baseUrl = 'https://api.prod.1mile.space/';
  static const connectTimeOut = Duration(seconds: 10);
  static const receiveTimeOut = Duration(seconds: 30);
  static const sendTimeOut = Duration(seconds: 30);
  static Map<String, dynamic> headers = {};
  static const successCode = 200;
  static const businessSuccessCode = 0;
}

class WebViewConfig {
  static const String base_url = 'http://1mile.space:8012/app/';
}

class BusinessCode {
  static const forbidden = 403;
  static const tokenExpired = 1001;
  static const tokenVerifyFailed = 1002;
  static const invalidToken = 1004;
  static const invalidAccount = 1201;
  // 余额不足
  static const insufficientBalance = 1208;
}
