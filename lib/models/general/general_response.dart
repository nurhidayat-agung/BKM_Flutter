class GeneralResponse {
  final String? status;
  final String? message;

  GeneralResponse({
    this.status,
    this.message,
  });

  factory GeneralResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return GeneralResponse();

    return GeneralResponse(
      status: _safeString(json['status']),
      message: _safeString(json['message']),
    );
  }
}

// ---------------- SAFE CAST HELPER ----------------

String? _safeString(dynamic value) {
  try {
    if (value == null) return null;
    return value.toString();
  } catch (_) {
    return null;
  }
}
