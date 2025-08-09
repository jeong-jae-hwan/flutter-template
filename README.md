# GetX 튜토리얼 앱

Flutter GetX를 단계별로 학습할 수 있는 튜토리얼 앱입니다.

## 🚀 프로젝트 소개

이 앱은 Flutter 초보자도 쉽게 GetX를 배울 수 있도록 설계되었습니다. 단계별로 GetX의 핵심 기능을 실습해볼 수 있습니다.

## 📚 학습 단계

### 1단계: 기본 상태관리

- `.obs` 반응형 변수 사용법
- `Obx()` 위젯으로 UI 업데이트
- `Get.put()` 컨트롤러 등록
- `Get.snackbar()` 알림 표시

### 2단계: 할일 관리 앱 (예정)

- 리스트 데이터 관리
- CRUD 작업 (생성, 읽기, 수정, 삭제)
- 필터링 기능
- 로컬 상태 관리

### 3단계: 사용자 관리 (예정)

- 복잡한 데이터 구조
- 검색 및 필터링
- 정렬 기능
- 페이지네이션

### 4단계: API 연동 (예정)

- HTTP 요청 처리
- 로딩 상태 관리
- 에러 처리
- 데이터 캐싱

## 🛠️ 기술 스택

- **Flutter**: 3.8.1
- **GetX**: 4.6.6
- **Dart**: 3.8.1

## 📁 프로젝트 구조

```
lib/
├── main.dart                 # 앱 진입점
├── controllers/              # GetX 컨트롤러들
│   ├── navigation_controller.dart
│   ├── counter_controller.dart
│   ├── todo_controller.dart
│   ├── user_controller.dart
│   └── api_controller.dart
├── pages/                   # UI 페이지들
│   ├── home_page.dart
│   ├── counter_page.dart
│   ├── todo_page.dart
│   ├── user_page.dart
│   └── api_page.dart
├── models/                  # 데이터 모델
│   ├── todo.dart
│   └── user.dart
└── services/               # API 서비스
    └── api_service.dart

_doc/                       # 학습 자료
├── 01_GetX_기초_개념.md
├── 02_상태관리_기초.md
├── 03_라우팅_기초.md
├── 04_API_CRUD_기초.md
└── 05_실전_프로젝트.md
```

## 🚀 시작하기

### 1. 프로젝트 클론

```bash
git clone <repository-url>
cd flutter_template
```

### 2. 의존성 설치

```bash
flutter pub get
```

### 3. 앱 실행

```bash
flutter run
```

## 📖 학습 자료

`_doc/` 폴더에서 상세한 학습 자료를 확인할 수 있습니다:

- [GetX 기초 개념](_doc/01_GetX_기초_개념.md)
- [상태관리 기초](_doc/02_상태관리_기초.md)
- [라우팅 기초](_doc/03_라우팅_기초.md)
- [API CRUD 기초](_doc/04_API_CRUD_기초.md)
- [실전 프로젝트](_doc/05_실전_프로젝트.md)

## 🎯 GetX 핵심 기능

### 1. 반응형 프로그래밍

```dart
var count = 0.obs;
Obx(() => Text('${count.value}'));
```

### 2. 컨트롤러 관리

```dart
final controller = Get.put(CounterController());
```

### 3. 라우팅

```dart
Get.to(() => SecondPage());
Get.toNamed('/second');
```

### 4. 유틸리티

```dart
Get.snackbar('제목', '메시지');
Get.dialog(AlertDialog(...));
```

## 🤝 기여하기

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 라이선스

이 프로젝트는 MIT 라이선스 하에 배포됩니다. 자세한 내용은 `LICENSE` 파일을 참조하세요.

## 📞 문의

프로젝트에 대한 질문이나 제안사항이 있으시면 이슈를 생성해주세요.

---

**Happy Coding! 🎉**
