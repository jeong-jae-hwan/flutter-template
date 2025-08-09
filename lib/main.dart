import 'package:flutter/foundation.dart' show kReleaseMode, debugPrint;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'controllers/navigation_controller.dart';
import 'pages/api_page.dart';
import 'pages/counter_page.dart';
import 'pages/home_page.dart';
import 'pages/splash_page.dart';
import 'pages/todo_page.dart';
import 'pages/ui_guide_page.dart';
import 'pages/user_page.dart';
import 'services/env_service.dart';
import 'services/storage_service.dart';

void main() async {
  // Flutter 프레임워크 초기화
  WidgetsFlutterBinding.ensureInitialized();

  // 환경변수 초기화
  await EnvService.initialize();

  // 앱스토리지 초기화
  await StorageService.initialize();

  runApp(const GetXTutorialApp());
}

class GetXTutorialApp extends StatelessWidget {
  const GetXTutorialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: '튜토리얼',
      enableLog: !kReleaseMode, // 릴리즈 모드에서는 로그 비활성화
      logWriterCallback: (String text, {bool isError = false}) {
        // 전역 로그 출력: print 대신 debugPrint 사용
        debugPrint(text);
      },
      debugShowCheckedModeBanner: false, // 디버깅 배너 제거
      initialRoute: '/splash',
      theme: ThemeData(
        // 머티리얼 디자인 시스템 적용
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
        // Noto Sans KR 폰트 적용
        textTheme: GoogleFonts.notoSansKrTextTheme(),
        // 앱바 테마 설정
        appBarTheme: AppBarTheme(
          titleTextStyle: GoogleFonts.notoSansKr(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF48494A),
          ),
          backgroundColor: Colors.white, // 헤더 흰색
          foregroundColor: const Color(0xFF48494A), // 아이콘 색상도 #48494a
          elevation: 0, // 그림자 제거
          centerTitle: true,
          surfaceTintColor: Colors.transparent, // Material 3 그림자 제거
          shadowColor: Colors.transparent, // 그림자 색상 투명
        ),
        // 버튼 테마 설정
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        // 카드 테마 설정
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        // 입력 필드 테마 설정
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.deepPurple, width: 2),
          ),
        ),
        // 하단 네비게이션 테마 설정
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.deepPurple,
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.white,
          elevation: 8,
        ),
      ),
      // 라우트 설정
      getPages: [
        GetPage(name: '/splash', page: () => const SplashPage()),
        GetPage(name: '/main', page: () => const MainApp()),
        GetPage(name: '/home', page: () => const HomePage()),
        GetPage(
          name: '/counter',
          page: () => const CounterPage(),
          transition: Transition.fadeIn,
        ),
        GetPage(name: '/todo', page: () => const TodoPage()),
        GetPage(name: '/user', page: () => const UserPage()),
        GetPage(name: '/ui-guide', page: () => const UiGuidePage()),
        GetPage(name: '/api', page: () => const ApiPage()),
      ],
    );
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final NavigationController navigationController = Get.put(
      NavigationController(),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('GetX 튜토리얼'), centerTitle: true),
      body: Obx(
        () => IndexedStack(
          index: navigationController.currentIndex.value,
          children: const [
            HomePage(),
            CounterPage(),
            TodoPage(),
            UserPage(),
            ApiPage(),
            UiGuidePage(),
          ],
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: navigationController.currentIndex.value,
          onTap: navigationController.changePage,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.deepPurple,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
            BottomNavigationBarItem(icon: Icon(Icons.add_circle), label: '카운터'),
            BottomNavigationBarItem(icon: Icon(Icons.checklist), label: '할일'),
            BottomNavigationBarItem(icon: Icon(Icons.people), label: '사용자'),
            BottomNavigationBarItem(icon: Icon(Icons.api), label: 'API'),
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              label: 'UI 가이드',
            ),
          ],
        ),
      ),
    );
  }
}
