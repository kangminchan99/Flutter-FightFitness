import 'package:fightfitness/provider/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import 'certification_pet_screen.dart';

class PetScreen extends StatefulWidget {
  const PetScreen({super.key});

  @override
  State<PetScreen> createState() => _PetScreenState();
}

class _PetScreenState extends State<PetScreen> {
  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '펫 정보',
          style: TextStyle(fontFamily: 'Jamsil4'),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    // print(loginProvider.userModel.userUid);

                    Navigator.push(
                      context,
                      PageTransition(
                          child: const CertPetScreen(),
                          type: PageTransitionType.bottomToTop),
                    );
                  },
                  child: const CircleAvatar(
                    radius: 70,
                    foregroundImage: AssetImage(
                      'assets/images/pet_info/default_pet.jpg',
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  '펫을 생성해 주세요!',
                  style: TextStyle(fontFamily: 'Jamsil4', fontSize: 17),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '펫 정보(여기다가 펫 이름 넣기)',
                    style: TextStyle(fontFamily: 'Jamsil4', fontSize: 25),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10, top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LV',
                          style: TextStyle(fontFamily: 'Jamsil3', fontSize: 18),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'EXP',
                          style: TextStyle(fontFamily: 'Jamsil3', fontSize: 18),
                        ),
                        SizedBox(height: 20),
                        Text(
                          '능력치',
                          style: TextStyle(fontFamily: 'Jamsil3', fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
