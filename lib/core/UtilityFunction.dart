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

}