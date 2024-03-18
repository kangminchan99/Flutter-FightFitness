import 'package:fightfitness/provider/login_provider.dart';
import 'package:flutter/material.dart';
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
      body: Center(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                print(loginProvider.userModel.userUid);
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => const CertPetScreen()));
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
            )
          ],
        ),
      ),
    );
  }
}
