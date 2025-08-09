import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/counter_controller.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CounterController controller = Get.put(CounterController());

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
                  SizedBox(height: 16),
                  Text(
                    '1단계: 기본 상태관리',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'GetX의 핵심 기능을 배워보세요',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // 카운터 섹션
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
                            const Text(
                              '카운터 앱',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 20),

                            // 반응형 카운터 표시
                            Obx(
                              () => Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Colors.blue.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  '${controller.count.value}',
                                  style: const TextStyle(
                                    fontSize: 48,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 20),

                            // 버튼들
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton.icon(
                                  onPressed: controller.decrement,
                                  icon: const Icon(Icons.remove),
                                  label: const Text('감소'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    foregroundColor: Colors.white,
                                  ),
                                ),
                                ElevatedButton.icon(
                                  onPressed: controller.increment,
                                  icon: const Icon(Icons.add),
                                  label: const Text('증가'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    foregroundColor: Colors.white,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 16),

                            ElevatedButton.icon(
                              onPressed: controller.reset,
                              icon: const Icon(Icons.refresh),
                              label: const Text('초기화'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange,
                                foregroundColor: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // 추가 기능들
                    Card(
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '추가 기능',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),

                            // 이름 변경
                            Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: controller.nameController,
                                    decoration: const InputDecoration(
                                      labelText: '이름 입력',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                ElevatedButton(
                                  onPressed: controller.changeName,
                                  child: const Text('변경'),
                                ),
                              ],
                            ),

                            const SizedBox(height: 16),

                            // 이름 표시
                            Obx(
                              () => Text(
                                '안녕하세요, ${controller.name.value}님!',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),

                            const SizedBox(height: 16),

                            // 보이기/숨기기 토글
                            Obx(
                              () => Row(
                                children: [
                                  Text(
                                    '텍스트 표시: ',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  Switch(
                                    value: controller.isVisible.value,
                                    onChanged: (value) =>
                                        controller.toggleVisibility(),
                                  ),
                                  const SizedBox(width: 8),
                                  if (controller.isVisible.value)
                                    const Text(
                                      '보임',
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  else
                                    const Text(
                                      '숨김',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 12),

                            // 조건부 텍스트
                            Obx(
                              () => Visibility(
                                visible: controller.isVisible.value,
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.green.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Text(
                                    '이 텍스트는 토글 버튼으로 보이거나 숨겨집니다!',
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // 학습 포인트
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.blue.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.blue.withValues(alpha: 0.3),
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
                              color: Colors.blue,
                            ),
                          ),
                          SizedBox(height: 12),
                          _LearningPoint(
                            icon: Icons.radio_button_checked,
                            text: '.obs - 반응형 변수 선언',
                          ),
                          _LearningPoint(
                            icon: Icons.radio_button_checked,
                            text: 'Obx() - 반응형 UI 위젯',
                          ),
                          _LearningPoint(
                            icon: Icons.radio_button_checked,
                            text: '.value - 반응형 변수 값 변경',
                          ),
                          _LearningPoint(
                            icon: Icons.radio_button_checked,
                            text: 'Get.put() - 컨트롤러 등록',
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
          Icon(icon, size: 16, color: Colors.blue),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }
}
