import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_talk.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class LoginProvider with ChangeNotifier {
  // 카카오 로그인
  Future<void> kakaoLogin() async {
    // 카카오톡이 깔려있는 경우
    if (await isKakaoTalkInstalled()) {
      try {
        // 카카오톡으로 로그인 성공 시 토큰 발급받아 저장
        OAuthToken token = await UserApi.instance.loginWithKakaoTalk();
        addUserData(token);

        notifyListeners();
      } catch (e) {
        debugPrint('kakao login fail.. ${e.toString()}');
        // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
        // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
        if (e is PlatformException && e.code == 'CANCLED') {
          return;
        }
        // 카카오톡에 연결된 카카오 계정이 없는 경우, 카카오 계정으로 로그인
        try {
          OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
          addUserData(token);
          debugPrint('카카오 계정으로 로그인 성공');
          notifyListeners();
        } catch (e) {
          debugPrint('카카오 계정으로 로그인 실패 ${e.toString()}');
          notifyListeners();
        }
      }
    } else {
      try {
        OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
        addUserData(token);
        notifyListeners();
      } catch (e) {
        debugPrint('카카오 계정으로 로그인 실패 ${e.toString()}');
        notifyListeners();
      }
    }
  }

  //  토큰을 이용하여 파이어베이스에 사용자 정보 저장
  Future<void> addUserData(OAuthToken token) async {
    // oidc를 사용해 카카오 사용자 정보 저장
    var oidcKakao = firebase_auth.OAuthProvider('oidc.kakao');
    // 카카오 로그인에서 발급된 idToken
    var credential = oidcKakao.credential(
        idToken: token.idToken, accessToken: token.accessToken);
    firebase_auth.FirebaseAuth.instance.signInWithCredential(credential);
  }
}
