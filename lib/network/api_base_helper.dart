import 'dart:io';

import 'package:dio/dio.dart';
import 'package:newbkmmobile/core/constants.dart';
import 'package:newbkmmobile/core/failure.dart';
import 'package:newbkmmobile/core/r.dart';
import 'package:newbkmmobile/models/error_resp.dart';
import 'package:newbkmmobile/repositories/login_repository.dart';

class APIBaseHelper {
  final Dio _dio = Dio();
  final _baseUrl = Constants.baseUrl;

  Future<Response> get(String url) async {
    var responseJson;
    var token = "";
    var userId = "";
    final loginLocal = await LoginRepository().getLoginLocal();
    if (loginLocal.isNotEmpty) {
      token = loginLocal[0].token;
      userId = loginLocal[0].userId;
    }
    try {
      final response = await _dio.get(
        _baseUrl + url,
        options: Options(
          headers: {
            "Client-Service": "driver-client",
            "Auth-Key": "bkmrestapi",
            "Content-Type": "application/json",
            "Authorization": token,
            "User-ID": userId,
          },
        ),
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw ErrorException(R.strings.noInternetConnection);
    }

    return responseJson;
  }

  Future<Response> post(String url, {required FormData formData}) async {
    var responseJson;
    var token = "";
    var userId = "";
    final loginLocal = await LoginRepository().getLoginLocal();
    if (loginLocal.isNotEmpty) {
      token = loginLocal[0].token;
      userId = loginLocal[0].userId;
    }
    try {
      final response = await _dio.post(
        _baseUrl + url,
        options: Options(
          headers: {
            "Client-Service": "driver-client",
            "Auth-Key": "bkmrestapi",
            "Content-Type": "application/json",
            "Authorization": token,
            "User-ID": userId,
          },
        ),
        data: formData,
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw ErrorException(R.strings.noInternetConnection);
    }

    return responseJson;
  }

  dynamic _returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        return response;
      default:
        final result = ErrorResp.fromJson(response.data);
        throw ErrorException(result.message);
    }
  }

}