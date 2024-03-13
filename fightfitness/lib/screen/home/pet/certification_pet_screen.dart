import 'package:flutter/material.dart';

class CertPetScreen extends StatefulWidget {
  const CertPetScreen({super.key});

  @override
  State<CertPetScreen> createState() => _CertPetScreenState();
}

class _CertPetScreenState extends State<CertPetScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '펫 등록',
          style: TextStyle(fontFamily: 'Jamsil4'),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.width,
                width: MediaQuery.of(context).size.width - 30,
                color: Colors.black,
              ),
              const SizedBox(height: 20),
              const Text(
                '* 펫 등록 하는법',
                style: TextStyle(fontFamily: 'Jamsil3', fontSize: 17),
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.only(left: 10, right: 20),
                child: Column(
                  children: [
                    Text(
                      ' 1. 인바디 결과지를 촬영합니다.(결과지가 흐릿하거나, 결과지 전체가 나오지 않을경우 반영이 안됩니다)',
                      style: TextStyle(fontFamily: 'Jamsil3', fontSize: 17),
                    ),
                    Text(
                      ' 2. 운영자가 해당 인바디를 바탕으로 펫을 생성합니다.(기본 펫 4종 중 한 개의 펫이 랜덤으로 지급되고, 능력치는 인바디 결과에 따라 달라집니다)',
                      style: TextStyle(fontFamily: 'Jamsil3', fontSize: 17),
                    ),
                    SizedBox(height: 20),
                    Text(
                      '인바디 결과지 등록 후 3일 이내에 결과가 나옵니다. 펫정보에서 확인 가능',
                      style: TextStyle(fontFamily: 'Jamsil3', fontSize: 17),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {},
            child: const Icon(Icons.image),
          ),
          const SizedBox(width: 15),
          FloatingActionButton(
            onPressed: () {},
            child: const Icon(Icons.camera),
          ),
        ],
      ),
    );
  }
}
