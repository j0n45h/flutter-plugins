part of weather_library;

/// Safely unpack an int value from a [Map] object.
int _unpackInt(Map<String, dynamic>? M, String k) {
  if (M != null) {
    if (M.containsKey(k)) {
      final val = M[k];
      if (val.runtimeType == String) {
        return int.tryParse(val) ?? -1;
      }
      else if (val.runtimeType == int || val.runtimeType == double) {
        return val.round();
      }
      return -1;
    }
  }
  return 0;
}

/// Safely unpack a double value from a [Map] object.
double _unpackDouble(Map<String, dynamic>? M, String k) {
  if (M != null) {
    if (M.containsKey(k)) {
      final val = M[k];
      if (val.runtimeType == double || val.runtimeType == int)
        return val.toDouble();
      else if (val.runtimeType == String)
        return double.tryParse(val) ?? 0.0;
    }
  }
  return 0.0;
}

/// Safely unpack a string value from a [Map] object.
String _unpackString(Map<String, dynamic>? M, String k) {
  if (M != null) {
    if (M.containsKey(k)) {
      return M[k].toString();
    }
  }
  return "";
}

/// Safely unpacks a unix timestamp from a [Map] object,
/// i.e. an integer value of milliseconds and converts this to a [DateTime] object.
DateTime? _unpackDate(Map<String, dynamic>? M, String k) {
  if (M != null) {
    if (M.containsKey(k)) {
      final val = M[k];
      int? millis;
      if (val.runtimeType == double || val.runtimeType == int)
        millis = (val * 1000).round();
      else if (val.runtimeType == String)
        millis = ((double.tryParse(val) ?? 0.0) * 1000).round();

      if (millis != null)
        return DateTime.fromMillisecondsSinceEpoch(millis);
    }
  }
  return null;
}

/// Unpacks a [double] value from a [Map] object and converts this to
/// a [Temperature] object.
Temperature _unpackTemperature(Map<String, dynamic>? M, String k) {
  double kelvin = _unpackDouble(M, k);
  return Temperature(kelvin);
}
