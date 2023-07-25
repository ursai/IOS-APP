class NetworkConfig {
  static const String baseUrl = 'http://35.89.119.204:7010/';
  static const connectTimeOut = Duration(seconds: 10);
  static const receiveTimeOut = Duration(seconds: 30);
  static const sendTimeOut = Duration(seconds: 30);
  static Map<String, dynamic> headers = {};
  static const successCode = 200;
  static const businessSuccessCode = 0;
}

class BusinessCode {
  static const forbidden = 403;
  static const tokenExpired = 1001;
  static const tokenVerifyFailed = 1002;
  static const invalidToken = 1004;
  static const invalidAccount = 1201;
}
