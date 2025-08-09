import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// 보안 저장소 서비스 클래스
///
/// 민감한 데이터(토큰, 비밀번호 등)를 안전하게 저장하는 서비스
///
/// 사용법:
/// ```dart
/// await SecureStorageService.saveToken('my_access_token');
/// final token = await SecureStorageService.getToken();
/// ```
class SecureStorageService {
  // 보안 저장소 인스턴스 생성
  static const FlutterSecureStorage _storage = FlutterSecureStorage(
    // iOS: 키체인 사용
    // Android: 암호화된 SharedPreferences 사용
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true, // Android 23+ 에서 암호화된 저장소 사용
    ),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock, // 앱 첫 실행 시 접근 가능
    ),
  );

  // 🔑 토큰 관련 메서드들

  /// 액세스 토큰 저장
  static Future<void> saveAccessToken(String token) async {
    await _storage.write(key: 'access_token', value: token);
  }

  /// 액세스 토큰 가져오기
  static Future<String?> getAccessToken() async {
    return await _storage.read(key: 'access_token');
  }

  /// 액세스 토큰 삭제
  static Future<void> deleteAccessToken() async {
    await _storage.delete(key: 'access_token');
  }

  /// 리프레시 토큰 저장
  static Future<void> saveRefreshToken(String token) async {
    await _storage.write(key: 'refresh_token', value: token);
  }

  /// 리프레시 토큰 가져오기
  static Future<String?> getRefreshToken() async {
    return await _storage.read(key: 'refresh_token');
  }

  /// 리프레시 토큰 삭제
  static Future<void> deleteRefreshToken() async {
    await _storage.delete(key: 'refresh_token');
  }

  /// 모든 토큰 삭제
  static Future<void> deleteAllTokens() async {
    await _storage.deleteAll();
  }

  // 👤 사용자 정보 관련 메서드들

  /// 사용자 ID 저장
  static Future<void> saveUserId(String userId) async {
    await _storage.write(key: 'user_id', value: userId);
  }

  /// 사용자 ID 가져오기
  static Future<String?> getUserId() async {
    return await _storage.read(key: 'user_id');
  }

  /// 사용자 ID 삭제
  static Future<void> deleteUserId() async {
    await _storage.delete(key: 'user_id');
  }

  /// 사용자 이메일 저장
  static Future<void> saveUserEmail(String email) async {
    await _storage.write(key: 'user_email', value: email);
  }

  /// 사용자 이메일 가져오기
  static Future<String?> getUserEmail() async {
    return await _storage.read(key: 'user_email');
  }

  /// 사용자 이메일 삭제
  static Future<void> deleteUserEmail() async {
    await _storage.delete(key: 'user_email');
  }

  // 🔐 비밀번호 관련 메서드들 (선택적)

  /// 비밀번호 저장 (자동 로그인용)
  static Future<void> savePassword(String password) async {
    await _storage.write(key: 'user_password', value: password);
  }

  /// 비밀번호 가져오기
  static Future<String?> getPassword() async {
    return await _storage.read(key: 'user_password');
  }

  /// 비밀번호 삭제
  static Future<void> deletePassword() async {
    await _storage.delete(key: 'user_password');
  }

  // 🔍 유틸리티 메서드들

  /// 특정 키가 존재하는지 확인
  static Future<bool> containsKey(String key) async {
    return await _storage.containsKey(key: key);
  }

  /// 특정 키 삭제
  static Future<void> deleteKey(String key) async {
    await _storage.delete(key: key);
  }

  /// 모든 데이터 삭제
  static Future<void> deleteAll() async {
    await _storage.deleteAll();
  }

  /// 모든 키 가져오기
  static Future<Map<String, String>> getAll() async {
    return await _storage.readAll();
  }

  // 🎯 편의 메서드들

  /// 로그인 정보 저장 (한 번에)
  static Future<void> saveLoginInfo({
    required String accessToken,
    required String refreshToken,
    required String userId,
    required String userEmail,
    String? password,
  }) async {
    await saveAccessToken(accessToken);
    await saveRefreshToken(refreshToken);
    await saveUserId(userId);
    await saveUserEmail(userEmail);

    if (password != null) {
      await savePassword(password);
    }
  }

  /// 로그인 정보 가져오기 (한 번에)
  static Future<Map<String, String?>> getLoginInfo() async {
    return {
      'accessToken': await getAccessToken(),
      'refreshToken': await getRefreshToken(),
      'userId': await getUserId(),
      'userEmail': await getUserEmail(),
      'password': await getPassword(),
    };
  }

  /// 로그인 정보 삭제 (한 번에)
  static Future<void> deleteLoginInfo() async {
    await deleteAccessToken();
    await deleteRefreshToken();
    await deleteUserId();
    await deleteUserEmail();
    await deletePassword();
  }

  /// 로그인 상태 확인
  static Future<bool> isLoggedIn() async {
    final accessToken = await getAccessToken();
    return accessToken != null && accessToken.isNotEmpty;
  }

  /// 토큰 만료 확인 (간단한 방식)
  static Future<bool> isTokenExpired() async {
    final accessToken = await getAccessToken();
    if (accessToken == null) return true;

    // JWT 토큰의 경우 payload 부분을 디코드하여 만료 시간 확인
    try {
      final parts = accessToken.split('.');
      if (parts.length != 3) return true;

      final payload = parts[1];
      final normalized = base64Url.normalize(payload);
      final resp = utf8.decode(base64Url.decode(normalized));
      final payloadMap = json.decode(resp);

      final exp = payloadMap['exp'] as int?;
      if (exp == null) return true;

      final expiry = DateTime.fromMillisecondsSinceEpoch(exp * 1000);
      return DateTime.now().isAfter(expiry);
    } catch (e) {
      // 토큰 파싱 실패 시 만료된 것으로 간주
      return true;
    }
  }
}
