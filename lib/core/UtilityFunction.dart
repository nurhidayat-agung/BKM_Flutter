class UtilityFunction{
  static bool isSuccessApiResponse(
      dynamic response, {
        void Function(String message)? onMessage,
      }) {
    if (response is Map<String, dynamic>) {
      final status = response['status'];
      final message = response['message'];

      if (status == 'success' && message != null) {
        onMessage?.call(message.toString());
        return true;
      }
    }
    return false;
  }

  static String normalizeNumber(String value) {
    if (value.trim().isEmpty) return value;

    final parsed = int.tryParse(value);
    if (parsed == null) return value;

    return parsed.toString(); // otomatis hilang 0 di depan
  }


}