import 'package:flutter/material.dart';

class BoardWriteScreen extends StatefulWidget {
  const BoardWriteScreen({super.key});

  @override
  State<BoardWriteScreen> createState() => _BoardWriteScreenState();
}

class _BoardWriteScreenState extends State<BoardWriteScreen> {
  TextEditingController _titleEditingController = TextEditingController();
  TextEditingController _contentEditingController = TextEditingController();

  void update() => setState(() {});

  @override
  void dispose() {
    _titleEditingController.dispose();
    _contentEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '게시판 글 쓰기',
          style: TextStyle(fontFamily: 'Jamsil4'),
        ),
        actions: _titleEditingController.text.isNotEmpty &&
                _contentEditingController.text.isNotEmpty
            ? [
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    '작성',
                    style: TextStyle(fontFamily: 'Jamsil4', fontSize: 17),
                  ),
                ),
              ]
            : [],
      ),
      body: Column(
        children: [
          TextField(
            controller: _titleEditingController,
            decoration: const InputDecoration(hintText: '제목'),
          ),
          TextField(
            controller: _contentEditingController,
            decoration: const InputDecoration(hintText: '내용'),
          ),
          Stack(
            alignment: Alignment.topRight,
            children: [
              Container(
                height: MediaQuery.of(context).size.width,
                width: MediaQuery.of(context).size.width - 30,
                color: Colors.black,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10, top: 10),
                child: GestureDetector(
                  onTap: () {},
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
    );
  }
}
