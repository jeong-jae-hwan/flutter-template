import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/storage_service.dart';

/// 앱스토리지 데모 컨트롤러
/// 실제 앱에서 앱스토리지를 어떻게 사용하는지 보여주는 예제
class StorageDemoController extends GetxController {
  // 반응형 변수들
  final RxString userName = ''.obs;
  final RxString userEmail = ''.obs;
  final RxInt userAge = 0.obs;
  final RxInt counter = 0.obs;
  final RxBool isDarkMode = false.obs;
  final RxString language = 'ko'.obs;
  final RxBool notificationsEnabled = true.obs;
  final RxList<String> searchHistory = <String>[].obs;
  final RxList<Map<String, dynamic>> todoList = <Map<String, dynamic>>[].obs;
  final RxInt appUsageCount = 0.obs;
  final RxString lastUsedDate = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _loadStoredData();
  }

  /// 저장된 데이터 로드
  Future<void> _loadStoredData() async {
    try {
      // 사용자 정보 로드
      final userInfo = await StorageService.getUserInfo();
      if (userInfo != null) {
        userName.value = userInfo['name'] ?? '';
        userEmail.value = userInfo['email'] ?? '';
        userAge.value = userInfo['age'] ?? 0;
      }

      // 카운터 로드
      counter.value = await StorageService.getCounter();

      // 앱 설정 로드
      final appSettings = await StorageService.getAppSettings();
      if (appSettings != null) {
        isDarkMode.value = appSettings['is_dark_mode'] ?? false;
        language.value = appSettings['language'] ?? 'ko';
        notificationsEnabled.value =
            appSettings['notifications_enabled'] ?? true;
      }

      // 검색 기록 로드
      final history = await StorageService.getSearchHistory();
      if (history != null) {
        searchHistory.value = history;
      }

      // 할일 목록 로드
      final todos = await StorageService.getTodoList();
      if (todos != null) {
        todoList.value = todos;
      }

      // 앱 사용 통계 로드
      appUsageCount.value = await StorageService.getAppUsageCount();
      lastUsedDate.value = await StorageService.getLastUsedDate() ?? '';
    } catch (e) {
      Get.log('저장된 데이터 로드 중 오류: $e', isError: true);
    }
  }

  /// 사용자 정보 저장
  Future<void> saveUserInfo({
    required String name,
    required String email,
    required int age,
  }) async {
    try {
      await StorageService.setUserInfo(name: name, email: email, age: age);

      // 반응형 변수 업데이트
      userName.value = name;
      userEmail.value = email;
      userAge.value = age;

      Get.snackbar(
        '성공',
        '사용자 정보가 저장되었습니다.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        '오류',
        '사용자 정보 저장에 실패했습니다.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  /// 카운터 증가 및 저장
  Future<void> incrementCounter() async {
    try {
      counter.value++;
      await StorageService.setCounter(counter.value);

      Get.snackbar(
        '카운터',
        '카운터가 증가했습니다: ${counter.value}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.blue,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        '오류',
        '카운터 저장에 실패했습니다.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  /// 카운터 초기화
  Future<void> resetCounter() async {
    try {
      counter.value = 0;
      await StorageService.setCounter(0);

      Get.snackbar(
        '초기화',
        '카운터가 초기화되었습니다.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        '오류',
        '카운터 초기화에 실패했습니다.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  /// 앱 설정 저장
  Future<void> saveAppSettings() async {
    try {
      await StorageService.setAppSettings(
        isDarkMode: isDarkMode.value,
        language: language.value,
        notificationsEnabled: notificationsEnabled.value,
      );

      Get.snackbar(
        '성공',
        '앱 설정이 저장되었습니다.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        '오류',
        '앱 설정 저장에 실패했습니다.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  /// 검색 기록 추가
  Future<void> addSearchTerm(String searchTerm) async {
    try {
      await StorageService.addSearchHistory(searchTerm);
      await _loadStoredData(); // 검색 기록 다시 로드

      Get.snackbar(
        '검색 기록',
        '검색어가 기록되었습니다: $searchTerm',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.purple,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        '오류',
        '검색 기록 저장에 실패했습니다.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  /// 검색 기록 삭제
  Future<void> clearSearchHistory() async {
    try {
      await StorageService.clearSearchHistory();
      searchHistory.clear();

      Get.snackbar(
        '삭제',
        '검색 기록이 삭제되었습니다.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        '오류',
        '검색 기록 삭제에 실패했습니다.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  /// 할일 추가
  Future<void> addTodo(String title, String description) async {
    try {
      final newTodo = {
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'title': title,
        'description': description,
        'completed': false,
        'created_at': DateTime.now().toIso8601String(),
      };

      todoList.add(newTodo);
      await StorageService.setTodoList(todoList.toList());

      Get.snackbar(
        '할일 추가',
        '할일이 추가되었습니다: $title',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        '오류',
        '할일 추가에 실패했습니다.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  /// 할일 완료/미완료 토글
  Future<void> toggleTodo(String todoId) async {
    try {
      final index = todoList.indexWhere((todo) => todo['id'] == todoId);
      if (index != -1) {
        todoList[index]['completed'] = !(todoList[index]['completed'] ?? false);
        await StorageService.setTodoList(todoList.toList());

        final status = todoList[index]['completed'] ? '완료' : '미완료';
        Get.snackbar(
          '할일 상태 변경',
          '할일이 $status로 변경되었습니다.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.blue,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        '오류',
        '할일 상태 변경에 실패했습니다.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  /// 할일 삭제
  Future<void> removeTodo(String todoId) async {
    try {
      todoList.removeWhere((todo) => todo['id'] == todoId);
      await StorageService.setTodoList(todoList.toList());

      Get.snackbar(
        '할일 삭제',
        '할일이 삭제되었습니다.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        '오류',
        '할일 삭제에 실패했습니다.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  /// 앱 사용 통계 업데이트
  Future<void> updateAppUsage() async {
    try {
      await StorageService.incrementAppUsage();
      await StorageService.setLastUsedDate();

      // 통계 다시 로드
      appUsageCount.value = await StorageService.getAppUsageCount();
      lastUsedDate.value = await StorageService.getLastUsedDate() ?? '';

      Get.snackbar(
        '통계 업데이트',
        '앱 사용 통계가 업데이트되었습니다.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.teal,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        '오류',
        '통계 업데이트에 실패했습니다.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  /// 모든 데이터 삭제
  Future<void> clearAllData() async {
    try {
      await StorageService.clear();

      // 반응형 변수 초기화
      userName.value = '';
      userEmail.value = '';
      userAge.value = 0;
      counter.value = 0;
      isDarkMode.value = false;
      language.value = 'ko';
      notificationsEnabled.value = true;
      searchHistory.clear();
      todoList.clear();
      appUsageCount.value = 0;
      lastUsedDate.value = '';

      Get.snackbar(
        '초기화',
        '모든 데이터가 삭제되었습니다.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        '오류',
        '데이터 삭제에 실패했습니다.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  /// 저장된 모든 키 확인
  Future<Set<String>> getAllKeys() async {
    return await StorageService.getKeys();
  }

  /// 특정 키 존재 여부 확인
  Future<bool> hasKey(String key) async {
    return await StorageService.containsKey(key);
  }
}
