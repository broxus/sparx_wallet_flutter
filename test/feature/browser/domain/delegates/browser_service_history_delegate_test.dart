import 'dart:async';

import 'package:app/app/service/database/database_service.dart';
import 'package:app/app/service/database/delegates/browser_history_database_delegate.dart';
import 'package:app/data/models/browser_history_item.dart';
import 'package:app/feature/browser/data/history_type.dart';
import 'package:app/feature/browser/domain/delegates/browser_service_history_delegate.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDatabaseService extends Mock implements DatabaseService {}

class MockBrowserHistoryDatabaseDelegate extends Mock
    implements BrowserHistoryDatabaseDelegate {}

void main() {
  late MockDatabaseService databaseService;
  late MockBrowserHistoryDatabaseDelegate historyDelegate;
  late BrowserServiceHistoryDelegate service;

  setUpAll(() {
    registerFallbackValue(DateTime(2000));
  });

  setUp(() {
    databaseService = MockDatabaseService();
    historyDelegate = MockBrowserHistoryDatabaseDelegate();

    when(() => databaseService.history).thenReturn(historyDelegate);

    service = BrowserServiceHistoryDelegate(databaseService);
  });

  group('watchHistory', () {
    test('Watch history without searchText', () {
      final stream = Stream<List<BrowserHistoryItem>>.empty();

      when(() => historyDelegate.watchHistory()).thenAnswer((_) => stream);

      final result = service.watchHistory();

      expect(result, same(stream));
      verify(() => historyDelegate.watchHistory()).called(1);
    });

    test('Watch history with searchText', () {
      final stream = Stream<List<BrowserHistoryItem>>.empty();

      when(
        () => historyDelegate.watchHistory('test'),
      ).thenAnswer((_) => stream);

      final result = service.watchHistory('test');

      expect(result, same(stream));
      verify(() => historyDelegate.watchHistory('test')).called(1);
    });

    test('watchHistoryCount', () {
      final stream = Stream<int>.empty();

      when(() => historyDelegate.watchHistoryCount()).thenAnswer((_) => stream);

      final result = service.watchHistoryCount();

      expect(result, same(stream));
      verify(() => historyDelegate.watchHistoryCount()).called(1);
    });
  });

  group('Get items', () {
    test('getHistoryItemById', () async {
      const id = '123';
      final item = BrowserHistoryItem(
        id: id,
        title: 'Title',
        url: Uri.parse('https://example.com'),
        visitTime: DateTime(2024, 1, 1),
      );

      when(
        () => historyDelegate.getHistoryItemById(id),
      ).thenAnswer((_) async => item);

      final result = await service.getHistoryItemById(id);

      expect(result, same(item));
      verify(() => historyDelegate.getHistoryItemById(id)).called(1);
    });

    test('Get items without searchText', () async {
      final items = <BrowserHistoryItem>[
        BrowserHistoryItem(
          id: '1',
          title: 'One',
          url: Uri.parse('https://one.com'),
          visitTime: DateTime(2024, 1, 1),
        ),
      ];

      when(() => historyDelegate.getItems(null)).thenAnswer((_) async => items);

      final result = await service.getItems();

      expect(result, same(items));
      verify(() => historyDelegate.getItems(null)).called(1);
    });

    test('Get items with searchText', () async {
      final items = <BrowserHistoryItem>[
        BrowserHistoryItem(
          id: '2',
          title: 'Two',
          url: Uri.parse('https://two.com'),
          visitTime: DateTime(2024, 1, 2),
        ),
      ];

      when(
        () => historyDelegate.getItems('test'),
      ).thenAnswer((_) async => items);

      final result = await service.getItems('test');

      expect(result, same(items));
      verify(() => historyDelegate.getItems('test')).called(1);
    });
  });

  group('Remove', () {
    test('removeHistoryItem', () async {
      when(
        () => historyDelegate.deleteHistoryItem('123'),
      ).thenAnswer((_) async {});

      await service.removeHistoryItem('123');

      verify(() => historyDelegate.deleteHistoryItem('123')).called(1);
    });

    test('removeHistoryItemByUri', () async {
      final uri = Uri.parse('https://example.com');

      when(
        () => historyDelegate.deleteHistoryItemByUri(uri),
      ).thenAnswer((_) async {});

      await service.removeHistoryItemByUri(uri);

      verify(() => historyDelegate.deleteHistoryItemByUri(uri)).called(1);
    });
  });

  group('clear', () {
    test('clear all History', () async {
      when(() => historyDelegate.clearHistory()).thenAnswer((_) async {});

      await service.clear();

      verify(() => historyDelegate.clearHistory()).called(1);
      verifyNever(() => historyDelegate.clearHistoryByDates(any(), any()));
    });

    test('clearHistoryByDates lastHour', () async {
      when(
        () => historyDelegate.clearHistoryByDates(any(), any()),
      ).thenAnswer((_) async {});

      await service.clearHistory(TimePeriod.lastHour);

      final captured = verify(
        () => historyDelegate.clearHistoryByDates(captureAny(), captureAny()),
      ).captured;

      final lower = captured[0] as DateTime;
      final higher = captured[1] as DateTime;

      expect(higher.isAfter(lower), isTrue);
      expect(higher.difference(lower), const Duration(hours: 1));

      verifyNever(() => historyDelegate.clearHistory());
    });

    test('clearHistoryByDates today', () async {
      when(
        () => historyDelegate.clearHistoryByDates(any(), any()),
      ).thenAnswer((_) async {});

      await service.clearHistory(TimePeriod.today);

      final captured = verify(
        () => historyDelegate.clearHistoryByDates(captureAny(), captureAny()),
      ).captured;

      final lower = captured[0] as DateTime;
      final higher = captured[1] as DateTime;

      expect(higher.isAfter(lower), isTrue);
      expect(lower.hour, 0);
      expect(lower.minute, 0);
      expect(lower.second, 0);
      expect(lower.millisecond, 0);

      expect(lower.year, higher.year);
      expect(lower.month, higher.month);
      expect(lower.day, higher.day);

      verifyNever(() => historyDelegate.clearHistory());
    });

    test('clearHistoryByDates todayYesterday', () async {
      when(
        () => historyDelegate.clearHistoryByDates(any(), any()),
      ).thenAnswer((_) async {});

      await service.clearHistory(TimePeriod.todayYesterday);

      final captured = verify(
        () => historyDelegate.clearHistoryByDates(captureAny(), captureAny()),
      ).captured;

      final lower = captured[0] as DateTime;
      final higher = captured[1] as DateTime;

      expect(higher.isAfter(lower), isTrue);
      expect(lower.hour, 0);
      expect(lower.minute, 0);
      expect(lower.second, 0);
      expect(lower.millisecond, 0);

      expect(higher.difference(lower).inHours, greaterThanOrEqualTo(24));

      verifyNever(() => historyDelegate.clearHistory());
    });
  });
}
