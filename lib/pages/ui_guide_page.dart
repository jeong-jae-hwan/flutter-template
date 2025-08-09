import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UiGuidePage extends StatelessWidget {
  const UiGuidePage({super.key});

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
                  Icon(Icons.dashboard, size: 60, color: Colors.indigo),
                  SizedBox(height: 16),
                  Text(
                    'GetX UI 기능 가이드',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '다양한 UI 기능들을 직접 체험해보세요',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // UI 기능 예제들
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // 스낵바 예제
                    _buildFeatureCard(
                      context,
                      title: '스낵바 (Snackbar)',
                      description: '하단 알림 메시지 표시',
                      icon: Icons.message,
                      color: Colors.green,
                      onTap: () => _showSnackbarExamples(),
                    ),

                    const SizedBox(height: 16),

                    // 다이얼로그 예제
                    _buildFeatureCard(
                      context,
                      title: '다이얼로그 (Dialog)',
                      description: '커스텀 다이얼로그 표시',
                      icon: Icons.chat_bubble,
                      color: Colors.blue,
                      onTap: () => _showDialogExamples(),
                    ),

                    const SizedBox(height: 16),

                    // 바텀시트 예제
                    _buildFeatureCard(
                      context,
                      title: '바텀시트 (BottomSheet)',
                      description: '하단에서 올라오는 옵션 시트',
                      icon: Icons.keyboard_arrow_up,
                      color: Colors.orange,
                      onTap: () => _showBottomSheetExamples(),
                    ),

                    const SizedBox(height: 16),

                    // 로딩 예제
                    _buildFeatureCard(
                      context,
                      title: '로딩 (Loading)',
                      description: '로딩 인디케이터 표시',
                      icon: Icons.hourglass_empty,
                      color: Colors.purple,
                      onTap: () => _showLoadingExamples(),
                    ),

                    const SizedBox(height: 16),

                    // 토스트 예제
                    _buildFeatureCard(
                      context,
                      title: '토스트 (Toast)',
                      description: '간단한 토스트 메시지',
                      icon: Icons.notifications,
                      color: Colors.teal,
                      onTap: () => _showToastExamples(),
                    ),

                    const SizedBox(height: 16),

                    // 확인 다이얼로그 예제
                    _buildFeatureCard(
                      context,
                      title: '확인 다이얼로그',
                      description: '간단한 확인/취소 다이얼로그',
                      icon: Icons.question_answer,
                      color: Colors.red,
                      onTap: () => _showConfirmDialogExamples(),
                    ),

                    const SizedBox(height: 30),

                    // 사용법 설명
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.indigo.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.indigo.withValues(alpha: 0.3),
                        ),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'GetX UI 기능 사용법',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo,
                            ),
                          ),
                          SizedBox(height: 12),
                          _UsageItem(
                            icon: Icons.message,
                            text: 'Get.snackbar() - 알림 메시지',
                          ),
                          _UsageItem(
                            icon: Icons.chat_bubble,
                            text: 'Get.dialog() - 커스텀 다이얼로그',
                          ),
                          _UsageItem(
                            icon: Icons.keyboard_arrow_up,
                            text: 'Get.bottomSheet() - 하단 시트',
                          ),
                          _UsageItem(
                            icon: Icons.hourglass_empty,
                            text: 'Get.dialog() - 로딩 표시',
                          ),
                          _UsageItem(
                            icon: Icons.notifications,
                            text: 'Get.snackbar() - 토스트 메시지',
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

  Widget _buildFeatureCard(
    BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
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
                      description,
                      style: TextStyle(
                        fontSize: 14,
                        color: color,
                        fontWeight: FontWeight.w500,
                      ),
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

  // 스낵바 예제들
  void _showSnackbarExamples() {
    Get.bottomSheet(
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 핸들 바
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const Text(
                '스낵바 예제',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                    Get.snackbar(
                      '성공',
                      '데이터가 저장되었습니다.',
                      backgroundColor: Colors.green,
                      colorText: Colors.white,
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('성공 메시지'),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                    Get.snackbar(
                      '오류',
                      '네트워크 연결을 확인해주세요.',
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('에러 메시지'),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                    Get.snackbar(
                      '알림',
                      '새로운 메시지가 도착했습니다.',
                      backgroundColor: Colors.blue,
                      colorText: Colors.white,
                      icon: const Icon(Icons.info, color: Colors.white),
                      duration: const Duration(seconds: 4),
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('아이콘 포함 메시지'),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
      enableDrag: true,
    );
  }

  // 다이얼로그 예제들
  void _showDialogExamples() {
    Get.bottomSheet(
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 핸들 바
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const Text(
                '다이얼로그 예제',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                    Get.dialog(
                      AlertDialog(
                        title: const Text('확인'),
                        content: const Text('정말 삭제하시겠습니까?'),
                        actions: [
                          TextButton(
                            onPressed: () => Get.back(),
                            child: const Text('취소'),
                          ),
                          TextButton(
                            onPressed: () {
                              Get.back();
                              Get.snackbar('성공', '삭제되었습니다.');
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.red,
                            ),
                            child: const Text('삭제'),
                          ),
                        ],
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('기본 다이얼로그'),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                    _showInputDialog();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('입력 다이얼로그'),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
      enableDrag: true,
    );
  }

  // 입력 다이얼로그
  void _showInputDialog() {
    final textController = TextEditingController();

    Get.dialog(
      AlertDialog(
        title: const Text('이름 입력'),
        content: TextField(
          controller: textController,
          decoration: const InputDecoration(
            hintText: '이름을 입력하세요',
            border: OutlineInputBorder(),
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('취소')),
          ElevatedButton(
            onPressed: () {
              final name = textController.text.trim();
              if (name.isNotEmpty) {
                Get.back();
                Get.snackbar('성공', '입력된 이름: $name');
              }
            },
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }

  // 바텀시트 예제들
  void _showBottomSheetExamples() {
    Get.bottomSheet(
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 핸들 바
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const Text(
                '바텀시트 예제',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                    _showOptionsBottomSheet();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('옵션 시트'),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                    _showProfileBottomSheet();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('프로필 설정 시트'),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
      enableDrag: true,
    );
  }

  // 옵션 바텀시트
  void _showOptionsBottomSheet() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              '옵션 선택',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('수정'),
              onTap: () {
                Get.back();
                Get.snackbar('알림', '수정 기능이 선택되었습니다.');
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('삭제'),
              onTap: () {
                Get.back();
                Get.snackbar('알림', '삭제 기능이 선택되었습니다.');
              },
            ),
            ListTile(
              leading: const Icon(Icons.share),
              title: const Text('공유'),
              onTap: () {
                Get.back();
                Get.snackbar('알림', '공유 기능이 선택되었습니다.');
              },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
    );
  }

  // 프로필 설정 바텀시트
  void _showProfileBottomSheet() {
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 핸들 바
            Container(
              margin: const EdgeInsets.only(top: 8),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                '프로필 설정',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.blue,
                child: Icon(Icons.person, color: Colors.white),
              ),
              title: const Text('프로필 편집'),
              subtitle: const Text('이름, 사진, 소개를 변경하세요'),
              onTap: () {
                Get.back();
                Get.snackbar('알림', '프로필 편집 페이지로 이동합니다.');
              },
            ),
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.green,
                child: Icon(Icons.notifications, color: Colors.white),
              ),
              title: const Text('알림 설정'),
              subtitle: const Text('푸시 알림을 관리하세요'),
              onTap: () {
                Get.back();
                Get.snackbar('알림', '알림 설정 페이지로 이동합니다.');
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      isScrollControlled: true,
      enableDrag: true,
    );
  }

  // 로딩 예제들
  void _showLoadingExamples() {
    Get.bottomSheet(
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 핸들 바
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const Text(
                '로딩 예제',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                    _showCustomLoading();
                    Future.delayed(const Duration(seconds: 2), () {
                      Get.back();
                      Get.snackbar('완료', '로딩이 완료되었습니다.');
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('기본 로딩'),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                    _showCustomLoading();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('커스텀 로딩'),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
      enableDrag: true,
    );
  }

  // 커스텀 로딩
  void _showCustomLoading() {
    Get.dialog(
      Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('데이터를 불러오는 중...'),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );

    Future.delayed(const Duration(seconds: 3), () {
      Get.back();
      Get.snackbar('완료', '커스텀 로딩이 완료되었습니다.');
    });
  }

  // 토스트 예제들
  void _showToastExamples() {
    Get.bottomSheet(
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 핸들 바
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const Text(
                '토스트 예제',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                    Get.snackbar('토스트', '간단한 토스트 메시지');
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('기본 토스트'),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                    Get.snackbar(
                      '성공 토스트',
                      '성공 메시지입니다.',
                      backgroundColor: Colors.green,
                      colorText: Colors.white,
                      duration: const Duration(seconds: 2),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('성공 토스트'),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
      enableDrag: true,
    );
  }

  // 확인 다이얼로그 예제들
  void _showConfirmDialogExamples() {
    Get.bottomSheet(
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 핸들 바
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const Text(
                '확인 다이얼로그 예제',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                    Get.defaultDialog(
                      title: '확인',
                      content: const Text('정말 삭제하시겠습니까?'),
                      onConfirm: () {
                        Get.back();
                        Get.snackbar('성공', '삭제되었습니다.');
                      },
                      onCancel: () => Get.back(),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('기본 확인 다이얼로그'),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                    Get.defaultDialog(
                      title: '로그아웃',
                      content: const Text('로그아웃하시겠습니까?'),
                      textConfirm: '로그아웃',
                      textCancel: '취소',
                      confirmTextColor: Colors.white,
                      cancelTextColor: Colors.grey,
                      onConfirm: () {
                        Get.back();
                        Get.snackbar('알림', '로그아웃되었습니다.');
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('커스텀 확인 다이얼로그'),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
      enableDrag: true,
    );
  }
}

class _UsageItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const _UsageItem({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.indigo),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }
}
