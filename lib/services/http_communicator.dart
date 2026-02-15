import 'dart:convert';
import 'dart:io';
import 'package:alice/model/alice_http_call.dart';
import 'package:alice/model/alice_http_error.dart';
import 'package:alice/model/alice_http_request.dart';
import 'package:alice/model/alice_http_response.dart';
import 'package:http/http.dart' as http;
import 'package:newbkmmobile/repositories/session_manager_repository.dart';

import '../main.dart';

/// Helper HTTP Client menggunakan package http
/// Support:
/// - GET
/// - POST JSON
/// - POST FormData (multipart)
class HttpCommunicator {
  final String baseUrl = 'https://api.berkatkarimar.co.id/api';


  /// Refresh token
  Future<String?> refreshToken() async {
    final uri = Uri.parse('$baseUrl/login');

    final driver = await SessionManager.getUserSession();

    try {
      final request = http.Request('POST', uri);

      request.headers.addAll({
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'X-Client-Type': 'mobile',
      });

      request.body = jsonEncode({
        "phone": driver?.userLogin ?? "",
        "password": driver?.password,
      });

      final response = await _sendWithAlice(request);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final refreshedToken = json["data"]["token"];

        if (driver != null) {
          driver.token = refreshedToken;
          await SessionManager.saveUserSession(driver);
        }

        return refreshedToken;
      }

      return null;
    } on SocketException {
      return null;
    } catch (_) {
      return null;
    }
  }


  /// =========================
  /// GET JSON
  /// =========================
  Future<HttpResponse> getJson(
      String endpoint, {
        Map<String, String>? headers,
        Map<String, dynamic>? body,
      }) async {

    final uri = Uri.parse('$baseUrl/$endpoint');

    final mergedHeaders = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'X-Client-Type': 'mobile',
      if (headers != null) ...headers,
    };

    final driver = await SessionManager.getUserSession();
    if (driver?.siteId != null) {
      mergedHeaders['X-Site-ID'] = driver!.siteId!;
    }

    try {
      /// ===== REQUEST PERTAMA =====
      var request = http.Request('GET', uri);
      request.headers.addAll(mergedHeaders);

      if (body != null) {
        request.body = jsonEncode(body);
      }

      var response = await _sendWithAlice(request);

      /// ===== JIKA TOKEN EXPIRED =====
      if (response.statusCode == 401) {
        final newToken = await refreshToken();

        if (newToken != null) {
          final retryRequest = http.Request('GET', uri);

          retryRequest.headers.addAll({
            ...mergedHeaders,
            'Authorization': 'Bearer $newToken',
          });

          if (body != null) {
            retryRequest.body = jsonEncode(body);
          }

          response = await _sendWithAlice(retryRequest);
        }
      }

      return _handleResponse(response);
    } on SocketException {
      throw Exception('Tidak ada koneksi internet');
    } catch (e) {
      throw Exception('Gagal GET JSON: $e');
    }
  }



  /// --------------------------------------------------------------------------
  /// GET REQUEST
  Future<HttpResponse> get(
      String endpoint, {
        Map<String, String>? headers,
      }) async {

    final uri = Uri.parse('$baseUrl/$endpoint');

    final mergedHeaders = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'X-Client-Type': 'mobile',
      if (headers != null) ...headers,
    };

    final driver = await SessionManager.getUserSession();
    if (driver?.siteId != null) {
      mergedHeaders['X-Site-ID'] = driver!.siteId!;
    }

    try {
      /// ===== REQUEST PERTAMA =====
      var request = http.Request('GET', uri);
      request.headers.addAll(mergedHeaders);

      var response = await _sendWithAlice(request);

      /// ===== TOKEN EXPIRED =====
      if (response.statusCode == 401) {
        final newToken = await refreshToken();

        if (newToken != null) {
          request = http.Request('GET', uri);
          request.headers.addAll({
            ...mergedHeaders,
            'Authorization': 'Bearer $newToken',
          });

          response = await _sendWithAlice(request);
        }
      }

      return _handleResponse(response);
    } on SocketException {
      throw Exception('Tidak ada koneksi internet');
    } catch (e) {
      throw Exception('Gagal GET: $e');
    }
  }



  /// --------------------------------------------------------------------------
  /// POST JSON REQUEST
  Future<HttpResponse> postJson(
      String endpoint, {
        required Map<String, dynamic> body,
        Map<String, String>? headers,
      }) async {

    final uri = Uri.parse('$baseUrl/$endpoint');

    final mergedHeaders = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'X-Client-Type': 'mobile',
      if (headers != null) ...headers,
    };

    final driver = await SessionManager.getUserSession();
    if (driver?.siteId != null) {
      mergedHeaders['X-Site-ID'] = driver!.siteId!;
    }

    try {
      /// ===== REQUEST PERTAMA =====
      var request = http.Request('POST', uri);
      request.headers.addAll(mergedHeaders);
      request.body = jsonEncode(body);

      var response = await _sendWithAlice(request);

      /// ===== TOKEN EXPIRED =====
      if (response.statusCode == 401) {
        final newToken = await refreshToken();

        if (newToken != null) {
          request = http.Request('POST', uri);
          request.headers.addAll({
            ...mergedHeaders,
            'Authorization': 'Bearer $newToken',
          });
          request.body = jsonEncode(body);

          response = await _sendWithAlice(request);
        }
      }

      return _handleResponse(response);
    } on SocketException {
      throw Exception('Tidak ada koneksi internet');
    } catch (e) {
      throw Exception('Gagal POST JSON: $e');
    }
  }



  /// --------------------------------------------------------------------------
  /// PUT JSON REQUEST
  Future<HttpResponse> putJson(
      String endpoint, {
        required Map<String, dynamic> body,
        Map<String, String>? headers,
      }) async {

    final uri = Uri.parse('$baseUrl/$endpoint');

    final mergedHeaders = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'X-Client-Type': 'mobile',
      if (headers != null) ...headers,
    };

    final driver = await SessionManager.getUserSession();
    if (driver?.siteId != null) {
      mergedHeaders['X-Site-ID'] = driver!.siteId!;
    }

    try {
      /// ===== REQUEST PERTAMA =====
      var request = http.Request('PUT', uri);
      request.headers.addAll(mergedHeaders);
      request.body = jsonEncode(body);

      var response = await _sendWithAlice(request);

      /// ===== TOKEN EXPIRED =====
      if (response.statusCode == 401) {
        final newToken = await refreshToken();

        if (newToken != null) {
          request = http.Request('PUT', uri);
          request.headers.addAll({
            ...mergedHeaders,
            'Authorization': 'Bearer $newToken',
          });
          request.body = jsonEncode(body);

          response = await _sendWithAlice(request);
        }
      }

      return _handleResponse(response);
    } on SocketException {
      throw Exception('Tidak ada koneksi internet');
    } catch (e) {
      throw Exception('Gagal PUT JSON: $e');
    }
  }




  /// --------------------------------------------------------------------------
  /// POST FORM DATA REQUEST (MULTIPART)
  Future<HttpResponse> postFormData(
      String endpoint, {
        required Map<String, String> fields,
        Map<String, File>? files,
        Map<String, String>? headers,
      }) async {

    final uri = Uri.parse('$baseUrl/$endpoint');

    final driver = await SessionManager.getUserSession();
    final siteId = driver?.siteId;

    /// ===============================
    /// Function untuk build request
    /// ===============================
    Future<http.MultipartRequest> buildRequest(String? newToken) async {
      final request = http.MultipartRequest('POST', uri);

      final mergedHeaders = {
        'Accept': 'application/json',
        'X-Client-Type': 'mobile',
        if (headers != null) ...headers,
      };

      if (siteId != null) {
        mergedHeaders['X-Site-ID'] = siteId;
      }

      if (newToken != null) {
        mergedHeaders['Authorization'] = 'Bearer $newToken';
      }

      request.headers.addAll(mergedHeaders);

      // Add fields
      request.fields.addAll(fields);

      // Add files
      if (files != null) {
        for (final entry in files.entries) {
          final file = entry.value;
          final fileName =
              file.path.split(Platform.pathSeparator).last;

          request.files.add(
            await http.MultipartFile.fromPath(
              entry.key,
              file.path,
              filename: fileName,
            ),
          );
        }
      }

      return request;
    }

    try {
      /// ===== REQUEST PERTAMA =====
      var request = await buildRequest(null);
      var response = await _sendWithAlice(request);

      /// ===== TOKEN EXPIRED =====
      if (response.statusCode == 401) {
        final newToken = await refreshToken();

        if (newToken != null) {
          final retryRequest = await buildRequest(newToken);
          response = await _sendWithAlice(retryRequest);
        }
      }

      return _handleResponse(response);
    } on SocketException {
      throw Exception('Tidak ada koneksi internet');
    } catch (e) {
      throw Exception('Gagal POST FormData: $e');
    }
  }



  /// --------------------------------------------------------------------------
  /// HANDLER UNTUK RESPONSE SERVER
  HttpResponse _handleResponse(http.Response response) {
    final statusCode = response.statusCode;
    dynamic body;
    try {
      body = response.body.isNotEmpty ? jsonDecode(response.body) : null;
    } catch (_) {
      body = null;
    }

    return HttpResponse(
      status: statusCode,
      result: body,
    );
  }
}

