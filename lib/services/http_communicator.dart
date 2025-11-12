import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

/// Helper HTTP Client menggunakan package http
/// Support:
/// - GET
/// - POST JSON
/// - POST FormData (multipart)
class HttpCommunicator {
  final String baseUrl = 'https://api-dev.berkatkarimar.co.id/api';

  /// --------------------------------------------------------------------------
  /// GET REQUEST
  Future<HttpResponse> get(
      String endpoint, {
        Map<String, String>? headers,
      }) async {
    final url = Uri.parse('$baseUrl/$endpoint');
    final mergedHeaders = {
      'Accept': 'application/json',
      if (headers != null) ...headers,
    };

    try {
      final response = await http.get(url, headers: mergedHeaders);
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
    final mergedHeaders = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      if (headers != null) ...headers,
    };

    try {
      final response = await http.post(
        url,
        headers: mergedHeaders,
        body: jsonEncode(body),
      );
      return _handleResponse(response);
    } on SocketException {
      throw Exception('Tidak ada koneksi internet');
    } catch (e) {
      throw Exception('Gagal POST JSON: $e');
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
    final request = http.MultipartRequest('POST', url);

    // Tambahkan header
    request.headers.addAll({
      'Accept': 'application/json',
      if (headers != null) ...headers,
    });

    // Tambahkan field form biasa
    request.fields.addAll(fields);

    // Tambahkan file jika ada
    if (files != null) {
      for (final entry in files.entries) {
        final file = entry.value;
        final fileName = file.path.split(Platform.pathSeparator).last;
        request.files.add(
          await http.MultipartFile.fromPath(entry.key, file.path, filename: fileName),
        );
      }
    }

    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
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
