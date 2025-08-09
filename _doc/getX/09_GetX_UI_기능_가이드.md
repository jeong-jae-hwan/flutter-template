# GetX UI 기능 완전 가이드

## 개요

GetX는 상태관리와 라우팅뿐만 아니라 다양한 UI 기능들도 제공합니다. 이 가이드에서는 GetX의 UI 기능들을 자세히 살펴보겠습니다.

## GetX UI 기능 목록

| 기능                | 메서드                | 설명                        |
| ------------------- | --------------------- | --------------------------- |
| **스낵바**          | `Get.snackbar()`      | 하단 알림 표시              |
| **다이얼로그**      | `Get.dialog()`        | 커스텀 다이얼로그           |
| **기본 다이얼로그** | `Get.defaultDialog()` | 간단한 확인/취소 다이얼로그 |
| **바텀시트**        | `Get.bottomSheet()`   | 하단에서 올라오는 시트      |
| **로딩**            | `Get.loading()`       | 로딩 인디케이터             |
| **토스트**          | `Get.toast()`         | 간단한 토스트 메시지        |
| **스낵바**          | `Get.snackbar()`      | 상세한 알림                 |

## 1. Get.snackbar() - 스낵바 알림

### 기본 사용법

```dart
// 기본 스낵바
Get.snackbar(
  '제목',
  '메시지 내용',
);

// 성공 스낵바
Get.snackbar(
  '성공',
  '데이터가 저장되었습니다.',
  backgroundColor: Colors.green,
  colorText: Colors.white,
  snackPosition: SnackPosition.BOTTOM,
  duration: Duration(seconds: 3),
);

// 에러 스낵바
Get.snackbar(
  '오류',
  '네트워크 연결을 확인해주세요.',
  backgroundColor: Colors.red,
  colorText: Colors.white,
  snackPosition: SnackPosition.TOP,
  duration: Duration(seconds: 5),
);
```

### 고급 스낵바 옵션

```dart
Get.snackbar(
  '알림',
  '새로운 메시지가 도착했습니다.',

  // 스타일링
  backgroundColor: Colors.blue,
  colorText: Colors.white,
  borderColor: Colors.white,
  borderWidth: 2,

  // 위치 및 애니메이션
  snackPosition: SnackPosition.BOTTOM,
  margin: EdgeInsets.all(16),
  borderRadius: 8,

  // 지속 시간
  duration: Duration(seconds: 4),

  // 아이콘
  icon: Icon(Icons.info, color: Colors.white),

  // 액션 버튼
  mainButton: TextButton(
    onPressed: () {
      // 액션 처리
    },
    child: Text('확인', style: TextStyle(color: Colors.white)),
  ),

  // 프로그레스 바
  progressBarBackgroundColor: Colors.grey,
  progressBarValue: 0.5,

  // 애니메이션
  animationDuration: Duration(milliseconds: 500),

  // 사용자 정의 위젯
  userInputForm: Form(
    child: Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: '댓글을 입력하세요',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.send),
          onPressed: () {
            // 전송 처리
          },
        ),
      ],
    ),
  ),
);
```

### 스낵바 위치 옵션

```dart
// 다양한 위치 옵션
Get.snackbar(
  '제목',
  '메시지',
  snackPosition: SnackPosition.TOP,        // 상단
  // snackPosition: SnackPosition.BOTTOM,  // 하단
  // snackPosition: SnackPosition.LEFT,    // 왼쪽
  // snackPosition: SnackPosition.RIGHT,   // 오른쪽
);
```

### 스낵바 유틸리티 함수

```dart
class SnackbarUtils {
  // 성공 메시지
  static void showSuccess(String message) {
    Get.snackbar(
      '성공',
      message,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 3),
    );
  }

  // 에러 메시지
  static void showError(String message) {
    Get.snackbar(
      '오류',
      message,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 5),
    );
  }

  // 경고 메시지
  static void showWarning(String message) {
    Get.snackbar(
      '경고',
      message,
      backgroundColor: Colors.orange,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 4),
    );
  }

  // 정보 메시지
  static void showInfo(String message) {
    Get.snackbar(
      '알림',
      message,
      backgroundColor: Colors.blue,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 3),
    );
  }
}

// 사용 예시
SnackbarUtils.showSuccess('데이터가 저장되었습니다.');
SnackbarUtils.showError('네트워크 연결을 확인해주세요.');
SnackbarUtils.showWarning('저장되지 않은 변경사항이 있습니다.');
SnackbarUtils.showInfo('새로운 업데이트가 있습니다.');
```

## 2. Get.dialog() - 커스텀 다이얼로그

### 기본 다이얼로그

```dart
// 기본 다이얼로그
Get.dialog(
  AlertDialog(
    title: Text('확인'),
    content: Text('정말 삭제하시겠습니까?'),
    actions: [
      TextButton(
        onPressed: () => Get.back(),
        child: Text('취소'),
      ),
      TextButton(
        onPressed: () {
          // 삭제 로직
          Get.back();
        },
        child: Text('삭제'),
        style: TextButton.styleFrom(foregroundColor: Colors.red),
      ),
    ],
  ),
);
```

