import 'package:flutter/material.dart';

import 'certification_pet_screen.dart';

class PetScreen extends StatefulWidget {
  const PetScreen({super.key});

  @override
  State<PetScreen> createState() => _PetScreenState();
}

class _PetScreenState extends State<PetScreen> {
  @override
  Widget build(BuildContext context) {
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CertPetScreen()));
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
