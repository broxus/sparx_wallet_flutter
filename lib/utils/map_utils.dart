Map<String, dynamic> mergeMaps(
  Map<String, dynamic> first,
  Map<String, dynamic> second,
) {
  final result = <String, dynamic>{...first};

  second.forEach(
    (key, secondValue) {
      if (result.containsKey(key)) {
        final firstVal = result[key];

        if (firstVal is Map && secondValue is Map) {
          result[key] = mergeMaps(
            Map<String, dynamic>.from(firstVal),
            Map<String, dynamic>.from(secondValue),
          );
        } else {
          result[key] = secondValue;
        }
      } else {
        result[key] = secondValue;
      }
    },
  );

  return result;
}
