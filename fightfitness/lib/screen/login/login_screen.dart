import 'dart:io';

import 'package:fightfitness/provider/login_provider.dart';
import 'package:fightfitness/screen/home/navigation_screen.dart';
import 'package:fightfitness/screen/sing_up/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

const storage = FlutterSecureStorage();

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
    // 자동 로그인
    checkProgress();
  }

  void checkProgress() async {
    // await storage.delete(key: 'loginProgress');
    var progress = await storage.read(key: 'loginProgress');
    storage.delete(key: 'loginProgress');
    if (progress == "nav") {
      if (!mounted) return;
      Navigator.pushNamed(context, '/nav');
    }
  }

  void update() => setState(() {});
  @override
  Widget build(BuildContext context) {
    var loginProvider = context.read<LoginProvider>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Fit Pet',
          style: TextStyle(
              fontFamily: 'Jamsil5', color: Colors.white60, fontSize: 25),
        ),
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/gif/main_gif.gif'),
                fit: BoxFit.fill)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width,
            ),
            // 플랫폼이 Android일 경우 애플 로그인 invisible
            Platform.isIOS
                ? GestureDetector(
                    onTap: () {
                      loginProvider.appleLogin();
                    },
                    child: Container(
                      width: 300,
                      height: 46,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 7),
                            child: Image.asset(
                              'assets/images/Apple_logo.png',
                              scale: 37,
                            ),
                          ),
                          const Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 15),
                                  child: Text(
                                    '애플 로그인',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : const SizedBox(),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () async {
                // 카카오 로그인
                await loginProvider.kakaoLogin();
                checkProgress();
                if (!mounted) return;
                if (loginProvider.currentPage == CurrentPage.main) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.blue,
                        ),
                      );
                    },
                  );

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NavScreen(),
                    ),
                  );
                }
              },
              child: SizedBox(
                width: 300,
                height: 46,
                child: Image.asset('assets/images/kakao_login_large_wide.png'),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
