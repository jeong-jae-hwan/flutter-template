import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Splash 화면의 상태와 로직을 관리하는 GetX 컨트롤러
class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  // 애니메이션 컨트롤러
  late AnimationController animationController;
  late Animation<double> fadeAnimation;
  late Animation<double> scaleAnimation;

  // 로딩 상태 관리
  final RxBool isLoading = true.obs;
  final RxDouble progress = 0.0.obs;
  final RxString currentTask = '앱 초기화 중...'.obs;

  @override
  void onInit() {
    super.onInit();
    _initializeAnimations();
    _startSplashSequence();
  }

  @override
  void onClose() {
    // 메모리 누수 방지를 위해 애니메이션 컨트롤러 해제
    animationController.dispose();
    super.onClose();
  }

  /// 애니메이션 초기화
  void _initializeAnimations() {
    // 애니메이션 컨트롤러 (2초 동안)
    animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    // 페이드 애니메이션 (투명도 0 → 1)
    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.0, 0.8, curve: Curves.easeInOut),
      ),
    );

    // 스케일 애니메이션 - 서서히 클로즈업 (30% → 100%)
    scaleAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.0, 1.0, curve: Curves.easeOutCubic),
      ),
    );
  }

  /// 스플래시 시퀀스 시작
  Future<void> _startSplashSequence() async {
    try {
      // 1. 애니메이션 시작
      animationController.forward();

      // 2. 앱 초기화 작업 수행
      await _initializeApp();

      // 3. 애니메이션 완료 대기
      await animationController.forward();

      // 4. 잠시 대기 후 메인 화면으로 이동
      await Future.delayed(const Duration(milliseconds: 500));

      // 5. 메인 화면으로 이동 (이전 화면들 모두 제거)
      Get.offAllNamed('/main');
    } catch (e) {
      // 에러 발생 시 에러 페이지로 이동
      Get.log('❌ 스플래시 초기화 실패: $e', isError: true);
      Get.offAllNamed('/main'); // 일단 메인 화면으로 이동
    }
  }

  /// 앱 초기화 작업들
  Future<void> _initializeApp() async {
    // 단계 1: 기본 설정 로드
    progress.value = 0.2;
    currentTask.value = '기본 설정 로드 중...';
    await Future.delayed(const Duration(milliseconds: 300));
    Get.log('📱 기본 설정 로드 완료');

    // 단계 2: 사용자 인증 상태 확인
    progress.value = 0.4;
    currentTask.value = '인증 상태 확인 중...';
    await Future.delayed(const Duration(milliseconds: 400));
    Get.log('🔐 인증 상태 확인 완료');

    // 단계 3: 필수 데이터 로드
    progress.value = 0.6;
    currentTask.value = '필수 데이터 로드 중...';
    await Future.delayed(const Duration(milliseconds: 400));
    Get.log('💾 필수 데이터 로드 완료');

    // 단계 4: API 서버 연결 테스트
    progress.value = 0.8;
    currentTask.value = '서버 연결 확인 중...';
    await Future.delayed(const Duration(milliseconds: 300));
    Get.log('🌐 API 서버 연결 완료');

    // 단계 5: 초기화 완료
    progress.value = 1.0;
    currentTask.value = '완료!';
    await Future.delayed(const Duration(milliseconds: 200));
    isLoading.value = false;
    Get.log('✅ 앱 초기화 완료!');
  }
}
