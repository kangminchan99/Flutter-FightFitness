import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class InbodyCheckProvider with ChangeNotifier {
  XFile? _inbodyImg;
  XFile? get inbodyImg => _inbodyImg;

  // 이미지 삭제
  void clearInbodyImg() {
    _inbodyImg = null;
    notifyListeners();
  }

  // 이미지 가져오기
  void getInbodyImg(XFile? getInbodyImg) {
    _inbodyImg = getInbodyImg;
    notifyListeners();
  }

  Future<void> addInbodyImg(String pk) async {
    try {
      String inbodyUrl = '';
      if (_inbodyImg != null) {
        // TaskSnapshot taskSnapshot = await FirebaseStorage.instance
        //     .ref()
        //     .child('Inbody/$pk')
        //     .putFile(File(_inbodyImg!.path));
        // inbodyUrl = await taskSnapshot.ref.getDownloadURL();
        print('inbody url ->$inbodyUrl');
        print('inbody img -> $_inbodyImg');
        await FirebaseFirestore.instance
            .collection('회원정보')
            .doc(pk)
            .update({'인바디 사진 링크': inbodyImg!.path, '인바디 확인 상태': '심사 대기중'});
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