### 고급 다이얼로그

```dart
Get.dialog(
  Dialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    child: Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.warning,
            color: Colors.orange,
            size: 48,
          ),
          SizedBox(height: 16),
          Text(
            '주의',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            '이 작업은 되돌릴 수 없습니다.',
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () => Get.back(),
                child: Text('취소'),
              ),
              ElevatedButton(
                onPressed: () {
                  // 확인 로직
                  Get.back();
                },
                child: Text('확인'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  ),
  barrierDismissible: false, // 배경 터치로 닫기 방지
);
```

### 입력 다이얼로그

```dart
void showInputDialog() {
  final textController = TextEditingController();

  Get.dialog(
    AlertDialog(
      title: Text('이름 입력'),
      content: TextField(
        controller: textController,
        decoration: InputDecoration(
          hintText: '이름을 입력하세요',
          border: OutlineInputBorder(),
        ),
        autofocus: true,
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: Text('취소'),
        ),
        ElevatedButton(
          onPressed: () {
            final name = textController.text.trim();
            if (name.isNotEmpty) {
              // 이름 처리 로직
              print('입력된 이름: $name');
            }
            Get.back();
          },
          child: Text('확인'),
        ),
      ],
    ),
  );
}
```

## 3. Get.defaultDialog() - 기본 다이얼로그

### 확인/취소 다이얼로그

```dart
// 기본 확인 다이얼로그
Get.defaultDialog(
  title: '확인',
  content: Text('정말 삭제하시겠습니까?'),
  onConfirm: () {
    // 확인 로직
    Get.back();
  },
  onCancel: () {
    Get.back();
  },
);

// 커스텀 버튼 텍스트
Get.defaultDialog(
  title: '로그아웃',
  content: Text('로그아웃하시겠습니까?'),
  textConfirm: '로그아웃',
  textCancel: '취소',
  confirmTextColor: Colors.white,
  cancelTextColor: Colors.grey,
  onConfirm: () {
    // 로그아웃 로직
    Get.back();
  },
);
```

### 고급 기본 다이얼로그

```dart
Get.defaultDialog(
  title: '업데이트',
  titleStyle: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.blue,
  ),
  content: Column(
    children: [
      Icon(Icons.system_update, size: 48, color: Colors.blue),
      SizedBox(height: 16),
      Text('새로운 버전이 있습니다.'),
      Text('지금 업데이트하시겠습니까?'),
    ],
  ),
  textConfirm: '업데이트',
  textCancel: '나중에',
  confirmTextColor: Colors.white,
  cancelTextColor: Colors.grey,
  backgroundColor: Colors.white,
  radius: 16,
  onConfirm: () {
    // 업데이트 로직
    Get.back();
  },
);
```

## 4. Get.bottomSheet() - 바텀시트

### 기본 바텀시트

```dart
// 기본 바텀시트
Get.bottomSheet(
  Container(
    padding: EdgeInsets.all(20),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '옵션 선택',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 20),
        ListTile(
          leading: Icon(Icons.edit),
          title: Text('수정'),
          onTap: () {
            // 수정 로직
            Get.back();
          },
        ),
        ListTile(
          leading: Icon(Icons.delete),
          title: Text('삭제'),
          onTap: () {
            // 삭제 로직
            Get.back();
          },
        ),
        ListTile(
          leading: Icon(Icons.share),
          title: Text('공유'),
          onTap: () {
            // 공유 로직
            Get.back();
          },
        ),
      ],
    ),
  ),
  backgroundColor: Colors.white,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
  ),
);
```

### 고급 바텀시트

```dart
Get.bottomSheet(
  Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 핸들 바
        Container(
          margin: EdgeInsets.only(top: 8),
          width: 40,
          height: 4,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(2),
          ),
        ),

        // 제목
        Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            '프로필 설정',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        // 옵션들
        ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.blue,
            child: Icon(Icons.person, color: Colors.white),
          ),
          title: Text('프로필 편집'),
          subtitle: Text('이름, 사진, 소개를 변경하세요'),
          onTap: () {
            Get.back();
            Get.toNamed('/profile/edit');
          },
        ),

        ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.green,
            child: Icon(Icons.notifications, color: Colors.white),
          ),
          title: Text('알림 설정'),
          subtitle: Text('푸시 알림을 관리하세요'),
          onTap: () {
            Get.back();
            Get.toNamed('/settings/notifications');
          },
        ),

        ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.orange,
            child: Icon(Icons.security, color: Colors.white),
          ),
          title: Text('보안 설정'),
          subtitle: Text('비밀번호, 2단계 인증을 설정하세요'),
          onTap: () {
            Get.back();
            Get.toNamed('/settings/security');
          },
        ),

        SizedBox(height: 20),
      ],
    ),
  ),
  isScrollControlled: true,
  enableDrag: true,
);
```

