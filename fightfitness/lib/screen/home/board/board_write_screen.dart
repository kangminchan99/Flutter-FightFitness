import 'dart:io';

import 'package:fightfitness/provider/board_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class BoardWriteScreen extends StatefulWidget {
  const BoardWriteScreen({super.key});

  @override
  State<BoardWriteScreen> createState() => _BoardWriteScreenState();
}

class _BoardWriteScreenState extends State<BoardWriteScreen> {
  TextEditingController titleEditingController = TextEditingController();
  TextEditingController contentEditingController = TextEditingController();

  void update() => setState(() {});

  @override
  void dispose() {
    titleEditingController.dispose();
    contentEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final boardProvider = Provider.of<BoardProvider>(context);
    ImagePicker imagePicker = ImagePicker();
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            '게시판 글 쓰기',
            style: TextStyle(fontFamily: 'Jamsil4'),
          ),
          actions: [
            TextButton(
              onPressed: () {},
              child: Text(
                '작성',
                style: TextStyle(
                    fontFamily: 'Jamsil4',
                    fontSize: 17,
                    color: titleEditingController.text.isEmpty ||
                            contentEditingController.text.isEmpty
                        ? Colors.grey
                        : Colors.blue),
              ),
            ),
          ]),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          children: [
            TextField(
              controller: titleEditingController,
              // 실시간으로 변화를 감지하기 위해서 onChanged를 setstate돌려준다.
              onChanged: (_) => update(),
              decoration: const InputDecoration(
                  hintText: '제목',
                  hintStyle: TextStyle(fontFamily: 'Jamsil3', fontSize: 18)),
            ),
            TextField(
              controller: contentEditingController,
              onChanged: (_) => update(),
              decoration: const InputDecoration(
                  hintText: '내용',
                  hintStyle: TextStyle(fontFamily: 'Jamsil3', fontSize: 18)),
            ),
            const SizedBox(height: 20),
            boardProvider.boardImg == null
                ? SizedBox(
                    height: MediaQuery.of(context).size.width,
                    width: MediaQuery.of(context).size.width,
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
                        width: MediaQuery.of(context).size.width - 3,
                        child: Image.file(
                          File(boardProvider.boardImg!.path),
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10, top: 10),
                        child: GestureDetector(
                          onTap: () {
                            boardProvider.clearBoardImg();
                          },
                          child: Image.asset(
                            'assets/images/close.png',
                            scale: 1.5,
                          ),
                        ),
                      )
                    ],
                  ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'image',
            onPressed: () async {
              try {
                final XFile? boardGalleyImg =
                    await imagePicker.pickImage(source: ImageSource.gallery);
                if (boardGalleyImg != null) {
                  update();
                  boardProvider.getBoardImg(XFile(boardGalleyImg.path));
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
                final XFile? boardCameraImg =
                    await imagePicker.pickImage(source: ImageSource.camera);
                if (boardCameraImg != null) {
                  update();
                  boardProvider.getBoardImg(XFile(boardCameraImg.path));
                }
              } catch (e) {
                debugPrint(e.toString());
              }
            },
            child: const Icon(Icons.camera),
          )
        ],
      ),
    );
  }
}
