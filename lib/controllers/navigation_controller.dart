import 'package:get/get.dart';

class NavigationController extends GetxController {
  // 현재 선택된 페이지 인덱스
  var currentIndex = 0.obs;

  // 페이지 변경 메서드
  void changePage(int index) {
    currentIndex.value = index;
  }
}