## 5. Get.loading() - 로딩 인디케이터

### 기본 로딩

```dart
// 로딩 표시
Get.loading();

// 로딩 숨기기
Get.back();

// 사용 예시
Future<void> loadData() async {
  Get.loading();

  try {
    await Future.delayed(Duration(seconds: 2)); // API 호출 시뮬레이션
    // 데이터 로딩 로직
  } finally {
    Get.back(); // 로딩 숨기기
  }
}
```

### 커스텀 로딩

```dart
// 커스텀 로딩 다이얼로그
Get.dialog(
  Center(
    child: Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
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
```

### 로딩 유틸리티

```dart
class LoadingUtils {
  static void show() {
    Get.dialog(
      Center(
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text(
                '로딩 중...',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  static void hide() {
    if (Get.isDialogOpen!) {
      Get.back();
    }
  }

  static Future<T> withLoading<T>(Future<T> Function() callback) async {
    show();
    try {
      final result = await callback();
      return result;
    } finally {
      hide();
    }
  }
}

// 사용 예시
await LoadingUtils.withLoading(() async {
  await Future.delayed(Duration(seconds: 2));
  return '완료';
});
```

## 6. Get.toast() - 토스트 메시지

### 기본 토스트

```dart
// 기본 토스트
Get.toast('메시지');

// 성공 토스트
Get.toast(
  '저장되었습니다.',
  backgroundColor: Colors.green,
  colorText: Colors.white,
  duration: Duration(seconds: 2),
);

// 에러 토스트
Get.toast(
  '오류가 발생했습니다.',
  backgroundColor: Colors.red,
  colorText: Colors.white,
  duration: Duration(seconds: 3),
);
```

### 고급 토스트

```dart
Get.toast(
  '새로운 메시지가 도착했습니다.',
  backgroundColor: Colors.blue,
  colorText: Colors.white,
  duration: Duration(seconds: 4),
  snackPosition: SnackPosition.TOP,
  borderRadius: 8,
  margin: EdgeInsets.all(16),
  icon: Icon(Icons.message, color: Colors.white),
);
```

## 7. 실전 사용 예시

### 컨트롤러에서 UI 기능 사용

```dart
class UserController extends GetxController {
  Future<void> saveUser(User user) async {
    try {
      // 로딩 표시
      Get.loading();

      // API 호출
      await apiService.saveUser(user);

      // 로딩 숨기기
      Get.back();

      // 성공 메시지
      Get.snackbar(
        '성공',
        '사용자 정보가 저장되었습니다.',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

    } catch (e) {
      // 로딩 숨기기
      Get.back();

      // 에러 메시지
      Get.snackbar(
        '오류',
        '저장에 실패했습니다: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> deleteUser(int id) async {
    // 확인 다이얼로그
    final result = await Get.dialog<bool>(
      AlertDialog(
        title: Text('삭제 확인'),
        content: Text('정말 삭제하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: Text('취소'),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: Text('삭제'),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
          ),
        ],
      ),
    );

    if (result == true) {
      try {
        await apiService.deleteUser(id);
        Get.snackbar('성공', '삭제되었습니다.');
      } catch (e) {
        Get.snackbar('오류', '삭제에 실패했습니다.');
      }
    }
  }

  void showUserOptions(User user) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.edit),
              title: Text('수정'),
              onTap: () {
                Get.back();
                Get.toNamed('/user/edit', arguments: user);
              },
            ),
            ListTile(
              leading: Icon(Icons.delete),
              title: Text('삭제'),
              onTap: () {
                Get.back();
                deleteUser(user.id);
              },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
```

## 8. UI 유틸리티 클래스

```dart
class UIUtils {
  // 성공 메시지
  static void showSuccess(String message) {
    Get.snackbar(
      '성공',
      message,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  // 에러 메시지
  static void showError(String message) {
    Get.snackbar(
      '오류',
      message,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  // 확인 다이얼로그
  static Future<bool> showConfirmDialog({
    required String title,
    required String message,
    String confirmText = '확인',
    String cancelText = '취소',
  }) async {
    final result = await Get.dialog<bool>(
      AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: Text(cancelText),
          ),
          ElevatedButton(
            onPressed: () => Get.back(result: true),
            child: Text(confirmText),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  // 로딩 표시
  static void showLoading() {
    Get.dialog(
      Center(
        child: CircularProgressIndicator(),
      ),
      barrierDismissible: false,
    );
  }

  // 로딩 숨기기
  static void hideLoading() {
    if (Get.isDialogOpen!) {
      Get.back();
    }
  }
}
```

## 다음 단계

- [12*고급*UI\*기능.md](12_고급_UI_기능.md) - 고급 UI 기능들
- [13*애니메이션*가이드.md](13_애니메이션_가이드.md) - GetX 애니메이션
- [14*테마*관리.md](14_테마_관리.md) - GetX 테마 관리
