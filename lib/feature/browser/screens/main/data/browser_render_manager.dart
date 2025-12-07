import 'package:flutter/rendering.dart';
import 'package:render_metrics/render_metrics.dart';

class BrowserTabsRenderManager extends RenderParametersManager<String> {
  final _idCache = <String>{};

  double itemWidth = 0;
  double itemHeight = 0;

  @override
  void addRenderObject(String id, RenderObject renderObject) {
    super.addRenderObject(id, renderObject);
    _idCache.add(id);
    if (renderObject is RenderMetricsBox) {
      Future.delayed(const Duration(milliseconds: 50), () {
        try {
          itemWidth = renderObject.data.width;
          itemHeight = renderObject.data.height;
        } catch (_) {}
      });
    }
  }

  @override
  void removeRenderObject(String id) {
    super.removeRenderObject(id);
    _idCache.remove(id);
  }

  void dispose() {
    for (final id in _idCache) {
      removeRenderObject(id);
    }
  }
}
