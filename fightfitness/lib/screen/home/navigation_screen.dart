import 'package:fightfitness/provider/navigation_provider.dart';
import 'package:fightfitness/screen/home/battle_screen.dart';
import 'package:fightfitness/screen/home/board_screen.dart';
import 'package:fightfitness/screen/home/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pet/pet_screen.dart';

class NavScreen extends StatefulWidget {
  const NavScreen({super.key});

  @override
  State<NavScreen> createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationProvider>(
      builder: (context, p, child) {
        // 뒤로가기 버튼 무시
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Scaffold(
            backgroundColor: Colors.white,
            body: IndexedStack(
              index: p.currentPage,
              children: const [
                PetScreen(),
                BattleScreen(),
                BoardScreen(),
                ProfileScreen(),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.shifting,
              // 라벨 보이게
              showUnselectedLabels: true,
              // 텍스트 색깔 지정
              unselectedItemColor: Colors.white,
              selectedItemColor: Colors.black,
              unselectedLabelStyle:
                  const TextStyle(fontSize: 13, fontFamily: 'Jamsil3'),
              selectedLabelStyle: const TextStyle(
                fontSize: 17,
                fontFamily: 'Jamsil3',
              ),

              items: [
                BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/images/nav/pet.png',
                    scale: 1.5,
                  ),
                  label: '펫',
                  backgroundColor: Colors.brown,
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/images/nav/battle.png',
                    scale: 1.5,
                  ),
                  label: '전투',
                  backgroundColor: Colors.blueAccent,
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/images/nav/board.png',
                    scale: 1.5,
                  ),
                  label: '게시판',
                  backgroundColor: const Color.fromARGB(255, 230, 218, 108),
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/images/nav/profile.png',
                    scale: 1.5,
                  ),
                  label: '내정보',
                  // shifting으로 설정 시 배경색 다 넣어줘야함
                  backgroundColor: Colors.blueGrey,
                ),
              ],
              currentIndex: p.currentPage,
              onTap: (index) {
                p.changePage(index);
              },
            ),
          ),
        );
      },
    );
  }
}
