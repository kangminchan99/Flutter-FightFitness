import 'package:fightfitness/firebase_options.dart';
import 'package:fightfitness/provider/inbody_check_provider.dart';
import 'package:fightfitness/provider/navigation_provider.dart';
import 'package:fightfitness/screen/home/navigation_screen.dart';
import 'package:fightfitness/screen/login/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_template.dart';
import 'package:provider/provider.dart';

import 'provider/login_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // 파이어베이스 연결
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await dotenv.load(fileName: '.env');

  KakaoSdk.init(
    nativeAppKey: dotenv.env['KAKAO_NATIVE_APP_KEY'],
    javaScriptAppKey: dotenv.env['KAKAO_JAVASCRIPT_KEY'],
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // 로그인
        ChangeNotifierProvider(create: ((context) => LoginProvider())),
        // 바텀 네비게이션
        ChangeNotifierProvider(create: (context) => NavigationProvider()),
        // 인바디 체크
        ChangeNotifierProvider(create: (context) => InbodyCheckProvider()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          // 라우터 설정
          routes: {
            "/nav": (context) => const NavScreen(),
          },
          home: const LoginScreen()),
    );
  }
}
