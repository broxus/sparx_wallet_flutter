import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

@singleton
class ResourcesService {
  Future<String> loadString(String key, {bool cache = true}) {
    return rootBundle.loadString(key, cache: cache);
  }
}
