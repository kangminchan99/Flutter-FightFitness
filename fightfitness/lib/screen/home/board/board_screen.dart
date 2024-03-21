import 'package:fightfitness/screen/home/board/board_write_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class BoardScreen extends StatefulWidget {
  const BoardScreen({super.key});

  @override
  State<BoardScreen> createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '게시판',
          style: TextStyle(fontFamily: 'Jamsil4'),
        ),
        automaticallyImplyLeading: false,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              PageTransition(
                  child: const BoardWriteScreen(),
                  type: PageTransitionType.bottomToTop));
        },
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset('assets/images/write_dog.jpg')),
      ),
    );
  }
}