/// --------------------------------------------------------------------------
/// CLASS UNTUK RETURN TYPE
class HttpResponse {
  final int status;
  final dynamic? result;

  HttpResponse({
    required this.status,
    this.result,
  });
}

Future<http.Response> _sendWithAlice(http.BaseRequest request) async {
  final call = AliceHttpCall(
    DateTime.now().millisecondsSinceEpoch,
  );

  call.method = request.method;
  call.uri = request.url.toString();
  call.server = request.url.host;
  call.endpoint = request.url.path;

  // ===== SET REQUEST =====
  final aliceRequest = AliceHttpRequest();
  aliceRequest.headers = request.headers;
  aliceRequest.contentType = request.headers['Content-Type'];

  if (request is http.Request) {
    aliceRequest.body = request.body;
  } else if (request is http.MultipartRequest) {
    aliceRequest.body = request.fields;
  }

  call.request = aliceRequest;

  final stopwatch = Stopwatch()..start();

  try {
    final streamed = await request.send();
    final response = await http.Response.fromStream(streamed);

    stopwatch.stop();

    // ===== SET RESPONSE =====
    final aliceResponse = AliceHttpResponse();
    aliceResponse.status = response.statusCode;
    aliceResponse.headers = response.headers;
    aliceResponse.body = response.body;

    call.duration = stopwatch.elapsedMilliseconds;
    call.response = aliceResponse;
    call.loading = false;

    alice.addHttpCall(call);

    return response;
  } catch (e) {
    stopwatch.stop();

    final error = AliceHttpError();
    error.error = e.toString();

    call.error = error;
    call.duration = stopwatch.elapsedMilliseconds;
    call.loading = false;

    alice.addHttpCall(call);

    rethrow;
  }
}



