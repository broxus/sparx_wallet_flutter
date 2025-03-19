import 'package:flutter/rendering.dart';
import 'package:render_metrics/render_metrics.dart';

class BrowserRenderManager extends RenderParametersManager<String> {
  final _idCache = <String>{};

  void add(String id, RenderObject renderObject) {
    addRenderObject(id, renderObject);
    _idCache.add(id);
  }

  void remove(String id) {
    removeRenderObject(id);
    _idCache.remove(id);
  }

  void dispose() {
    for (final id in _idCache) {
      removeRenderObject(id);
    }
  }
}
