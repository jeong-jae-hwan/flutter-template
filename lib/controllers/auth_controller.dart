import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/secure_storage_service.dart';
import '../services/storage_service.dart';

/// 인증 상태를 관리하는 컨트롤러
///
/// 로그인, 로그아웃, 토큰 관리 등을 담당합니다.
class AuthController extends GetxController {
  // 🔐 인증 상태 관련 반응형 변수들
  final RxBool isLoggedIn = false.obs;
  final RxBool isLoading = false.obs;
  final RxString accessToken = ''.obs;
  final RxString refreshToken = ''.obs;
  final RxString userId = ''.obs;
  final RxString userEmail = ''.obs;
  final RxString userName = ''.obs;

  // 📊 로그인 시도 관련 변수들
  final RxInt loginAttempts = 0.obs;
  final RxString lastLoginTime = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // 앱 시작 시 저장된 로그인 정보 확인
    _checkLoginStatus();
  }

  /// 저장된 로그인 정보 확인
  Future<void> _checkLoginStatus() async {
    try {
      isLoading.value = true;

      // 보안 저장소에서 토큰 확인
      final savedAccessToken = await SecureStorageService.getAccessToken();
      final savedRefreshToken = await SecureStorageService.getRefreshToken();
      final savedUserId = await SecureStorageService.getUserId();
      final savedUserEmail = await SecureStorageService.getUserEmail();

      if (savedAccessToken != null && savedAccessToken.isNotEmpty) {
        // 토큰이 있으면 로그인 상태로 설정
        accessToken.value = savedAccessToken;
        refreshToken.value = savedRefreshToken ?? '';
        userId.value = savedUserId ?? '';
        userEmail.value = savedUserEmail ?? '';
        isLoggedIn.value = true;

        // 일반 저장소에서 사용자 이름 가져오기
        final savedUserName = await StorageService.getString('user_name');
        if (savedUserName != null) {
          userName.value = savedUserName;
        }

        Get.log('✅ 저장된 로그인 정보로 자동 로그인 완료');
      } else {
        Get.log('❌ 저장된 로그인 정보 없음');
      }
    } catch (e) {
      Get.log('❌ 로그인 상태 확인 중 오류: $e', isError: true);
    } finally {
      isLoading.value = false;
    }
  }

  /// 로그인 처리
  Future<bool> login({
    required String email,
    required String password,
    bool rememberMe = false,
  }) async {
    try {
      isLoading.value = true;
      loginAttempts.value++;

      // 실제 앱에서는 여기서 API 호출
      // 지금은 시뮬레이션으로 처리
      await Future.delayed(Duration(seconds: 2));

      // 시뮬레이션된 로그인 성공
      final mockAccessToken =
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyLCJleHAiOjE3NzY4MDAwMDB9.mock_signature';
      final mockRefreshToken =
          'refresh_token_${DateTime.now().millisecondsSinceEpoch}';
      final mockUserId = 'user_${DateTime.now().millisecondsSinceEpoch}';

      // 로그인 정보 저장
      await _saveLoginInfo(
        accessToken: mockAccessToken,
        refreshToken: mockRefreshToken,
        userId: mockUserId,
        userEmail: email,
        userName: email.split('@')[0], // 이메일에서 이름 추출
        rememberMe: rememberMe,
      );

      // 반응형 변수 업데이트
      isLoggedIn.value = true;
      accessToken.value = mockAccessToken;
      refreshToken.value = mockRefreshToken;
      userId.value = mockUserId;
      userEmail.value = email;
      userName.value = email.split('@')[0];

      // 로그인 시간 기록
      lastLoginTime.value = DateTime.now().toIso8601String();
      await StorageService.setString('last_login_time', lastLoginTime.value);

      Get.snackbar(
        '로그인 성공',
        '환영합니다, ${userName.value}님!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      return true;
    } catch (e) {
      Get.log('❌ 로그인 실패: $e', isError: true);
      Get.snackbar(
        '로그인 실패',
        '이메일 또는 비밀번호를 확인해주세요.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  /// 로그인 정보 저장
  Future<void> _saveLoginInfo({
    required String accessToken,
    required String refreshToken,
    required String userId,
    required String userEmail,
    required String userName,
    required bool rememberMe,
  }) async {
    // 보안 저장소에 민감한 정보 저장
    await SecureStorageService.saveLoginInfo(
      accessToken: accessToken,
      refreshToken: refreshToken,
      userId: userId,
      userEmail: userEmail,
    );

    // 일반 저장소에 공개 정보 저장
    await StorageService.setString('user_name', userName);
    await StorageService.setBool('remember_me', rememberMe);
    await StorageService.setInt('login_attempts', loginAttempts.value);
  }

  /// 로그아웃 처리
  Future<void> logout() async {
    try {
      isLoading.value = true;

      // 모든 로그인 정보 삭제
      await SecureStorageService.deleteLoginInfo();
      await StorageService.remove('user_name');
      await StorageService.remove('remember_me');
      await StorageService.remove('last_login_time');

      // 반응형 변수 초기화
      isLoggedIn.value = false;
      accessToken.value = '';
      refreshToken.value = '';
      userId.value = '';
      userEmail.value = '';
      userName.value = '';
      loginAttempts.value = 0;
      lastLoginTime.value = '';

      Get.snackbar(
        '로그아웃',
        '안전하게 로그아웃되었습니다.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.blue,
        colorText: Colors.white,
      );

      Get.log('✅ 로그아웃 완료');
    } catch (e) {
      Get.log('❌ 로그아웃 중 오류: $e', isError: true);
      Get.snackbar(
        '오류',
        '로그아웃 중 문제가 발생했습니다.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// 토큰 갱신
  Future<bool> refreshAccessToken() async {
    try {
      isLoading.value = true;

      final currentRefreshToken = await SecureStorageService.getRefreshToken();
      if (currentRefreshToken == null) {
        Get.log('❌ 리프레시 토큰이 없습니다.', isError: true);
        return false;
      }

      // 실제 앱에서는 여기서 API 호출하여 새 토큰 발급
      // 지금은 시뮬레이션으로 처리
      await Future.delayed(Duration(seconds: 1));

      // 시뮬레이션된 새 토큰
      final newAccessToken =
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyLCJleHAiOjE3NzY4MDAwMDB9.new_signature';
      final newRefreshToken =
          'refresh_token_${DateTime.now().millisecondsSinceEpoch}';

      // 새 토큰 저장
      await SecureStorageService.saveAccessToken(newAccessToken);
      await SecureStorageService.saveRefreshToken(newRefreshToken);

      // 반응형 변수 업데이트
      accessToken.value = newAccessToken;
      refreshToken.value = newRefreshToken;

      Get.log('✅ 토큰 갱신 완료');
      return true;
    } catch (e) {
      Get.log('❌ 토큰 갱신 실패: $e', isError: true);
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  /// 토큰 만료 확인
  Future<bool> isTokenExpired() async {
    return await SecureStorageService.isTokenExpired();
  }

  /// 자동 로그인 시도
  Future<bool> tryAutoLogin() async {
    try {
      final isLoggedIn = await SecureStorageService.isLoggedIn();
      if (!isLoggedIn) return false;

      final isExpired = await isTokenExpired();
      if (isExpired) {
        // 토큰이 만료되었으면 갱신 시도
        final refreshSuccess = await refreshAccessToken();
        if (!refreshSuccess) {
          // 갱신 실패 시 로그아웃
          await logout();
          return false;
        }
      }

      // 로그인 상태 복원
      await _checkLoginStatus();
      return true;
    } catch (e) {
      Get.log('❌ 자동 로그인 실패: $e', isError: true);
      return false;
    }
  }

  /// 로그인 상태 확인
  bool get isUserLoggedIn => isLoggedIn.value;

  /// 로딩 상태 확인
  bool get isAuthLoading => isLoading.value;

  /// 사용자 정보 가져오기
  Map<String, String> getUserInfo() {
    return {
      'userId': userId.value,
      'userEmail': userEmail.value,
      'userName': userName.value,
      'accessToken': accessToken.value,
      'refreshToken': refreshToken.value,
    };
  }

  /// 로그인 시도 횟수 확인
  int get getLoginAttempts => loginAttempts.value;

  /// 마지막 로그인 시간 확인
  String get getLastLoginTime => lastLoginTime.value;
}
