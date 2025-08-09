# 💾 Flutter 앱스토리지(SharedPreferences) 사용 가이드

## 📋 **목차**

1. [개요](#개요)
2. [설치 및 설정](#설치-및-설정)
3. [기본 사용법](#기본-사용법)
4. [고급 사용법](#고급-사용법)
5. [실제 사용 예시](#실제-사용-예시)
6. [모범 사례](#모범-사례)

---

## 🎯 **개요**

Flutter에서 앱스토리지(SharedPreferences)를 사용하면 **로컬 데이터를 영구적으로 저장**할 수 있습니다.

### **장점**

- **영구 저장**: 앱을 종료해도 데이터 유지
- **간단한 사용**: Key-Value 형태로 쉽게 저장/조회
- **다양한 타입**: String, int, double, bool, List 지원
- **빠른 접근**: 메모리 기반 빠른 읽기/쓰기

### **사용 사례**

- 사용자 설정 저장
- 로그인 토큰 저장
- 앱 사용 통계
- 검색 기록
- 할일 목록
- 게임 점수

---

## 📦 **설치 및 설정**

### **1. 패키지 설치**

```yaml
# pubspec.yaml
dependencies:
  shared_preferences: ^2.2.2
```

### **2. main.dart에서 초기화**

```dart
import 'services/storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 앱스토리지 초기화
  await StorageService.initialize();

  runApp(const MyApp());
}
```

---

## 🔧 **기본 사용법**

### **1. 문자열 저장/조회**

```dart
// 문자열 저장
await StorageService.setString('user_name', '홍길동');
await StorageService.setString('user_email', 'hong@example.com');

// 문자열 조회
final userName = await StorageService.getString('user_name');
final userEmail = await StorageService.getString('user_email');

print('사용자 이름: $userName'); // 홍길동
print('사용자 이메일: $userEmail'); // hong@example.com
```

### **2. 숫자 저장/조회**

```dart
// 정수 저장
await StorageService.setInt('user_age', 25);
await StorageService.setInt('app_usage_count', 100);

// 실수 저장
await StorageService.setDouble('user_score', 95.5);

// 숫자 조회
final userAge = await StorageService.getInt('user_age');
final usageCount = await StorageService.getInt('app_usage_count');
final userScore = await StorageService.getDouble('user_score');

print('나이: $userAge'); // 25
print('사용 횟수: $usageCount'); // 100
print('점수: $userScore'); // 95.5
```

### **3. 불린 저장/조회**

```dart
// 불린 저장
await StorageService.setBool('is_dark_mode', true);
await StorageService.setBool('notifications_enabled', false);

// 불린 조회
final isDarkMode = await StorageService.getBool('is_dark_mode');
final notificationsEnabled = await StorageService.getBool('notifications_enabled');

print('다크 모드: $isDarkMode'); // true
print('알림 활성화: $notificationsEnabled'); // false
```

### **4. 리스트 저장/조회**

```dart
// 문자열 리스트 저장
final searchHistory = ['Flutter', 'Dart', 'GetX', 'SharedPreferences'];
await StorageService.setStringList('search_history', searchHistory);

// 문자열 리스트 조회
final history = await StorageService.getStringList('search_history');
print('검색 기록: $history'); // [Flutter, Dart, GetX, SharedPreferences]
```

### **5. 객체 저장/조회 (JSON)**

```dart
// 객체 저장
final userInfo = {
  'name': '홍길동',
  'email': 'hong@example.com',
  'age': 25,
  'created_at': DateTime.now().toIso8601String(),
};
await StorageService.setObject('user_info', userInfo);

// 객체 조회
final savedUserInfo = await StorageService.getObject('user_info');
if (savedUserInfo != null) {
  print('사용자 이름: ${savedUserInfo['name']}');
  print('사용자 이메일: ${savedUserInfo['email']}');
  print('사용자 나이: ${savedUserInfo['age']}');
}
```

---

## 🚀 **고급 사용법**

### **1. 키 존재 여부 확인**

```dart
// 특정 키가 존재하는지 확인
final hasUserName = await StorageService.containsKey('user_name');
if (hasUserName) {
  print('사용자 이름이 저장되어 있습니다.');
} else {
  print('사용자 이름이 저장되어 있지 않습니다.');
}
```

### **2. 특정 키 삭제**

```dart
// 특정 키 삭제
await StorageService.remove('user_name');
print('사용자 이름이 삭제되었습니다.');
```

### **3. 모든 데이터 삭제**

```dart
// 모든 저장된 데이터 삭제
await StorageService.clear();
print('모든 데이터가 삭제되었습니다.');
```

### **4. 모든 키 조회**

```dart
// 저장된 모든 키 조회
final allKeys = await StorageService.getKeys();
print('저장된 키들: $allKeys');
```

---

## 🎮 **실제 사용 예시**

### **1. 사용자 정보 관리**

```dart
class UserService {
  // 사용자 정보 저장
  static Future<bool> saveUserInfo({
    required String name,
    required String email,
    required int age,
  }) async {
    final userInfo = {
      'name': name,
      'email': email,
      'age': age,
      'created_at': DateTime.now().toIso8601String(),
    };
    return await StorageService.setObject('user_info', userInfo);
  }

  // 사용자 정보 조회
  static Future<Map<String, dynamic>?> getUserInfo() async {
    return await StorageService.getObject('user_info');
  }

  // 사용자 정보 삭제
  static Future<bool> removeUserInfo() async {
    return await StorageService.remove('user_info');
  }
}

// 사용 예시
await UserService.saveUserInfo(
  name: '홍길동',
  email: 'hong@example.com',
  age: 25,
);

final userInfo = await UserService.getUserInfo();
if (userInfo != null) {
  print('사용자: ${userInfo['name']}');
}
```

### **2. 앱 설정 관리**

```dart
class AppSettingsService {
  // 앱 설정 저장
  static Future<bool> saveAppSettings({
    required bool isDarkMode,
    required String language,
    required bool notificationsEnabled,
  }) async {
    final settings = {
      'is_dark_mode': isDarkMode,
      'language': language,
      'notifications_enabled': notificationsEnabled,
      'updated_at': DateTime.now().toIso8601String(),
    };
    return await StorageService.setObject('app_settings', settings);
  }

  // 앱 설정 조회
  static Future<Map<String, dynamic>?> getAppSettings() async {
    return await StorageService.getObject('app_settings');
  }

  // 다크 모드 설정
  static Future<bool> setDarkMode(bool isDark) async {
    final settings = await getAppSettings() ?? {};
    settings['is_dark_mode'] = isDark;
    settings['updated_at'] = DateTime.now().toIso8601String();
    return await StorageService.setObject('app_settings', settings);
  }

  // 다크 모드 조회
  static Future<bool> isDarkMode() async {
    final settings = await getAppSettings();
    return settings?['is_dark_mode'] ?? false;
  }
}

// 사용 예시
await AppSettingsService.saveAppSettings(
  isDarkMode: true,
  language: 'ko',
  notificationsEnabled: true,
);

final isDark = await AppSettingsService.isDarkMode();
print('다크 모드: $isDark');
```

### **3. 검색 기록 관리**

```dart
class SearchHistoryService {
  // 검색어 추가
  static Future<bool> addSearchTerm(String searchTerm) async {
    final history = await StorageService.getStringList('search_history') ?? [];

    // 중복 제거
    history.remove(searchTerm);

    // 최신 검색어를 맨 앞에 추가
    history.insert(0, searchTerm);

    // 최대 10개까지만 유지
    if (history.length > 10) {
      history.removeRange(10, history.length);
    }

    return await StorageService.setStringList('search_history', history);
  }

  // 검색 기록 조회
  static Future<List<String>?> getSearchHistory() async {
    return await StorageService.getStringList('search_history');
  }

  // 검색 기록 삭제
  static Future<bool> clearSearchHistory() async {
    return await StorageService.remove('search_history');
  }
}

// 사용 예시
await SearchHistoryService.addSearchTerm('Flutter');
await SearchHistoryService.addSearchTerm('Dart');
await SearchHistoryService.addSearchTerm('GetX');

final history = await SearchHistoryService.getSearchHistory();
print('검색 기록: $history'); // [GetX, Dart, Flutter]
```

### **4. 할일 목록 관리**

```dart
class TodoService {
  // 할일 목록 저장
  static Future<bool> saveTodoList(List<Map<String, dynamic>> todos) async {
    return await StorageService.setObject('todo_list', {'todos': todos});
  }

  // 할일 목록 조회
  static Future<List<Map<String, dynamic>>?> getTodoList() async {
    final data = await StorageService.getObject('todo_list');
    if (data != null && data['todos'] != null) {
      return List<Map<String, dynamic>>.from(data['todos']);
    }
    return null;
  }

  // 할일 추가
  static Future<bool> addTodo(String title, String description) async {
    final todos = await getTodoList() ?? [];

    final newTodo = {
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'title': title,
      'description': description,
      'completed': false,
      'created_at': DateTime.now().toIso8601String(),
    };

    todos.add(newTodo);
    return await saveTodoList(todos);
  }

  // 할일 완료/미완료 토글
  static Future<bool> toggleTodo(String todoId) async {
    final todos = await getTodoList() ?? [];

    final index = todos.indexWhere((todo) => todo['id'] == todoId);
    if (index != -1) {
      todos[index]['completed'] = !(todos[index]['completed'] ?? false);
      return await saveTodoList(todos);
    }

    return false;
  }

  // 할일 삭제
  static Future<bool> removeTodo(String todoId) async {
    final todos = await getTodoList() ?? [];
    todos.removeWhere((todo) => todo['id'] == todoId);
    return await saveTodoList(todos);
  }
}

// 사용 예시
await TodoService.addTodo('Flutter 공부하기', 'GetX 상태관리 학습');
await TodoService.addTodo('앱 개발하기', '새로운 앱 프로젝트 시작');

final todos = await TodoService.getTodoList();
if (todos != null) {
  for (final todo in todos) {
    print('할일: ${todo['title']} - ${todo['completed'] ? '완료' : '미완료'}');
  }
}
```

### **5. 앱 사용 통계 관리**

```dart
class AppUsageService {
  // 앱 사용 횟수 증가
  static Future<bool> incrementUsage() async {
    final usageCount = await StorageService.getInt('app_usage_count') ?? 0;
    return await StorageService.setInt('app_usage_count', usageCount + 1);
  }

  // 앱 사용 횟수 조회
  static Future<int> getUsageCount() async {
    return await StorageService.getInt('app_usage_count') ?? 0;
  }

  // 마지막 사용 날짜 저장
  static Future<bool> setLastUsedDate() async {
    final now = DateTime.now().toIso8601String();
    return await StorageService.setString('last_used_date', now);
  }

  // 마지막 사용 날짜 조회
  static Future<String?> getLastUsedDate() async {
    return await StorageService.getString('last_used_date');
  }

  // 앱 사용 통계 업데이트
  static Future<bool> updateUsage() async {
    await incrementUsage();
    return await setLastUsedDate();
  }
}

// 사용 예시
await AppUsageService.updateUsage();

final usageCount = await AppUsageService.getUsageCount();
final lastUsed = await AppUsageService.getLastUsedDate();

print('앱 사용 횟수: $usageCount');
print('마지막 사용: $lastUsed');
```

---

## 📋 **모범 사례**

### **1. 에러 처리**

```dart
class SafeStorageService {
  static Future<String?> getStringSafely(String key) async {
    try {
      return await StorageService.getString(key);
    } catch (e) {
      print('저장소 읽기 오류: $e');
      return null;
    }
  }

  static Future<bool> setStringSafely(String key, String value) async {
    try {
      return await StorageService.setString(key, value);
    } catch (e) {
      print('저장소 쓰기 오류: $e');
      return false;
    }
  }
}
```

### **2. 기본값 설정**

```dart
class DefaultStorageService {
  static Future<String> getStringWithDefault(String key, String defaultValue) async {
    final value = await StorageService.getString(key);
    return value ?? defaultValue;
  }

  static Future<int> getIntWithDefault(String key, int defaultValue) async {
    final value = await StorageService.getInt(key);
    return value ?? defaultValue;
  }

  static Future<bool> getBoolWithDefault(String key, bool defaultValue) async {
    final value = await StorageService.getBool(key);
    return value ?? defaultValue;
  }
}
```

### **3. 데이터 마이그레이션**

```dart
class StorageMigrationService {
  static Future<void> migrateData() async {
    // 이전 버전의 데이터를 새로운 형식으로 마이그레이션
    final oldUserName = await StorageService.getString('old_user_name');
    if (oldUserName != null) {
      // 새로운 형식으로 변환
      await StorageService.setObject('user_info', {
        'name': oldUserName,
        'migrated_at': DateTime.now().toIso8601String(),
      });

      // 이전 데이터 삭제
      await StorageService.remove('old_user_name');
    }
  }
}
```

### **4. 데이터 백업/복원**

```dart
class StorageBackupService {
  // 모든 데이터 백업
  static Future<Map<String, dynamic>> backupAllData() async {
    final keys = await StorageService.getKeys();
    final backup = <String, dynamic>{};

    for (final key in keys) {
      final value = await StorageService.getString(key);
      if (value != null) {
        backup[key] = value;
      }
    }

    return backup;
  }

  // 백업 데이터 복원
  static Future<bool> restoreData(Map<String, dynamic> backup) async {
    try {
      for (final entry in backup.entries) {
        await StorageService.setString(entry.key, entry.value.toString());
      }
      return true;
    } catch (e) {
      print('데이터 복원 오류: $e');
      return false;
    }
  }
}
```

---

## 🎯 **결론**

앱스토리지를 사용하면:

1. **영구 저장**: 앱을 종료해도 데이터 유지
2. **간단한 사용**: Key-Value 형태로 쉽게 저장/조회
3. **다양한 타입**: String, int, double, bool, List 지원
4. **실전 활용**: 사용자 설정, 검색 기록, 할일 목록 등

이 가이드를 따라 안전하고 효율적인 로컬 데이터 관리 시스템을 구축하세요! 🚀
