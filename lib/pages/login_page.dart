import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';

/// 로그인 테스트 페이지
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    // GetX 컨트롤러 초기화
    final AuthController authController = Get.put(AuthController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('로그인 테스트'),
        centerTitle: true,
        actions: [
          // 로그인 상태 표시
          Obx(
            () => Container(
              padding: const EdgeInsets.all(8),
              child: Icon(
                authController.isLoggedIn.value
                    ? Icons.check_circle
                    : Icons.cancel,
                color: authController.isLoggedIn.value
                    ? Colors.green
                    : Colors.red,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 로그인 상태 정보
              _buildSection(
                title: '🔐 로그인 상태',
                children: [
                  Obx(
                    () => _buildInfoCard(
                      '로그인 상태',
                      authController.isLoggedIn.value ? '로그인됨' : '로그아웃됨',
                    ),
                  ),
                  Obx(
                    () => _buildInfoCard(
                      '사용자 이름',
                      authController.userName.value.isEmpty
                          ? '없음'
                          : authController.userName.value,
                    ),
                  ),
                  Obx(
                    () => _buildInfoCard(
                      '사용자 이메일',
                      authController.userEmail.value.isEmpty
                          ? '없음'
                          : authController.userEmail.value,
                    ),
                  ),
                  Obx(
                    () => _buildInfoCard(
                      '사용자 ID',
                      authController.userId.value.isEmpty
                          ? '없음'
                          : authController.userId.value,
                    ),
                  ),
                  Obx(
                    () => _buildInfoCard(
                      '액세스 토큰',
                      authController.accessToken.value.isEmpty
                          ? '없음'
                          : '${authController.accessToken.value.substring(0, 20)}...',
                    ),
                  ),
                  Obx(
                    () => _buildInfoCard(
                      '리프레시 토큰',
                      authController.refreshToken.value.isEmpty
                          ? '없음'
                          : '${authController.refreshToken.value.substring(0, 20)}...',
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // 로그인 시도 정보
              _buildSection(
                title: '📊 로그인 시도 정보',
                children: [
                  Obx(
                    () => _buildInfoCard(
                      '로그인 시도 횟수',
                      authController.loginAttempts.value.toString(),
                    ),
                  ),
                  Obx(
                    () => _buildInfoCard(
                      '마지막 로그인',
                      authController.lastLoginTime.value.isEmpty
                          ? '없음'
                          : authController.lastLoginTime.value,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // 로그인 폼
              _buildSection(
                title: '🔑 로그인',
                children: [_buildLoginForm(authController)],
              ),

              const SizedBox(height: 20),

              // 토큰 관리
              _buildSection(
                title: '🔄 토큰 관리',
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => _testTokenExpiry(authController),
                          icon: const Icon(Icons.timer),
                          label: const Text('토큰 만료 확인'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => _refreshToken(authController),
                          icon: const Icon(Icons.refresh),
                          label: const Text('토큰 갱신'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // 자동 로그인 테스트
              _buildSection(
                title: '🚀 자동 로그인 테스트',
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => _testAutoLogin(authController),
                          icon: const Icon(Icons.play_arrow),
                          label: const Text('자동 로그인'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // 로그아웃
              _buildSection(
                title: '🚪 로그아웃',
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => _logout(authController),
                          icon: const Icon(Icons.logout),
                          label: const Text('로그아웃'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // 저장된 데이터 확인
              _buildSection(
                title: '💾 저장된 데이터 확인',
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => _showStoredData(authController),
                          icon: const Icon(Icons.storage),
                          label: const Text('저장된 데이터'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
          ),
        ),
        const SizedBox(height: 10),
        ...children,
      ],
    );
  }

  Widget _buildInfoCard(String label, String value) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                value,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginForm(AuthController controller) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    bool rememberMe = false;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: '이메일',
                hintText: 'example@email.com',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: '비밀번호',
                hintText: '비밀번호를 입력하세요',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Checkbox(
                  value: rememberMe,
                  onChanged: (value) => rememberMe = value ?? false,
                ),
                const Text('로그인 정보 기억하기'),
              ],
            ),
            const SizedBox(height: 16),
            Obx(
              () => SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.isLoading.value
                      ? null
                      : () => _login(
                          controller,
                          emailController,
                          passwordController,
                          rememberMe,
                        ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: controller.isLoading.value
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('로그인'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _login(
    AuthController controller,
    TextEditingController emailController,
    TextEditingController passwordController,
    bool rememberMe,
  ) async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar(
        '입력 오류',
        '이메일과 비밀번호를 모두 입력해주세요.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    final success = await controller.login(
      email: email,
      password: password,
      rememberMe: rememberMe,
    );

    if (success) {
      emailController.clear();
      passwordController.clear();
    }
  }

  void _logout(AuthController controller) async {
    await controller.logout();
  }

  void _refreshToken(AuthController controller) async {
    final success = await controller.refreshAccessToken();
    if (success) {
      Get.snackbar(
        '토큰 갱신',
        '토큰이 성공적으로 갱신되었습니다.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } else {
      Get.snackbar(
        '토큰 갱신 실패',
        '토큰 갱신에 실패했습니다.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void _testTokenExpiry(AuthController controller) async {
    final isExpired = await controller.isTokenExpired();
    Get.snackbar(
      '토큰 만료 확인',
      isExpired ? '토큰이 만료되었습니다.' : '토큰이 유효합니다.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: isExpired ? Colors.red : Colors.green,
      colorText: Colors.white,
    );
  }

  void _testAutoLogin(AuthController controller) async {
    final success = await controller.tryAutoLogin();
    Get.snackbar(
      '자동 로그인',
      success ? '자동 로그인에 성공했습니다.' : '자동 로그인에 실패했습니다.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: success ? Colors.green : Colors.red,
      colorText: Colors.white,
    );
  }

  void _showStoredData(AuthController controller) async {
    final userInfo = controller.getUserInfo();
    final infoText = userInfo.entries
        .map((e) => '${e.key}: ${e.value.isEmpty ? "없음" : e.value}')
        .join('\n');

    Get.dialog(
      AlertDialog(
        title: const Text('저장된 사용자 정보'),
        content: SingleChildScrollView(child: Text(infoText)),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('닫기')),
        ],
      ),
    );
  }
}
