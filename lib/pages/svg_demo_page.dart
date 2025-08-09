import 'package:flutter/material.dart';

/// SVG 사용 예제 페이지
class SvgDemoPage extends StatelessWidget {
  const SvgDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SVG 데모'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 기본 SVG 사용법
              _buildSection(
                title: '🎨 기본 SVG 사용법',
                children: [
                  _buildInfoCard('SVG 파일 로드', 'assets/svg/example.svg'),
                  const SizedBox(height: 10),
                  _buildSvgExample(),
                ],
              ),

              const SizedBox(height: 20),

              // SVG 크기 조절
              _buildSection(
                title: '📏 SVG 크기 조절',
                children: [
                  _buildInfoCard('width, height 속성 사용', '크기 조절 가능'),
                  const SizedBox(height: 10),
                  _buildSvgSizeExamples(),
                ],
              ),

              const SizedBox(height: 20),

              // SVG 색상 변경
              _buildSection(
                title: '🎨 SVG 색상 변경',
                children: [
                  _buildInfoCard('color 속성 사용', '색상 변경 가능'),
                  const SizedBox(height: 10),
                  _buildSvgColorExamples(),
                ],
              ),

              const SizedBox(height: 20),

              // SVG 애니메이션
              _buildSection(
                title: '✨ SVG 애니메이션',
                children: [
                  _buildInfoCard('AnimatedBuilder 사용', '애니메이션 효과'),
                  const SizedBox(height: 10),
                  _buildSvgAnimationExample(),
                ],
              ),

              const SizedBox(height: 20),

              // SVG 에러 처리
              _buildSection(
                title: '⚠️ SVG 에러 처리',
                children: [
                  _buildInfoCard('errorBuilder 사용', '로딩 실패 시 대체 이미지'),
                  const SizedBox(height: 10),
                  _buildSvgErrorExample(),
                ],
              ),

              const SizedBox(height: 20),

              // SVG 로딩 상태
              _buildSection(
                title: '⏳ SVG 로딩 상태',
                children: [
                  _buildInfoCard('placeholderBuilder 사용', '로딩 중 표시'),
                  const SizedBox(height: 10),
                  _buildSvgLoadingExample(),
                ],
              ),

              const SizedBox(height: 20),

              // SVG 네트워크 로드
              _buildSection(
                title: '🌐 네트워크 SVG',
                children: [
                  _buildInfoCard('SvgPicture.network 사용', 'URL에서 SVG 로드'),
                  const SizedBox(height: 10),
                  _buildNetworkSvgExample(),
                ],
              ),

              const SizedBox(height: 20),

              // SVG 문자열 로드
              _buildSection(
                title: '📝 문자열 SVG',
                children: [
                  _buildInfoCard('SvgPicture.string 사용', '문자열로 SVG 로드'),
                  const SizedBox(height: 10),
                  _buildStringSvgExample(),
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

  // 기본 SVG 예제
  Widget _buildSvgExample() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              '기본 SVG 로드:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // 실제 SVG 파일이 없으므로 플레이스홀더 사용
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue),
              ),
              child: const Center(
                child: Text(
                  'SVG\n파일',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'SvgPicture.asset("assets/svg/example.svg")',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  // SVG 크기 예제
  Widget _buildSvgSizeExamples() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              '다양한 크기:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildSvgPlaceholder(50, 50, '50x50'),
                _buildSvgPlaceholder(80, 80, '80x80'),
                _buildSvgPlaceholder(120, 120, '120x120'),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              'width, height 속성으로 크기 조절 가능',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  // SVG 색상 예제
  Widget _buildSvgColorExamples() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              '다양한 색상:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildSvgPlaceholder(60, 60, '빨강', color: Colors.red),
                _buildSvgPlaceholder(60, 60, '초록', color: Colors.green),
                _buildSvgPlaceholder(60, 60, '파랑', color: Colors.blue),
                _buildSvgPlaceholder(60, 60, '보라', color: Colors.purple),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              'color 속성으로 색상 변경 가능',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  // SVG 애니메이션 예제
  Widget _buildSvgAnimationExample() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              '회전 애니메이션:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildAnimatedSvg(),
            const SizedBox(height: 10),
            const Text(
              'AnimatedBuilder로 애니메이션 효과',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  // SVG 에러 처리 예제
  Widget _buildSvgErrorExample() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text('에러 처리:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.red),
              ),
              child: const Center(
                child: Icon(Icons.error_outline, color: Colors.red, size: 40),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'errorBuilder로 로딩 실패 시 대체 이미지 표시',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  // SVG 로딩 상태 예제
  Widget _buildSvgLoadingExample() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text('로딩 상태:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.orange.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.orange),
              ),
              child: const Center(
                child: CircularProgressIndicator(color: Colors.orange),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'placeholderBuilder로 로딩 중 표시',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  // 네트워크 SVG 예제
  Widget _buildNetworkSvgExample() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              '네트워크 SVG:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.teal.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.teal),
              ),
              child: const Center(
                child: Icon(Icons.cloud_download, color: Colors.teal, size: 40),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'SvgPicture.network("https://example.com/icon.svg")',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  // 문자열 SVG 예제
  Widget _buildStringSvgExample() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              '문자열 SVG:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.indigo.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.indigo),
              ),
              child: const Center(
                child: Icon(Icons.code, color: Colors.indigo, size: 40),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'SvgPicture.string(svgString)',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  // SVG 플레이스홀더 위젯
  Widget _buildSvgPlaceholder(
    double width,
    double height,
    String label, {
    Color? color,
  }) {
    return Column(
      children: [
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: (color ?? Colors.blue).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: color ?? Colors.blue),
          ),
          child: Center(
            child: Icon(
              Icons.image,
              color: color ?? Colors.blue,
              size: width * 0.4,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(fontSize: 10, color: color ?? Colors.blue),
        ),
      ],
    );
  }

  // 애니메이션 SVG 위젯
  Widget _buildAnimatedSvg() {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(seconds: 2),
      builder: (context, value, child) {
        return Transform.rotate(
          angle: value * 2 * 3.14159,
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.purple.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.purple),
            ),
            child: const Center(
              child: Icon(Icons.rotate_right, color: Colors.purple, size: 30),
            ),
          ),
        );
      },
    );
  }
}
