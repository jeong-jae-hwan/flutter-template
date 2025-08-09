# GetX 비동기 처리 완전 가이드

## 개요

GetX만으로 HTTP 요청과 비동기 처리를 완전히 구현하는 방법을 설명합니다. 추가 패키지 없이 GetX의 내장 기능만으로 강력한 비동기 앱을 만들어봅니다.

## GetX 비동기 처리 핵심 개념

| 기능          | GetX 방식       | 설명                      |
| ------------- | --------------- | ------------------------- |
| **HTTP 요청** | `GetConnect`    | GetX 내장 HTTP 클라이언트 |
| **상태 관리** | `.obs` 변수     | 반응형 상태 관리          |
| **로딩 상태** | `isLoading.obs` | 간단한 로딩 상태          |
| **에러 처리** | `error.obs`     | 에러 상태 관리            |
| **캐싱**      | 수동 구현       | 간단한 메모리 캐싱        |

## 1. GetX 내장 HTTP 클라이언트

```dart
// lib/services/api_service.dart
import 'package:get/get.dart';

class ApiService extends GetConnect {
  @override
  void onInit() {
    // 기본 설정
    httpClient.baseUrl = 'https://jsonplaceholder.typicode.com';
    httpClient.timeout = Duration(seconds: 10);

    // 요청 인터셉터
    httpClient.addRequestModifier<dynamic>((request) {
      print('🌐 요청: ${request.method} ${request.url}');
      return request;
    });

    // 응답 인터셉터
    httpClient.addResponseModifier((request, response) {
      print('✅ 응답: ${response.statusCode}');
      return response;
    });
  }

  // GET 요청
  Future<List<dynamic>> getPosts() async {
    final response = await get('/posts');

    if (response.status.hasError) {
      throw Exception('요청 실패: ${response.statusText}');
    } else {
      return response.body;
    }
  }

  // POST 요청
  Future<Map<String, dynamic>> createPost(Map<String, dynamic> data) async {
    final response = await post('/posts', data);

    if (response.status.hasError) {
      throw Exception('생성 실패: ${response.statusText}');
    } else {
      return response.body;
    }
  }

  // PUT 요청
  Future<Map<String, dynamic>> updatePost(int id, Map<String, dynamic> data) async {
    final response = await put('/posts/$id', data);

    if (response.status.hasError) {
      throw Exception('수정 실패: ${response.statusText}');
    } else {
      return response.body;
    }
  }

  // DELETE 요청
  Future<bool> deletePost(int id) async {
    final response = await delete('/posts/$id');

    if (response.status.hasError) {
      throw Exception('삭제 실패: ${response.statusText}');
    } else {
      return true;
    }
  }
}
```

## 2. 간단한 데이터 모델

```dart
// lib/models/post.dart
class Post {
  final int? id;
  final String title;
  final String body;
  final int userId;

  Post({
    this.id,
    required this.title,
    required this.body,
    required this.userId,
  });

  // JSON 변환
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'userId': userId,
    };
  }
}
```

## 3. GetX 컨트롤러 (비동기 처리)

```dart
// lib/controllers/post_controller.dart
import 'package:get/get.dart';
import '../models/post.dart';
import '../services/api_service.dart';

class PostController extends GetxController {
  // 상태 변수들
  final posts = <Post>[].obs;
  final isLoading = false.obs;
  final error = ''.obs;
  final selectedPost = Rxn<Post>();

  // API 서비스
  final ApiService _apiService = Get.put(ApiService());

  @override
  void onInit() {
    super.onInit();
    fetchPosts(); // 자동으로 데이터 로드
  }

  // 게시물 목록 가져오기
  Future<void> fetchPosts() async {
    isLoading.value = true;
    error.value = '';

    try {
      final data = await _apiService.getPosts();
      posts.value = data.map((json) => Post.fromJson(json)).toList();
    } catch (e) {
      error.value = e.toString();
      Get.snackbar('오류', '게시물을 가져오는데 실패했습니다.');
    } finally {
      isLoading.value = false;
    }
  }

  // 게시물 생성
  Future<void> createPost(Post post) async {
    isLoading.value = true;
    error.value = '';

    try {
      final data = await _apiService.createPost(post.toJson());
      final newPost = Post.fromJson(data);
      posts.add(newPost);

      Get.back(); // 이전 페이지로 돌아가기
      Get.snackbar('성공', '게시물이 생성되었습니다.');
    } catch (e) {
      error.value = e.toString();
      Get.snackbar('오류', '게시물 생성에 실패했습니다.');
    } finally {
      isLoading.value = false;
    }
  }

  // 게시물 수정
  Future<void> updatePost(Post post) async {
    isLoading.value = true;
    error.value = '';

    try {
      final data = await _apiService.updatePost(post.id!, post.toJson());
      final updatedPost = Post.fromJson(data);

      // 리스트에서 해당 게시물 업데이트
      final index = posts.indexWhere((p) => p.id == post.id);
      if (index != -1) {
        posts[index] = updatedPost;
      }

      Get.back();
      Get.snackbar('성공', '게시물이 수정되었습니다.');
    } catch (e) {
      error.value = e.toString();
      Get.snackbar('오류', '게시물 수정에 실패했습니다.');
    } finally {
      isLoading.value = false;
    }
  }

  // 게시물 삭제
  Future<void> deletePost(int id) async {
    isLoading.value = true;
    error.value = '';

    try {
      await _apiService.deletePost(id);
      posts.removeWhere((post) => post.id == id);
      Get.snackbar('성공', '게시물이 삭제되었습니다.');
    } catch (e) {
      error.value = e.toString();
      Get.snackbar('오류', '게시물 삭제에 실패했습니다.');
    } finally {
      isLoading.value = false;
    }
  }

  // 게시물 선택
  void selectPost(Post post) {
    selectedPost.value = post;
  }

  // 선택 해제
  void clearSelection() {
    selectedPost.value = null;
  }
}
```

