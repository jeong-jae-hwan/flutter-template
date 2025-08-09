import 'package:flutter_dotenv/flutter_dotenv.dart';

/// 환경변수를 관리하는 서비스 클래스
///
/// 사용법:
/// ```dart
/// final apiUrl = EnvService.get('API_BASE_URL');
/// final isDebug = EnvService.getBool('DEBUG_MODE');
/// ```
class EnvService {
  static bool _isInitialized = false;

  /// 환경변수 파일 초기화
  static Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      // 개발 환경에서는 .env 파일 로드
      await dotenv.load(fileName: 'assets/env/.env');
      _isInitialized = true;
      // 초기화 성공 로그
      // GetX 로거에 위임하지 않음: 서비스 레벨이므로 최소한의 의존성 유지
      // 상위에서 logWriterCallback으로 debugPrint 경로로 처리됨
      // ignore: avoid_print
      print('✅ 환경변수 초기화 완료');
    } catch (e) {
      // ignore: avoid_print
      print('❌ 환경변수 초기화 실패: $e');
      rethrow;
    }
  }

  /// 문자열 환경변수 가져오기
  static String get(String key, {String defaultValue = ''}) {
    _checkInitialization();
    return dotenv.env[key] ?? defaultValue;
  }

  /// 정수 환경변수 가져오기
  static int getInt(String key, {int defaultValue = 0}) {
    _checkInitialization();
    final value = dotenv.env[key];
    if (value == null) return defaultValue;
    return int.tryParse(value) ?? defaultValue;
  }

  /// 실수 환경변수 가져오기
  static double getDouble(String key, {double defaultValue = 0.0}) {
    _checkInitialization();
    final value = dotenv.env[key];
    if (value == null) return defaultValue;
    return double.tryParse(value) ?? defaultValue;
  }

  /// 불린 환경변수 가져오기
  static bool getBool(String key, {bool defaultValue = false}) {
    _checkInitialization();
    final value = dotenv.env[key];
    if (value == null) return defaultValue;
    return value.toLowerCase() == 'true';
  }

  /// 모든 환경변수 가져오기
  static Map<String, String> getAll() {
    _checkInitialization();
    return dotenv.env;
  }

  /// 환경변수 존재 여부 확인
  static bool has(String key) {
    _checkInitialization();
    return dotenv.env.containsKey(key);
  }

  /// 초기화 상태 확인
  static void _checkInitialization() {
    if (!_isInitialized) {
      throw StateError('환경변수가 초기화되지 않았습니다. EnvService.initialize()를 먼저 호출하세요.');
    }
  }

  /// 현재 환경 확인
  static bool get isDevelopment => get('ENVIRONMENT') == 'development';
  static bool get isProduction => get('ENVIRONMENT') == 'production';
  static bool get isDebugMode => getBool('DEBUG_MODE');

  /// API 관련 환경변수
  static String get apiBaseUrl => get('API_BASE_URL');
  static String get apiVersion => get('API_VERSION');
  static int get apiTimeout => getInt('API_TIMEOUT');

  /// 앱 관련 환경변수
  static String get appName => get('APP_NAME');
  static String get appVersion => get('APP_VERSION');

  /// 데이터베이스 관련 환경변수
  static String get dbHost => get('DB_HOST');
  static int get dbPort => getInt('DB_PORT');
  static String get dbName => get('DB_NAME');
  static String get dbUser => get('DB_USER');

  /// 외부 서비스 관련 환경변수
  static String get googleMapsApiKey => get('GOOGLE_MAPS_API_KEY');
  static String get firebaseProjectId => get('FIREBASE_PROJECT_ID');

  /// 기능 플래그
  static bool get enableAnalytics => getBool('ENABLE_ANALYTICS');
  static bool get enableCrashReporting => getBool('ENABLE_CRASH_REPORTING');
  static bool get enablePushNotifications =>
      getBool('ENABLE_PUSH_NOTIFICATIONS');
}
