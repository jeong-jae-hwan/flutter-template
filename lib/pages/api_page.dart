import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApiPage extends StatelessWidget {
  const ApiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            // 헤더
            const Center(
              child: Column(
                children: [
                  Icon(Icons.api, size: 60, color: Colors.purple),
                  SizedBox(height: 16),
                  Text(
                    '4단계: API 연동',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '서버와 통신하는 앱 만들기',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // 준비 중 메시지
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Card(
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            const Icon(
                              Icons.construction,
                              size: 60,
                              color: Colors.purple,
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              '준비 중입니다',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'API 연동 기능이 곧 추가될 예정입니다.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton.icon(
                              onPressed: () {
                                Get.snackbar(
                                  '알림',
                                  '곧 API 연동 기능이 추가됩니다!',
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.purple,
                                  colorText: Colors.white,
                                );
                              },
                              icon: const Icon(Icons.notifications),
                              label: const Text('알림 받기'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.purple,
                                foregroundColor: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // 예상 기능 설명
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.purple.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.purple.withValues(alpha: 0.3),
                        ),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '예상 기능',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple,
                            ),
                          ),
                          SizedBox(height: 12),
                          _FeatureItem(
                            icon: Icons.http,
                            text: 'HTTP 요청 (GET, POST, PUT, DELETE)',
                          ),
                          _FeatureItem(
                            icon: Icons.download,
                            text: '데이터 로딩 상태 관리',
                          ),
                          _FeatureItem(
                            icon: Icons.error,
                            text: '에러 처리 및 사용자 피드백',
                          ),
                          _FeatureItem(
                            icon: Icons.storage,
                            text: '데이터 캐싱 및 최적화',
                          ),
                          _FeatureItem(
                            icon: Icons.refresh,
                            text: '자동 새로고침 및 동기화',
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    // 학습 포인트
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.purple.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.purple.withValues(alpha: 0.3),
                        ),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '학습 포인트',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple,
                            ),
                          ),
                          SizedBox(height: 12),
                          _LearningPoint(
                            icon: Icons.api,
                            text: 'GetX HTTP 클라이언트 사용법',
                          ),
                          _LearningPoint(
                            icon: Icons.hourglass_empty,
                            text: '로딩 상태 관리 (.obs)',
                          ),
                          _LearningPoint(
                            icon: Icons.error_outline,
                            text: '에러 처리 및 사용자 알림',
                          ),
                          _LearningPoint(
                            icon: Icons.data_usage,
                            text: 'JSON 데이터 파싱 및 모델링',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const _FeatureItem({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.purple),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }
}

class _LearningPoint extends StatelessWidget {
  final IconData icon;
  final String text;

  const _LearningPoint({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.purple),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }
}
