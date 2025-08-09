# 🎨 Flutter SVG 사용 완전 가이드

## 📋 **목차**

1. [개요](#개요)
2. [설치 및 설정](#설치-및-설정)
3. [기본 사용법](#기본-사용법)
4. [고급 사용법](#고급-사용법)
5. [실제 예제](#실제-예제)
6. [모범 사례](#모범-사례)
7. [문제 해결](#문제-해결)

---

## 🎯 **개요**

Flutter에서 SVG(Scalable Vector Graphics)를 사용하면 **벡터 기반의 확장 가능한 이미지**를 앱에 포함할 수 있습니다.

### **🎯 SVG의 장점**

- **확장성**: 어떤 크기로도 확대/축소 가능
- **파일 크기**: 일반적으로 작은 파일 크기
- **품질**: 어떤 해상도에서도 선명함
- **편집 가능**: 색상, 크기 등 동적 변경 가능

### **📱 사용 사례**

- 앱 아이콘
- 로고
- 아이콘 세트
- 애니메이션
- 일러스트레이션

---

## 📦 **설치 및 설정**

### **1. 패키지 설치**

```yaml
# pubspec.yaml
dependencies:
  flutter_svg: ^2.0.9
```

### **2. 패키지 설치 명령어**

```bash
flutter pub get
```

### **3. assets 폴더 생성**

```bash
mkdir -p assets/svg
```

### **4. pubspec.yaml에 assets 추가**

```yaml
# pubspec.yaml
flutter:
  assets:
    - assets/svg/
```

---

## 🔧 **기본 사용법**

### **1. 로컬 SVG 파일 로드**

```dart
import 'package:flutter_svg/flutter_svg.dart';

// 기본 사용법
SvgPicture.asset('assets/svg/icon.svg')

// 크기 지정
SvgPicture.asset(
  'assets/svg/icon.svg',
  width: 100,
  height: 100,
)

// 색상 변경
SvgPicture.asset(
  'assets/svg/icon.svg',
  color: Colors.blue,
)
```

### **2. 네트워크 SVG 로드**

```dart
// URL에서 SVG 로드
SvgPicture.network('https://example.com/icon.svg')

// 크기와 색상 지정
SvgPicture.network(
  'https://example.com/icon.svg',
  width: 50,
  height: 50,
  color: Colors.red,
)
```

### **3. SVG 문자열 로드**

```dart
// SVG 문자열 직접 사용
const String svgString = '''
<svg width="100" height="100" xmlns="http://www.w3.org/2000/svg">
  <circle cx="50" cy="50" r="40" stroke="black" stroke-width="3" fill="red"/>
</svg>
''';

SvgPicture.string(svgString)
```

---

## 🚀 **고급 사용법**

### **1. 에러 처리**

```dart
SvgPicture.asset(
  'assets/svg/icon.svg',
  errorBuilder: (context, error, stackTrace) {
    return Container(
      width: 100,
      height: 100,
      color: Colors.grey[300],
      child: const Icon(Icons.error),
    );
  },
)
```

### **2. 로딩 상태 처리**

```dart
SvgPicture.asset(
  'assets/svg/icon.svg',
  placeholderBuilder: (context) {
    return Container(
      width: 100,
      height: 100,
      child: const CircularProgressIndicator(),
    );
  },
)
```

### **3. 애니메이션 SVG**

```dart
class AnimatedSvgWidget extends StatefulWidget {
  @override
  _AnimatedSvgWidgetState createState() => _AnimatedSvgWidgetState();
}

class _AnimatedSvgWidgetState extends State<AnimatedSvgWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.rotate(
          angle: _animation.value * 2 * 3.14159,
          child: SvgPicture.asset('assets/svg/icon.svg'),
        );
      },
    );
  }
}
```

### **4. 조건부 색상 변경**

```dart
class ConditionalSvgWidget extends StatelessWidget {
  final bool isActive;

  const ConditionalSvgWidget({required this.isActive});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/svg/icon.svg',
      color: isActive ? Colors.green : Colors.grey,
    );
  }
}
```

---

## 🎮 **실제 예제**

### **1. 기본 SVG 위젯**

```dart
class SvgIconWidget extends StatelessWidget {
  final String assetPath;
  final double? width;
  final double? height;
  final Color? color;

  const SvgIconWidget({
    required this.assetPath,
    this.width,
    this.height,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetPath,
      width: width,
      height: height,
      color: color,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: width ?? 24,
          height: height ?? 24,
          color: Colors.grey[300],
          child: const Icon(Icons.error, size: 16),
        );
      },
    );
  }
}

// 사용 예시
SvgIconWidget(
  assetPath: 'assets/svg/home.svg',
  width: 24,
  height: 24,
  color: Colors.blue,
)
```

### **2. 네트워크 SVG 위젯**

```dart
class NetworkSvgWidget extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;
  final Color? color;

  const NetworkSvgWidget({
    required this.url,
    this.width,
    this.height,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.network(
      url,
      width: width,
      height: height,
      color: color,
      placeholderBuilder: (context) {
        return Container(
          width: width ?? 24,
          height: height ?? 24,
          child: const CircularProgressIndicator(strokeWidth: 2),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: width ?? 24,
          height: height ?? 24,
          color: Colors.grey[300],
          child: const Icon(Icons.error, size: 16),
        );
      },
    );
  }
}

// 사용 예시
NetworkSvgWidget(
  url: 'https://example.com/icon.svg',
  width: 50,
  height: 50,
  color: Colors.red,
)
```

### **3. 애니메이션 SVG 위젯**

```dart
class AnimatedSvgIcon extends StatefulWidget {
  final String assetPath;
  final double? width;
  final double? height;
  final Color? color;
  final bool isAnimating;

  const AnimatedSvgIcon({
    required this.assetPath,
    this.width,
    this.height,
    this.color,
    this.isAnimating = false,
  });

  @override
  _AnimatedSvgIconState createState() => _AnimatedSvgIconState();
}

class _AnimatedSvgIconState extends State<AnimatedSvgIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void didUpdateWidget(AnimatedSvgIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isAnimating && !oldWidget.isAnimating) {
      _controller.repeat();
    } else if (!widget.isAnimating && oldWidget.isAnimating) {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.rotate(
          angle: _animation.value * 2 * 3.14159,
          child: SvgPicture.asset(
            widget.assetPath,
            width: widget.width,
            height: widget.height,
            color: widget.color,
          ),
        );
      },
    );
  }
}

// 사용 예시
AnimatedSvgIcon(
  assetPath: 'assets/svg/loading.svg',
  width: 24,
  height: 24,
  color: Colors.blue,
  isAnimating: isLoading,
)
```

### **4. 반응형 SVG 위젯**

```dart
class ResponsiveSvgWidget extends StatelessWidget {
  final String assetPath;
  final Color? color;
  final double maxWidth;
  final double maxHeight;

  const ResponsiveSvgWidget({
    required this.assetPath,
    this.color,
    this.maxWidth = 100,
    this.maxHeight = 100,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth;
        final availableHeight = constraints.maxHeight;

        final width = availableWidth < maxWidth ? availableWidth : maxWidth;
        final height = availableHeight < maxHeight ? availableHeight : maxHeight;

        return SvgPicture.asset(
          assetPath,
          width: width,
          height: height,
          color: color,
        );
      },
    );
  }
}

// 사용 예시
Container(
  width: 200,
  height: 150,
  child: ResponsiveSvgWidget(
    assetPath: 'assets/svg/logo.svg',
    color: Colors.blue,
    maxWidth: 100,
    maxHeight: 100,
  ),
)
```

---

## 📋 **모범 사례**

### **1. 파일 구조**

```
assets/
  svg/
    icons/
      home.svg
      profile.svg
      settings.svg
    logos/
      app_logo.svg
      company_logo.svg
    illustrations/
      empty_state.svg
      error_state.svg
```

### **2. 네이밍 컨벤션**

```dart
// 파일명: snake_case 사용
'assets/svg/icons/home_icon.svg'
'assets/svg/logos/app_logo.svg'

// 변수명: camelCase 사용
final String homeIconPath = 'assets/svg/icons/home_icon.svg';
final String appLogoPath = 'assets/svg/logos/app_logo.svg';
```

### **3. 성능 최적화**

```dart
// 캐시된 SVG 사용
class CachedSvgWidget extends StatelessWidget {
  final String assetPath;
  final double? width;
  final double? height;
  final Color? color;

  const CachedSvgWidget({
    required this.assetPath,
    this.width,
    this.height,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetPath,
      width: width,
      height: height,
      color: color,
      // 캐시 사용
      cacheColorFilter: true,
    );
  }
}
```

### **4. 에러 처리**

```dart
class SafeSvgWidget extends StatelessWidget {
  final String assetPath;
  final double? width;
  final double? height;
  final Color? color;
  final Widget? fallback;

  const SafeSvgWidget({
    required this.assetPath,
    this.width,
    this.height,
    this.color,
    this.fallback,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetPath,
      width: width,
      height: height,
      color: color,
      errorBuilder: (context, error, stackTrace) {
        return fallback ?? Container(
          width: width ?? 24,
          height: height ?? 24,
          color: Colors.grey[300],
          child: const Icon(Icons.error, size: 16),
        );
      },
    );
  }
}
```

---

## 🔧 **문제 해결**

### **1. SVG가 표시되지 않는 문제**

#### **해결 방법**

```dart
// 1. pubspec.yaml 확인
flutter:
  assets:
    - assets/svg/

// 2. 파일 경로 확인
SvgPicture.asset('assets/svg/icon.svg')

// 3. 에러 처리 추가
SvgPicture.asset(
  'assets/svg/icon.svg',
  errorBuilder: (context, error, stackTrace) {
    print('SVG 로드 오류: $error');
    return Container(
      width: 100,
      height: 100,
      color: Colors.grey[300],
      child: const Icon(Icons.error),
    );
  },
)
```

### **2. 색상이 변경되지 않는 문제**

#### **해결 방법**

```dart
// SVG 파일에서 fill 속성 확인
// <path fill="currentColor" ... /> 형태여야 함

// 또는 colorBlendMode 사용
SvgPicture.asset(
  'assets/svg/icon.svg',
  color: Colors.blue,
  colorBlendMode: BlendMode.srcIn,
)
```

### **3. 크기가 적용되지 않는 문제**

#### **해결 방법**

```dart
// SVG 파일의 viewBox 확인
// <svg viewBox="0 0 100 100" ...>

// 또는 fit 속성 사용
SvgPicture.asset(
  'assets/svg/icon.svg',
  width: 100,
  height: 100,
  fit: BoxFit.contain,
)
```

### **4. 네트워크 SVG 로딩 실패**

#### **해결 방법**

```dart
SvgPicture.network(
  'https://example.com/icon.svg',
  placeholderBuilder: (context) {
    return const CircularProgressIndicator();
  },
  errorBuilder: (context, error, stackTrace) {
    return const Icon(Icons.error);
  },
)
```

---

## 🎯 **결론**

Flutter에서 SVG를 사용하면:

1. **확장성**: 어떤 크기로도 확대/축소 가능
2. **성능**: 작은 파일 크기로 빠른 로딩
3. **유연성**: 색상, 크기 등 동적 변경 가능
4. **품질**: 어떤 해상도에서도 선명함

### **✅ 학습 완료 체크리스트**

- [ ] 패키지 설치 및 설정
- [ ] 기본 SVG 로드 방법
- [ ] 네트워크 SVG 로드 방법
- [ ] SVG 문자열 로드 방법
- [ ] 크기 및 색상 변경
- [ ] 에러 처리 구현
- [ ] 애니메이션 SVG 구현
- [ ] 모범 사례 적용

### **🚀 다음 단계**

1. **실제 SVG 파일 추가**: 앱에 맞는 SVG 아이콘 추가
2. **성능 최적화**: 캐시 및 메모리 관리
3. **애니메이션 고도화**: 복잡한 SVG 애니메이션 구현
4. **테마 적용**: 다크/라이트 모드에 따른 색상 변경

이제 Flutter 앱에서 SVG를 효과적으로 활용할 수 있습니다! 🎉
