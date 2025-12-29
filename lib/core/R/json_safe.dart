T? safeCast<T>(dynamic value) {
  try {
    return value as T;
  } catch (_) {
    return null;
  }
}

String? safeString(dynamic value) {
  if (value == null) return null;
  return value.toString();
}

int? safeInt(dynamic value) {
  if (value == null) return null;
  if (value is int) return value;
  return int.tryParse(value.toString());
}

double? safeDouble(dynamic value) {
  if (value == null) return null;
  if (value is double) return value;
  if (value is int) return value.toDouble();
  return double.tryParse(value.toString());
}

bool? safeBool(dynamic value) {
  if (value == null) return null;
  if (value is bool) return value;
  if (value is int) return value == 1;
  return value.toString() == 'true';
}

Map<String, dynamic>? safeMap(dynamic value) {
  if (value is Map<String, dynamic>) return value;
  return null;
}

List<dynamic>? safeList(dynamic value) {
  if (value is List) return value;
  return null;
}


T? safeParse<T>(dynamic value, T Function(dynamic v) parser) {
  try {
    if (value == null) return null;
    return parser(value);
  } catch (_) {
    return null;
  }
}
