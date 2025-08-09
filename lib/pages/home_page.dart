import 'package:flutter/material.dart';
import 'package:flutter_template/pages/counter_page.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
                  Text(
                    'GetX 튜토리얼',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Flutter GetX를 쉽게 배워보세요!',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // 학습 단계별 카드들
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildLearningCard(
                      context,
                      icon: Icons.add_circle,
                      title: '1단계: 기본 상태관리',
                      subtitle: '카운터 앱으로 GetX 상태관리 배우기',
                      description: 'Obx(), .obs, GetX 컨트롤러의 기본 사용법을 학습합니다.',
                      color: Colors.blue,
                      onTap: () => _showSnackbar('카운터 탭으로 이동하세요!'),
                    ),

                    const SizedBox(height: 16),

                    _buildLearningCard(
                      context,
                      icon: Icons.checklist,
                      title: '2단계: 할일 관리 앱',
                      subtitle: '실제 앱으로 GetX 활용하기',
                      description: '할일 추가, 삭제, 완료 처리를 통해 GetX의 실전 사용법을 배웁니다.',
                      color: Colors.green,
                      onTap: () => _showSnackbar('할일 탭으로 이동하세요!'),
                    ),

                    const SizedBox(height: 16),

                    _buildLearningCard(
                      context,
                      icon: Icons.people,
                      title: '3단계: 사용자 관리',
                      subtitle: '복잡한 데이터 구조 다루기',
                      description: '사용자 목록 관리, 검색, 필터링을 통해 고급 GetX 기능을 학습합니다.',
                      color: Colors.orange,
                      onTap: () => _showSnackbar('사용자 탭으로 이동하세요!'),
                    ),

                    const SizedBox(height: 16),

                    _buildLearningCard(
                      context,
                      icon: Icons.api,
                      title: '4단계: API 연동',
                      subtitle: '서버와 통신하는 앱 만들기',
                      description: 'HTTP 요청, 로딩 상태, 에러 처리를 통해 실제 API 연동을 배웁니다.',
                      color: Colors.purple,
                      onTap: () => _showSnackbar('API 탭으로 이동하세요!'),
                    ),

                    const SizedBox(height: 40),

                    // GetX 특징 설명
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'GetX의 장점',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 12),
                          _FeatureItem(
                            icon: Icons.speed,
                            text: '간단한 문법 - 복잡한 설정 없이 바로 사용',
                          ),
                          _FeatureItem(
                            icon: Icons.memory,
                            text: '자동 메모리 관리 - 메모리 누수 걱정 없음',
                          ),
                          _FeatureItem(
                            icon: Icons.update,
                            text: '반응형 UI - 데이터 변경시 자동 업데이트',
                          ),
                          _FeatureItem(
                            icon: Icons.route,
                            text: '간단한 라우팅 - Get.to(), Get.back() 등',
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    GestureDetector(
                      onTap: () {
                        Get.to(
                          () => const CounterPage(),
                          transition: Transition.rightToLeft,
                        );
                      },
                      child: const Text('CounterPage로 이동'),
                    ),

                    const SizedBox(height: 20),

                    // 학습 자료 링크
                    Center(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Get.snackbar(
                            '학습 자료',
                            '_doc 폴더에서 상세한 학습 자료를 확인하세요!',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.deepPurple,
                            colorText: Colors.white,
                          );
                        },
                        icon: const Icon(Icons.book),
                        label: const Text('학습 자료 보기'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                        ),
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

  Widget _buildLearningCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required String description,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 32),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: color,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      description,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: Colors.grey[400], size: 16),
            ],
          ),
        ),
      ),
    );
  }

  void _showSnackbar(String message) {
    Get.snackbar(
      '안내',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.deepPurple,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
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
          Icon(icon, size: 16, color: Colors.deepPurple),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }
}