## 4. UI 컴포넌트

### 게시물 목록 페이지

```dart
// lib/pages/post_list_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/post_controller.dart';
import '../models/post.dart';

class PostListPage extends StatelessWidget {
  final PostController controller = Get.put(PostController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('게시물 목록'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: controller.fetchPosts,
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (controller.error.value.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('오류: ${controller.error.value}'),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: controller.fetchPosts,
                  child: Text('다시 시도'),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          itemCount: controller.posts.length,
          itemBuilder: (context, index) {
            final post = controller.posts[index];
            return PostTile(post: post);
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed('/posts/create'),
        child: Icon(Icons.add),
      ),
    );
  }
}

class PostTile extends StatelessWidget {
  final Post post;

  const PostTile({required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(post.title),
        subtitle: Text(post.body),
        trailing: PopupMenuButton(
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 'edit',
              child: Text('수정'),
            ),
            PopupMenuItem(
              value: 'delete',
              child: Text('삭제'),
            ),
          ],
          onSelected: (value) {
            if (value == 'edit') {
              Get.find<PostController>().selectPost(post);
              Get.toNamed('/posts/edit');
            } else if (value == 'delete') {
              _showDeleteDialog();
            }
          },
        ),
        onTap: () {
          Get.find<PostController>().selectPost(post);
          Get.toNamed('/posts/detail');
        },
      ),
    );
  }

  void _showDeleteDialog() {
    Get.dialog(
      AlertDialog(
        title: Text('삭제 확인'),
        content: Text('이 게시물을 삭제하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('취소'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              Get.find<PostController>().deletePost(post.id!);
            },
            child: Text('삭제'),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
          ),
        ],
      ),
    );
  }
}
```

### 게시물 생성/수정 페이지

```dart
// lib/pages/post_form_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/post_controller.dart';
import '../models/post.dart';

class PostFormPage extends StatelessWidget {
  final PostController controller = Get.find<PostController>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // 수정 모드인 경우 기존 데이터 설정
    final selectedPost = controller.selectedPost.value;
    if (selectedPost != null) {
      titleController.text = selectedPost.title;
      bodyController.text = selectedPost.body;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPost == null ? '새 게시물' : '게시물 수정'),
        actions: [
          Obx(() => controller.isLoading.value
            ? Padding(
                padding: EdgeInsets.all(16),
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              )
            : TextButton(
                onPressed: _savePost,
                child: Text(
                  '저장',
                  style: TextStyle(color: Colors.white),
                ),
              ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: '제목',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: TextField(
                controller: bodyController,
                decoration: InputDecoration(
                  labelText: '내용',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                maxLines: null,
                expands: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _savePost() {
    if (titleController.text.trim().isEmpty) {
      Get.snackbar('오류', '제목을 입력해주세요.');
      return;
    }

    if (bodyController.text.trim().isEmpty) {
      Get.snackbar('오류', '내용을 입력해주세요.');
      return;
    }

    final selectedPost = controller.selectedPost.value;
    final newPost = Post(
      id: selectedPost?.id,
      title: titleController.text.trim(),
      body: bodyController.text.trim(),
      userId: 1,
    );

    if (selectedPost == null) {
      controller.createPost(newPost);
    } else {
      controller.updatePost(newPost);
    }
  }
}
```

