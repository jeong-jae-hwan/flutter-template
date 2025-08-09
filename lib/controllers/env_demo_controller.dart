import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/env_service.dart';

/// 환경변수 데모 컨트롤러
/// 실제 앱에서 환경변수를 어떻게 사용하는지 보여주는 예제
class EnvDemoController extends GetxController {
  // 반응형 변수들
  final RxString currentEnvironment = ''.obs;
  final RxString apiStatus = ''.obs;
  final RxString dbStatus = ''.obs;
  final RxBool isAnalyticsEnabled = false.obs;
  final RxBool isCrashReportingEnabled = false.obs;
  final RxBool isPushNotificationsEnabled = false.obs;
  final RxString appInfo = ''.obs;
  final RxString externalServices = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _loadEnvironmentVariables();
  }

  /// 환경변수 로드 및 초기화
  void _loadEnvironmentVariables() {
    try {
      // 환경 정보
      currentEnvironment.value = EnvService.get('ENVIRONMENT');

      // API 정보
      final apiUrl = EnvService.apiBaseUrl;
      final apiVersion = EnvService.apiVersion;
      final apiTimeout = EnvService.apiTimeout;
      apiStatus.value =
          'API URL: $apiUrl\nVersion: $apiVersion\nTimeout: ${apiTimeout}ms';

      // 데이터베이스 정보
      final dbHost = EnvService.dbHost;
      final dbPort = EnvService.dbPort;
      final dbName = EnvService.dbName;
      final dbUser = EnvService.dbUser;
      dbStatus.value =
          'Host: $dbHost\nPort: $dbPort\nDatabase: $dbName\nUser: $dbUser';

      // 기능 플래그
      isAnalyticsEnabled.value = EnvService.enableAnalytics;
      isCrashReportingEnabled.value = EnvService.enableCrashReporting;
      isPushNotificationsEnabled.value = EnvService.enablePushNotifications;

      // 앱 정보
      final appName = EnvService.appName;
      final appVersion = EnvService.appVersion;
      final isDebug = EnvService.isDebugMode;
      appInfo.value = '앱 이름: $appName\n버전: $appVersion\n디버그 모드: $isDebug';

      // 외부 서비스 정보
      final googleMapsKey = EnvService.googleMapsApiKey;
      final firebaseProjectId = EnvService.firebaseProjectId;
      externalServices.value =
          'Google Maps API: ${googleMapsKey.length > 20 ? '${googleMapsKey.substring(0, 20)}...' : googleMapsKey}\nFirebase Project: $firebaseProjectId';
    } catch (e) {
      _setDefaultValues();
    }
  }

  /// 기본값 설정
  void _setDefaultValues() {
    currentEnvironment.value = 'development';
    apiStatus.value = 'API 정보를 불러올 수 없습니다.';
    dbStatus.value = '데이터베이스 정보를 불러올 수 없습니다.';
    appInfo.value = '앱 정보를 불러올 수 없습니다.';
    externalServices.value = '외부 서비스 정보를 불러올 수 없습니다.';
  }

  /// 환경변수 새로고침
  void refreshEnvironmentVariables() {
    _loadEnvironmentVariables();
    Get.snackbar(
      '새로고침',
      '환경변수가 새로고침되었습니다.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  /// API 연결 테스트 (시뮬레이션)
  void testApiConnection() async {
    Get.snackbar(
      'API 테스트',
      'API 연결을 테스트하는 중...',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.blue,
      colorText: Colors.white,
    );

    // 시뮬레이션된 API 호출
    await Future.delayed(Duration(seconds: 2));

    final apiUrl = EnvService.apiBaseUrl;
    Get.snackbar(
      'API 테스트 완료',
      'API URL: $apiUrl에 성공적으로 연결되었습니다.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  /// 데이터베이스 연결 테스트 (시뮬레이션)
  void testDatabaseConnection() async {
    Get.snackbar(
      'DB 테스트',
      '데이터베이스 연결을 테스트하는 중...',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.orange,
      colorText: Colors.white,
    );

    // 시뮬레이션된 DB 연결
    await Future.delayed(Duration(milliseconds: 1500));

    final String dbHost = EnvService.dbHost;
    final String dbName = EnvService.dbName;
    Get.snackbar(
      'DB 테스트 완료',
      '데이터베이스 $dbName($dbHost)에 성공적으로 연결되었습니다.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  /// 기능 플래그 토글
  void toggleAnalytics() {
    // 실제로는 환경변수를 직접 수정할 수 없으므로 시뮬레이션
    isAnalyticsEnabled.value = !isAnalyticsEnabled.value;
    Get.snackbar(
      'Analytics',
      isAnalyticsEnabled.value
          ? 'Analytics가 활성화되었습니다.'
          : 'Analytics가 비활성화되었습니다.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void toggleCrashReporting() {
    isCrashReportingEnabled.value = !isCrashReportingEnabled.value;
    Get.snackbar(
      'Crash Reporting',
      isCrashReportingEnabled.value
          ? 'Crash Reporting이 활성화되었습니다.'
          : 'Crash Reporting이 비활성화되었습니다.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void togglePushNotifications() {
    isPushNotificationsEnabled.value = !isPushNotificationsEnabled.value;
    Get.snackbar(
      'Push Notifications',
      isPushNotificationsEnabled.value
          ? 'Push Notifications이 활성화되었습니다.'
          : 'Push Notifications이 비활성화되었습니다.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  /// 환경별 다른 동작 시뮬레이션
  void simulateEnvironmentSpecificAction() {
    if (EnvService.isDevelopment) {
      Get.snackbar(
        '개발 환경',
        '개발 환경에서는 디버그 로그가 출력됩니다.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.blue,
        colorText: Colors.white,
      );
    } else if (EnvService.isProduction) {
      Get.snackbar(
        '프로덕션 환경',
        '프로덕션 환경에서는 성능 최적화가 적용됩니다.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }
  }

  /// 모든 환경변수 정보 가져오기
  Map<String, String> getAllEnvironmentVariables() {
    return EnvService.getAll();
  }

  /// 특정 환경변수 존재 여부 확인
  bool hasEnvironmentVariable(String key) {
    return EnvService.has(key);
  }

  /// 환경변수 값 가져오기 (타입별)
  String getStringValue(String key) {
    return EnvService.get(key);
  }

  int getIntValue(String key) {
    return EnvService.getInt(key);
  }

  bool getBoolValue(String key) {
    return EnvService.getBool(key);
  }

  double getDoubleValue(String key) {
    return EnvService.getDouble(key);
  }
}
