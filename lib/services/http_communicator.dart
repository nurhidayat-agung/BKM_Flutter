import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:newbkmmobile/repositories/session_manager_repository.dart';

/// Helper HTTP Client menggunakan package http
/// Support:
/// - GET
/// - POST JSON
/// - POST FormData (multipart)
class HttpCommunicator {
  final String baseUrl = 'https://api.berkatkarimar.co.id/api';


  /// Refresh token
  Future<String?> refreshToken() async {
    final url = Uri.parse('$baseUrl/login');

    final driver = await SessionManager.getUserSession();

    try {
      final response = await http.post(
        url,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'X-Client-Type': 'mobile',
        },
        body: jsonEncode({
          "phone": driver?.userLogin ?? "",
          "password": driver?.password,
        }),
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        var refreshedToken = json["data"]["token"];
        driver?.token = refreshedToken;

        await SessionManager.saveUserSession(driver!);

        return refreshedToken;
      }

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

    Future<http.Response> sendRequest(http.Request request) async {
      final streamed = await request.send();
      return await http.Response.fromStream(streamed);
    }

    /// ===== REQUEST PERTAMA =====
    http.Request request = http.Request('GET', uri);

    if (headers != null) {
      request.headers.addAll(headers);
    }

    if (body != null) {
      request.body = jsonEncode(body);
    }

    http.Response response = await sendRequest(request);

    /// ===== JIKA TOKEN EXPIRED =====
    if (response.statusCode == 401) {
      final newToken = await refreshToken();

      if (newToken != null) {
        /// BUAT REQUEST BARU (WAJIB!)
        final retryRequest = http.Request('GET', uri);

        retryRequest.headers.addAll({
          ...?headers,
          'Authorization': 'Bearer $newToken',
        });

        if (body != null) {
          retryRequest.body = jsonEncode(body);
        }

        response = await sendRequest(retryRequest);
      }
    }

    return _handleResponse(response);
  }


  /// --------------------------------------------------------------------------
  /// GET REQUEST
  Future<HttpResponse> get(
      String endpoint, {
        Map<String, String>? headers,
      }) async {
    final url = Uri.parse('$baseUrl/$endpoint');

    // Merge header awal
    final mergedHeaders = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'X-Client-Type': 'mobile',
      if (headers != null) ...headers,
    };

    try {
      // Request pertama
      var response = await http.get(url, headers: mergedHeaders);

      // Jika token kadaluarsa
      if (response.statusCode == 401) {
        // Ambil token baru
        final newToken = await refreshToken();

        if (newToken != null) {
          // HANYA replace Authorization
          mergedHeaders['Authorization'] = 'Bearer $newToken';

          // Retry request pakai token baru
          response = await http.get(url, headers: mergedHeaders);
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
    final url = Uri.parse('$baseUrl/$endpoint');

    // Gabungkan header
    final mergedHeaders = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      if (headers != null) ...headers,
    };

    try {
      // Request pertama
      var response = await http.post(
        url,
        headers: mergedHeaders,
        body: jsonEncode(body),
      );

      // Jika token kadaluarsa → refresh → retry
      if (response.statusCode == 401) {
        final newToken = await refreshToken();

        if (newToken != null) {
          // HANYA timpa Authorization
          mergedHeaders['Authorization'] = 'Bearer $newToken';

          response = await http.post(
            url,
            headers: mergedHeaders,
            body: jsonEncode(body),
          );
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
    final url = Uri.parse('$baseUrl/$endpoint');

    // Gabungkan header
    final mergedHeaders = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      if (headers != null) ...headers,
    };

    try {
      // Request pertama
      var response = await http.put(
        url,
        headers: mergedHeaders,
        body: jsonEncode(body),
      );

      // Jika token kadaluarsa → refresh → retry
      if (response.statusCode == 401) {
        final newToken = await refreshToken();

        if (newToken != null) {
          // Replace Authorization saja
          mergedHeaders['Authorization'] = 'Bearer $newToken';

          response = await http.put(
            url,
            headers: mergedHeaders,
            body: jsonEncode(body),
          );
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
    final url = Uri.parse('$baseUrl/$endpoint');

    // -------------------------------
    // Buat function untuk membangun ulang MultipartRequest
    // (dipakai saat retry)
    // -------------------------------
    Future<http.MultipartRequest> buildRequest(String? newToken) async {
      final req = http.MultipartRequest('POST', url);

      // Copy headers (TIDAK diubah kecuali Authorization)
      final mergedHeaders = {
        'Accept': 'application/json',
        'Content-Type': 'multipart/form-data',
        if (headers != null) ...headers,
      };

      if (newToken != null) {
        mergedHeaders['Authorization'] = 'Bearer $newToken';
      }

      req.headers.addAll(mergedHeaders);

      // Add fields
      req.fields.addAll(fields);

      // Add files
      if (files != null) {
        for (final entry in files.entries) {
          final file = entry.value;
          final fileName = file.path.split(Platform.pathSeparator).last;
          req.files.add(
            await http.MultipartFile.fromPath(
              entry.key,
              file.path,
              filename: fileName,
            ),
          );
        }
      }

      return req;
    }

    try {
      // -------------------------------
      // Request pertama
      // -------------------------------
      var request = await buildRequest(null);
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      // -------------------------------
      // Jika 401 → refresh token → retry sekali
      // -------------------------------
      if (response.statusCode == 401) {
        final newToken = await refreshToken();

        if (newToken != null) {
          // Build ulang request dengan token baru
          final retryRequest = await buildRequest(newToken);
          final retryStream = await retryRequest.send();
          response = await http.Response.fromStream(retryStream);
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
      result: statusCode >= 200 && statusCode < 300 ? body : null,
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
