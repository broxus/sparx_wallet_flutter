import 'package:app/feature/browser/custom_web_controller.dart';
import 'package:app/feature/browser/domain/delegates/browser_service_pages_controllers_delegate.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nekoton_webview/nekoton_webview.dart';

class MockCustomWebViewController extends Mock
    implements CustomWebViewController {}

void main() {
  late BrowserServicePagesControllersDelegate delegate;
  late MockCustomWebViewController controller;

  setUpAll(() {
    registerFallbackValue(URLRequest(url: WebUri('https://example.com')));
    registerFallbackValue(WebUri('https://example.com'));

    registerFallbackValue(
      const PermissionsChangedEvent(PermissionsPartial(null, null)),
    );
  });

  setUp(() {
    delegate = BrowserServicePagesControllersDelegate();
    controller = MockCustomWebViewController();
  });

  group('Manage controller', () {
    test('refresh if controller exist', () {
      delegate.setController('tab-1', controller);

      when(() => controller.reload()).thenAnswer((_) async {});

      delegate.refresh('tab-1');

      verify(() => controller.reload()).called(1);
    });

    test('refresh if controller not exist', () {
      delegate.refresh('unknown');

      verifyNever(() => controller.reload());
    });

    test('removeController', () {
      delegate
        ..setController('tab-1', controller)
        ..removeController('tab-1');

      when(() => controller.reload()).thenAnswer((_) async {});

      delegate.refresh('tab-1');

      verifyNever(() => controller.reload());
    });

    test('closeAllControllers', () {
      final c1 = MockCustomWebViewController();
      final c2 = MockCustomWebViewController();

      delegate
        ..setController('tab-1', c1)
        ..setController('tab-2', c2)
        ..closeAllControllers();

      verify(c1.dispose).called(1);
      verify(c2.dispose).called(1);

      delegate
        ..refresh('tab-1')
        ..refresh('tab-2');

      verifyNoMoreInteractions(c1);
      verifyNoMoreInteractions(c2);
    });
  });

  group('permissionsChanged', () {
    test('Send controller event if controller exist', () async {
      delegate.setController('tab-1', controller);

      const event = PermissionsChangedEvent(PermissionsPartial(null, null));

      when(() => controller.permissionsChanged(event)).thenAnswer((_) async {});

      await delegate.permissionsChanged('tab-1', event);

      verify(() => controller.permissionsChanged(event)).called(1);
    });

    test('Send controller event if controller not exist', () async {
      const event = PermissionsChangedEvent(PermissionsPartial(null, null));

      await delegate.permissionsChanged('unknown', event);

      verifyNever(() => controller.permissionsChanged(any()));
    });
  });

  group('loadUrl', () {
    test('loadUrl with any URLRequest if controller exist', () async {
      delegate.setController('tab-1', controller);

      when(
        () => controller.loadUrl(urlRequest: any(named: 'urlRequest')),
      ).thenAnswer((_) async {});

      final uri = Uri.parse('https://example.com');

      await delegate.loadUrl('tab-1', uri);

      verify(
        () => controller.loadUrl(urlRequest: any(named: 'urlRequest')),
      ).called(1);
    });

    test('loadUrl with any URLRequest if not controller exist', () async {
      final uri = Uri.parse('https://example.com');

      await delegate.loadUrl('unknown', uri);

      verifyNever(
        () => controller.loadUrl(urlRequest: any(named: 'urlRequest')),
      );
    });
  });

  group('loadData', () {
    test('Load if controller exist', () async {
      delegate.setController('tab-1', controller);

      const html = '<html></html>';
      final base = WebUri('https://base.com');
      final history = WebUri('https://history.com');

      when(
        () => controller.loadData(
          data: any(named: 'data'),
          baseUrl: any(named: 'baseUrl'),
          historyUrl: any(named: 'historyUrl'),
        ),
      ).thenAnswer((_) async {});

      await delegate.loadData(
        'tab-1',
        html,
        baseUrl: base,
        historyUrl: history,
      );

      verify(
        () =>
            controller.loadData(data: html, baseUrl: base, historyUrl: history),
      ).called(1);
    });

    test('Load if controller not exist', () async {
      await delegate.loadData('unknown', '<html></html>');

      verifyNever(
        () => controller.loadData(
          data: any(named: 'data'),
          baseUrl: any(named: 'baseUrl'),
          historyUrl: any(named: 'historyUrl'),
        ),
      );
    });
  });

  group('Go', () {
    test('goBack if exist controller', () async {
      delegate.setController('tab-1', controller);

      when(() => controller.goBack()).thenAnswer((_) async {});

      await delegate.goBack('tab-1');

      verify(() => controller.goBack()).called(1);
    });

    test('goBack if not exist controller', () async {
      await delegate.goBack('unknown');

      verifyNever(() => controller.goBack());
    });

    test('goForward if exist controller', () async {
      delegate.setController('tab-1', controller);

      when(() => controller.goForward()).thenAnswer((_) async {});

      await delegate.goForward('tab-1');

      verify(() => controller.goForward()).called(1);
    });

    test('goForward if not exist controller', () async {
      await delegate.goForward('unknown');

      verifyNever(() => controller.goForward());
    });
  });

  group('Check can go', () {
    test('checkCanGoBack if not exist controller', () async {
      final result = await delegate.checkCanGoBack('unknown');

      expect(result, isFalse);
    });

    test('checkCanGoBack if exist controller', () async {
      delegate.setController('tab-1', controller);

      when(() => controller.canGoBack()).thenAnswer((_) async => true);

      final result = await delegate.checkCanGoBack('tab-1');

      expect(result, isTrue);
      verify(() => controller.canGoBack()).called(1);
    });

    test('checkCanGoForward if not exist controller', () async {
      final result = await delegate.checkCanGoForward('unknown');

      expect(result, isFalse);
    });

    test('checkCanGoForward if exist controller', () async {
      delegate.setController('tab-1', controller);

      when(() => controller.canGoForward()).thenAnswer((_) async => true);

      final result = await delegate.checkCanGoForward('tab-1');

      expect(result, isTrue);
      verify(() => controller.canGoForward()).called(1);
    });
  });
}
