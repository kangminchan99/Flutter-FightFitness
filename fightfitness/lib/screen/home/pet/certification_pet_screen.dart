import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:fightfitness/provider/inbody_check_provider.dart';
import 'package:fightfitness/provider/login_provider.dart';
import 'package:fightfitness/screen/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class CertPetScreen extends StatefulWidget {
  const CertPetScreen({super.key});

  @override
  State<CertPetScreen> createState() => _CertPetScreenState();
}

class _CertPetScreenState extends State<CertPetScreen> {
  void update() => setState(() {});
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final inbodyProvider = Provider.of<InbodyCheckProvider>(context);
    final loginProvider = Provider.of<LoginProvider>(context);
    ImagePicker imagePicker = ImagePicker();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '펫 등록',
          style: TextStyle(fontFamily: 'Jamsil4'),
        ),
        actions: inbodyProvider.inbodyImg != null
            ? [
                TextButton(
                    onPressed: () {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.success,
                        title: "펫 등록",
                        titleTextStyle: const TextStyle(
                          fontSize: 20,
                          fontFamily: 'Jamsil4',
                        ),
                        desc:
                            '인바디 사진이 제대로 찍혔나요?\n\n(인바디 결과지 등록 후 3일 이내에 결과가 나옵니다. 펫정보에서 확인 가능)',
                        descTextStyle: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'Jamsil3',
                        ),
                        btnOkOnPress: () async {
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.blue,
                                  ),
                                );
                              });
                          // inbodyProvider
                          //     .addInbodyImg(loginProvider.userModel.userUid);
                          var userUid = await storage.read(key: 'userUid');
                          await inbodyProvider.addInbodyImg(userUid!);

                          inbodyProvider.clearInbodyImg();

                          if (!mounted) return;
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        btnOkIcon: Icons.check_circle,
                        btnCancelOnPress: () {},
                        btnCancelColor: Colors.pink,
                        btnCancelIcon: Icons.cancel,
                      ).show();
                    },
                    child: const Text(
                      '제출',
                      style: TextStyle(fontFamily: 'Jamsil4', fontSize: 18),
                    ))
              ]
            : [],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              inbodyProvider.inbodyImg == null
                  ? SizedBox(
                      height: MediaQuery.of(context).size.width,
                      width: MediaQuery.of(context).size.width - 30,
                      child: Image.asset(
                        'assets/images/pet_info/default_pet.jpg',
                        fit: BoxFit.fill,
                      ),
                    )
                  : Stack(
                      alignment: Alignment.topRight,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.width,
                          width: MediaQuery.of(context).size.width - 30,
                          child: Image.file(
                            File(inbodyProvider.inbodyImg!.path),
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10, top: 10),
                          child: GestureDetector(
                            onTap: () {
                              inbodyProvider.clearInbodyImg();
                            },
                            child: Image.asset(
                              'assets/images/close.png',
                              scale: 1.5,
                            ),
                          ),
                        )
                      ],
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
                    SizedBox(height: 20),
                    Text(
                      ' 2. 운영자가 해당 인바디를 바탕으로 펫을 생성합니다.(기본 펫 4종 중 한 개의 펫이 랜덤으로 지급되고, 능력치는 인바디 결과에 따라 달라집니다)',
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
            heroTag: 'image',
            onPressed: () async {
              try {
                final XFile? inbodyGalleyImg =
                    await imagePicker.pickImage(source: ImageSource.gallery);
                if (inbodyGalleyImg != null) {
                  update();
                  inbodyProvider.getInbodyImg(XFile(inbodyGalleyImg.path));
                }
              } catch (e) {
                debugPrint(e.toString());
              }
            },
            child: const Icon(Icons.image),
          ),
          const SizedBox(width: 15),
          FloatingActionButton(
            heroTag: 'camera',
            onPressed: () async {
              try {
                final XFile? inbodyCameraImg =
                    await imagePicker.pickImage(source: ImageSource.camera);
                if (inbodyCameraImg != null) {
                  update();
                  inbodyProvider.getInbodyImg(XFile(inbodyCameraImg.path));
                }
              } catch (e) {
                debugPrint(e.toString());
              }
            },
            child: const Icon(Icons.camera),
          ),
        ],
      ),
    );
  }
}