## 5. 고급 GetX 비동기 기능

### 검색 기능

```dart
// lib/controllers/post_controller.dart
class PostController extends GetxController {
  // ... 기존 코드 ...

  final searchQuery = ''.obs;
  final filteredPosts = <Post>[].obs;

  void searchPosts(String query) {
    searchQuery.value = query;

    if (query.isEmpty) {
      filteredPosts.value = posts;
    } else {
      filteredPosts.value = posts.where((post) =>
        post.title.toLowerCase().contains(query.toLowerCase()) ||
        post.body.toLowerCase().contains(query.toLowerCase())
      ).toList();
    }
  }
}
```

### 페이지네이션

```dart
// lib/controllers/post_controller.dart
class PostController extends GetxController {
  // ... 기존 코드 ...

  final currentPage = 1.obs;
  final hasMore = true.obs;

  Future<void> loadMorePosts() async {
    if (!hasMore.value || isLoading.value) return;

    try {
      final data = await _apiService.getPosts();
      final newPosts = data.map((json) => Post.fromJson(json)).toList();

      if (newPosts.isEmpty) {
        hasMore.value = false;
      } else {
        posts.addAll(newPosts);
        currentPage.value++;
      }
    } catch (e) {
      error.value = e.toString();
    }
  }
}
```

### 디바운싱 검색

```dart
// lib/controllers/search_controller.dart
import 'dart:async';
import 'package:get/get.dart';

class SearchController extends GetxController {
  final searchQuery = ''.obs;
  final searchResults = <Post>[].obs;
  Timer? _debounceTimer;

  void onSearchChanged(String query) {
    searchQuery.value = query;

    // 이전 타이머 취소
    _debounceTimer?.cancel();

    // 새로운 타이머 시작 (500ms 디바운스)
    _debounceTimer = Timer(Duration(milliseconds: 500), () {
      performSearch(query);
    });
  }

  Future<void> performSearch(String query) async {
    if (query.isEmpty) {
      searchResults.clear();
      return;
    }

    // 검색 로직 구현
    final results = await Get.find<PostController>().searchPosts(query);
    searchResults.value = results;
  }

  @override
  void onClose() {
    _debounceTimer?.cancel();
    super.onClose();
  }
}
```

## 6. 에러 처리 및 재시도

```dart
// lib/utils/error_handler.dart
import 'package:get/get.dart';

class ErrorHandler {
  static String getErrorMessage(dynamic error) {
    if (error.toString().contains('SocketException')) {
      return '네트워크 연결을 확인해주세요.';
    } else if (error.toString().contains('TimeoutException')) {
      return '요청 시간이 초과되었습니다.';
    } else if (error.toString().contains('404')) {
      return '요청한 데이터를 찾을 수 없습니다.';
    } else {
      return '알 수 없는 오류가 발생했습니다.';
    }
  }

  static void showError(String message) {
    Get.snackbar(
      '오류',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }

  static void showSuccess(String message) {
    Get.snackbar(
      '성공',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }
}
```

## 7. 라우팅 설정

```dart
// lib/routes/app_routes.dart
import 'package:get/get.dart';
import '../pages/post_list_page.dart';
import '../pages/post_form_page.dart';

class AppRoutes {
  static final routes = [
    GetPage(
      name: '/',
      page: () => PostListPage(),
    ),
    GetPage(
      name: '/posts/create',
      page: () => PostFormPage(),
    ),
    GetPage(
      name: '/posts/edit',
      page: () => PostFormPage(),
    ),
  ];
}
```

## 8. 메인 앱 설정

```dart
// lib/main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'routes/app_routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'GetX 비동기 앱',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      initialRoute: '/',
      getPages: AppRoutes.routes,
    );
  }
}
```

## 핵심 장점

1. **순수 GetX**: 추가 패키지 없이 GetX만으로 모든 기능 구현
2. **간결함**: 최소한의 코드로 최대 효과
3. **성능**: GetX의 최적화된 상태 관리
4. **유지보수**: 단순한 구조로 쉬운 유지보수
5. **확장성**: 필요에 따라 기능 추가 가능

## 다음 단계

- [05*실전*프로젝트.md](05_실전_프로젝트.md) - 완전한 앱 만들기
- [06*컨트롤러*스코프\_관리.md](06_컨트롤러_스코프_관리.md) - GetX 고급 기능들
- [07*고급*컨트롤러\_관리.md](07_고급_컨트롤러_관리.md) - 성능 최적화 가이드
