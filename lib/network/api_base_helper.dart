import 'dart:io';

import 'package:dio/dio.dart';
import 'package:newbkmmobile/core/constants.dart';
import 'package:newbkmmobile/core/storage_helper.dart';
import 'package:newbkmmobile/models/error_resp.dart';
import 'api_exception.dart';

class APIBaseHelper {
  final Dio _dio = Dio();
  final _baseUrl = Constants.baseUrl;
  final storageHelper = StorageHelper();

  Future<Response> get(String url) async {
    var responseJson;
    var token = await storageHelper.getString(Constants.token);
    var userId = await storageHelper.getString(Constants.userId);
    try {
      final response = await _dio.get(
        _baseUrl + url,
        options: Options(
          headers: {
            "Client-Service": "driver-client",
            "Auth-Key": "bkmrestapi",
            "Content-Type": "application/json",
            // "responseType": ResponseType.plain,
            // "Charset": "utf-8",
            "Authorization": token,
            "User-ID": userId,
          },
        ),
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw ErrorException("No internet connection");
    }

    return responseJson;
  }

  Future<Response> post(String url, {required FormData formData}) async {
    var responseJson;
    var token = await storageHelper.getString(Constants.token);
    var userId = await storageHelper.getString(Constants.userId);
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
      throw ErrorException("No internet connection");
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