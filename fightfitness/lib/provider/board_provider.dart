import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class BoardProvider with ChangeNotifier {
  XFile? _boardImg;
  XFile? get boardImg => _boardImg;

  void clearBoardImg() {
    _boardImg = null;
    notifyListeners();
  }

  void getBoardImg(XFile? getBoardImg) {
    _boardImg = getBoardImg;
    notifyListeners();
  }

  Future<void> addBoard(
      String title, String contents, DateTime uploadTime, String pk) async {
    try {
      await FirebaseFirestore.instance.collection('게시판').add({
        '제목': title,
        '내용': contents,
        '올린시간': uploadTime,
        'pk': pk,
        '사진': boardImg ?? '',
        '좋아요 수': 0,
        '신고 수': 0,
        '댓글 수': 0,
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
