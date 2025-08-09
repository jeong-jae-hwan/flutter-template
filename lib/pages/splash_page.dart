import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

/// GetX 방식으로 구현된 Splash 화면
///
/// 주요 특징:
/// - GetX Controller를 사용한 상태 관리
/// - 애니메이션과 비즈니스 로직 분리
/// - 메모리 효율적인 리소스 관리
class SplashPage extends GetView<SplashController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    // GetX Controller 인스턴스 생성 (자동으로 onInit 호출됨)
    Get.put(SplashController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedBuilder(
          // Controller의 애니메이션 사용
          animation: controller.animationController,
          builder: (context, child) {
            return FadeTransition(
              opacity: controller.fadeAnimation,
              child: ScaleTransition(
                scale: controller.scaleAnimation,
                child: Image.asset(
                  'assets/images/favicon.png',
                  width: 120,
                  height: 120,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 120,
                      height: 120,
                      color: Colors.grey[300],
                      child: const Icon(
                        Icons.flutter_dash,
                        size: 60,
                        color: Colors.blue,
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
