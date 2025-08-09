import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

/// 앱 전역에서 사용하는 로컬 스토리지 서비스
///
/// - SharedPreferences 기반으로 동작
/// - GetX 컨트롤러들이 사용하는 메서드들을 한 곳에 모아 재사용성 극대화
class StorageService {
  // 내부 SharedPreferences 인스턴스
  static late SharedPreferences _prefs;
  static bool _initialized = false;

  /// 스토리지 초기화 (앱 시작 시 1회 호출)
  static Future<void> initialize() async {
    if (_initialized) return;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _prefs = prefs;
    _initialized = true;
  }

  // 공통 유틸 - Primitive 타입 저장/조회
  static Future<bool> setString(String key, String value) async {
    return await _prefs.setString(key, value);
  }

  static Future<String?> getString(String key) async {
    return _prefs.getString(key);
  }

  static Future<bool> setInt(String key, int value) async {
    return await _prefs.setInt(key, value);
  }

  static Future<int> getInt(String key, {int defaultValue = 0}) async {
    final int? value = _prefs.getInt(key);
    return value ?? defaultValue;
  }

  static Future<bool> setBool(String key, bool value) async {
    return await _prefs.setBool(key, value);
  }

  static Future<bool> getBool(String key, {bool defaultValue = false}) async {
    final bool? value = _prefs.getBool(key);
    return value ?? defaultValue;
  }

  static Future<bool> setDouble(String key, double value) async {
    return await _prefs.setDouble(key, value);
  }

  static Future<double> getDouble(
    String key, {
    double defaultValue = 0.0,
  }) async {
    final double? value = _prefs.getDouble(key);
    return value ?? defaultValue;
  }

  static Future<bool> remove(String key) async {
    return await _prefs.remove(key);
  }

  static Future<bool> containsKey(String key) async {
    final Set<String> keys = _prefs.getKeys();
    return keys.contains(key);
  }

  static Future<Set<String>> getKeys() async {
    return _prefs.getKeys();
  }

  static Future<bool> clear() async {
    return await _prefs.clear();
  }

  // 도메인 유틸 - 사용자 정보
  static const String _keyUserInfo = 'user_info';

  static Future<void> setUserInfo({
    required String name,
    required String email,
    required int age,
  }) async {
    final Map<String, dynamic> data = <String, dynamic>{
      'name': name,
      'email': email,
      'age': age,
    };
    await _prefs.setString(_keyUserInfo, jsonEncode(data));
  }

  static Future<Map<String, dynamic>?> getUserInfo() async {
    final String? jsonString = _prefs.getString(_keyUserInfo);
    if (jsonString == null) return null;
    try {
      final Map<String, dynamic> map =
          jsonDecode(jsonString) as Map<String, dynamic>;
      return map;
    } catch (_) {
      return null;
    }
  }

  // 도메인 유틸 - 카운터
  static const String _keyCounter = 'counter_value';

  static Future<void> setCounter(int value) async {
    await _prefs.setInt(_keyCounter, value);
  }

  static Future<int> getCounter() async {
    final int? value = _prefs.getInt(_keyCounter);
    return value ?? 0;
  }

  // 도메인 유틸 - 앱 설정
  static const String _keyAppSettings = 'app_settings';

  static Future<void> setAppSettings({
    required bool isDarkMode,
    required String language,
    required bool notificationsEnabled,
  }) async {
    final Map<String, dynamic> data = <String, dynamic>{
      'is_dark_mode': isDarkMode,
      'language': language,
      'notifications_enabled': notificationsEnabled,
    };
    await _prefs.setString(_keyAppSettings, jsonEncode(data));
  }

  static Future<Map<String, dynamic>?> getAppSettings() async {
    final String? jsonString = _prefs.getString(_keyAppSettings);
    if (jsonString == null) return null;
    try {
      final Map<String, dynamic> map =
          jsonDecode(jsonString) as Map<String, dynamic>;
      return map;
    } catch (_) {
      return null;
    }
  }

  // 도메인 유틸 - 검색 기록
  static const String _keySearchHistory = 'search_history';

  static Future<void> addSearchHistory(String term) async {
    final List<String> history = await getSearchHistory() ?? <String>[];
    // 중복 제거 및 최근 항목이 위로 오도록 처리
    history.remove(term);
    history.insert(0, term);
    await _prefs.setString(_keySearchHistory, jsonEncode(history));
  }

  static Future<List<String>?> getSearchHistory() async {
    final String? jsonString = _prefs.getString(_keySearchHistory);
    if (jsonString == null) return null;
    try {
      final List<dynamic> list = jsonDecode(jsonString) as List<dynamic>;
      return list.map((dynamic e) => e.toString()).toList();
    } catch (_) {
      return null;
    }
  }

  static Future<void> clearSearchHistory() async {
    await _prefs.remove(_keySearchHistory);
  }

  // 도메인 유틸 - 할일 목록
  static const String _keyTodoList = 'todo_list';

  static Future<void> setTodoList(List<Map<String, dynamic>> todos) async {
    final String jsonString = jsonEncode(todos);
    await _prefs.setString(_keyTodoList, jsonString);
  }

  static Future<List<Map<String, dynamic>>?> getTodoList() async {
    final String? jsonString = _prefs.getString(_keyTodoList);
    if (jsonString == null) return null;
    try {
      final List<dynamic> list = jsonDecode(jsonString) as List<dynamic>;
      return list
          .whereType<Map<String, dynamic>>()
          .map((Map<String, dynamic> e) => Map<String, dynamic>.from(e))
          .toList();
    } catch (_) {
      try {
        final List<dynamic> list = jsonDecode(jsonString) as List<dynamic>;
        return list
            .map((dynamic e) => Map<String, dynamic>.from(e as Map))
            .toList();
      } catch (_) {
        return null;
      }
    }
  }

  // 도메인 유틸 - 앱 사용 통계
  static const String _keyAppUsageCount = 'app_usage_count';
  static const String _keyLastUsedDate = 'last_used_date';

  static Future<void> incrementAppUsage() async {
    final int current = await getAppUsageCount();
    await _prefs.setInt(_keyAppUsageCount, current + 1);
  }

  static Future<int> getAppUsageCount() async {
    final int? value = _prefs.getInt(_keyAppUsageCount);
    return value ?? 0;
  }

  static Future<void> setLastUsedDate() async {
    final String now = DateTime.now().toIso8601String();
    await _prefs.setString(_keyLastUsedDate, now);
  }

  static Future<String?> getLastUsedDate() async {
    return _prefs.getString(_keyLastUsedDate);
  }
}
