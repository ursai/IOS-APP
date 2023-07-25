import 'package:app/models/base_model.dart';
import 'package:app/network/network_config.dart';
import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiClient {
  late Dio _dio;

  Map<String, dynamic> errorCodeMap = {};

  static final ApiClient _apiClient = ApiClient._internal();

  factory ApiClient() {
    return _apiClient;
  }

  ApiClient._internal() {
    var options = BaseOptions(
        baseUrl: NetworkConfig.baseUrl,
        receiveTimeout: NetworkConfig.receiveTimeOut,
        connectTimeout: NetworkConfig.connectTimeOut,
        sendTimeout: NetworkConfig.sendTimeOut,
        responseType: ResponseType.json);
    _dio = Dio(options);
    _dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
    ));
    _dio.interceptors.add(RetryInterceptor(
        dio: _dio,
        retries: 3,
        retryDelays: const [
          Duration(seconds: 5),
          Duration(seconds: 10),
          Duration(seconds: 15)
        ]));
  }

  void get(String path,
      {bool isShowLoading = true,
      Map<String, dynamic>? queryParameters,
      Function? errorCallback,
      Function? successCallback}) async {
    Response response;
    try {
      if (isShowLoading) EasyLoading.show();
      Options options = Options(headers: NetworkConfig.headers);
      response = await _dio.get(path,
          queryParameters: queryParameters, options: options);
      if (isShowLoading) EasyLoading.dismiss();
      _handleResponse(response,
          successCallback: successCallback, errorCallback: errorCallback);
    } on DioException catch (e) {
      _handleError(e, errorCallback: errorCallback);
    }
  }

  void post(String path,
      {bool isShowLoading = true,
      Object? data,
      Function? errorCallback,
      Function? successCallback}) async {
    Response response;
    try {
      if (isShowLoading) EasyLoading.show();
      Options options = Options(headers: NetworkConfig.headers);
      response = await _dio.post(path, data: data, options: options);
      if (isShowLoading) EasyLoading.dismiss();
      _handleResponse(response,
          successCallback: successCallback, errorCallback: errorCallback);
    } on DioException catch (e) {
      _handleError(e, errorCallback: errorCallback);
    }
  }

  void delete(String path,
      {bool isShowLoading = true,
      Map<String, dynamic>? queryParameters,
      Function? errorCallback,
      Function? successCallback}) async {
    Response response;
    try {
      if (isShowLoading) EasyLoading.show();
      Options options = Options(headers: NetworkConfig.headers);
      response = await _dio.delete(path,
          queryParameters: queryParameters, options: options);
      if (isShowLoading) EasyLoading.dismiss();
      _handleResponse(response,
          successCallback: successCallback, errorCallback: errorCallback);
    } on DioException catch (e) {
      _handleError(e, errorCallback: errorCallback);
    }
  }

  void put(String path,
      {bool isShowLoading = true,
      Object? data,
      Function? errorCallback,
      Function? successCallback}) async {
    Response response;
    try {
      if (isShowLoading) EasyLoading.show();
      Options options = Options(headers: NetworkConfig.headers);
      response = await _dio.put(path, data: data, options: options);
      if (isShowLoading) EasyLoading.dismiss();
      _handleResponse(response,
          successCallback: successCallback, errorCallback: errorCallback);
    } on DioException catch (e) {
      _handleError(e, errorCallback: errorCallback);
    }
  }

  void _handleResponse(Response response,
      {Function? errorCallback, Function? successCallback}) {
    if (response.statusCode == NetworkConfig.successCode) {
      BaseModel baseModel = BaseModel.fromJson(response.data);
      if (baseModel.code == NetworkConfig.businessSuccessCode) {
        if (successCallback != null) {
          if (baseModel.data is List) {
            Map<String, dynamic> map = {'data': baseModel.data};
            successCallback(map);
          } else {
            successCallback(baseModel.data);
          }
        }
      } else {
        if (errorCallback != null) {
          errorCallback(baseModel.message);
        } else {
          EasyLoading.showToast(baseModel.message ?? '');
        }
      }
    }
  }

  /*
   * error统一处理
   */
  void _handleError(DioException e, {Function? errorCallback}) {
    EasyLoading.dismiss();
    if (e.type == DioExceptionType.connectionTimeout) {
      EasyLoading.showToast("连接超时");
    } else if (e.type == DioExceptionType.sendTimeout) {
      EasyLoading.showToast("请求超时");
    } else if (e.type == DioExceptionType.receiveTimeout) {
      EasyLoading.showToast("响应超时");
    } else if (e.type == DioExceptionType.badResponse) {
      if (e.response?.data != null) {
        BaseModel model = BaseModel.fromJson(e.response?.data);
        // 登陆出错
        if (model.code == BusinessCode.forbidden ||
            model.code == BusinessCode.invalidToken ||
            model.code == BusinessCode.tokenExpired ||
            model.code == BusinessCode.invalidAccount ||
            model.code == BusinessCode.tokenVerifyFailed) {}
        EasyLoading.showToast(errorCodeMap['${model.code}'] ?? model.message);

        if (errorCallback != null) {
          errorCallback(model);
        }
      } else {
        EasyLoading.showToast("出现异常");
      }
    } else {
      if (e.response?.data != null) {
        BaseModel model = BaseModel.fromJson(e.response?.data);
        EasyLoading.showToast("未知错误, 错误码：${model.code}, 错误信息：${model.message}");
      } else {
        EasyLoading.showToast("未知错误");
      }
    }
  }
}
