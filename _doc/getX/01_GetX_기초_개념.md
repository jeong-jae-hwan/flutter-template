# GetX 기초 개념

## GetX란?

GetX는 Flutter의 상태관리, 라우팅, 의존성 주입을 한번에 해결하는 강력한 라이브러리입니다.

### GetX의 3가지 주요 기능

#### 1. 상태관리 (State Management)

- **Reactive Programming**: `Obx()`와 `GetBuilder()`를 사용한 반응형 UI
- **간단한 문법**: `setState()` 없이도 UI 업데이트 가능
- **메모리 효율성**: 자동으로 메모리 관리

#### 2. 라우팅 (Navigation)

- **간단한 네비게이션**: `Get.to()`, `Get.off()`, `Get.offAll()`
- **명명된 라우트**: `/home`, `/profile` 같은 URL 스타일 라우팅
- **중간 페이지 제거**: `Get.off()`로 이전 페이지 삭제

#### 3. 의존성 주입 (Dependency Injection)

- **컨트롤러 관리**: `Get.put()`, `Get.find()`로 객체 관리
- **자동 메모리 관리**: 사용하지 않는 컨트롤러 자동 삭제
- **싱글톤 패턴**: 하나의 인스턴스로 전체 앱에서 사용

## GetX vs 다른 상태관리 라이브러리

| 기능           | GetX | Provider | Bloc | Riverpod |
| -------------- | ---- | -------- | ---- | -------- |
| 학습 곡선      | 낮음 | 중간     | 높음 | 높음     |
| 보일러플레이트 | 적음 | 중간     | 많음 | 중간     |
| 성능           | 빠름 | 빠름     | 빠름 | 빠름     |
| 메모리 관리    | 자동 | 수동     | 수동 | 자동     |

## GetX의 장점

1. **간단한 문법**: 복잡한 설정 없이 바로 사용 가능
2. **높은 성능**: 최적화된 상태관리로 빠른 UI 업데이트
3. **적은 코드**: 보일러플레이트 코드 최소화
4. **자동 메모리 관리**: 메모리 누수 걱정 없음
5. **풍부한 유틸리티**: `Get.snackbar()`, `Get.dialog()` 등

## GetX 설치 및 기본 설정

```yaml
# pubspec.yaml
dependencies:
  get: ^4.6.6
```

```dart
// main.dart
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(  // MaterialApp 대신 GetMaterialApp 사용
      title: 'GetX Tutorial',
      home: HomePage(),
    );
  }
}
```

## 다음 단계

- [02*상태관리*기초.md](02_상태관리_기초.md) - GetX 상태관리 학습
- [03*라우팅*기초.md](03_라우팅_기초.md) - GetX 라우팅 학습
- [04*API_CRUD*기초.md](04_API_CRUD_기초.md) - API 연동 학습
