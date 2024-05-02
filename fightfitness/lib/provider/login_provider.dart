import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fightfitness/model/user_model.dart';
import 'package:fightfitness/screen/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_talk.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

// login - 아직 회원가입 중
// main - 회원가입 완료
enum CurrentPage { login, main }

class LoginProvider with ChangeNotifier {
  late User user;
  late UserModel userModel;

  // 현재 페이지로 페이지 이동
  CurrentPage _currentPage = CurrentPage.login;
  CurrentPage get currentPage => _currentPage;

  // 카카오 로그인
  Future<void> kakaoLogin() async {
    // 카카오톡이 깔려있는 경우
    if (await isKakaoTalkInstalled()) {
      try {
        // 카카오톡으로 로그인 성공 시 토큰 발급받아 저장
        OAuthToken token = await UserApi.instance.loginWithKakaoTalk();
        addKakaoUserData(token);
        _currentPage = CurrentPage.main;
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
          addKakaoUserData(token);
          _currentPage = CurrentPage.main;
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
        addKakaoUserData(token);
        _currentPage = CurrentPage.main;
        notifyListeners();
      } catch (e) {
        debugPrint('카카오 계정으로 로그인 실패 ${e.toString()}');
        notifyListeners();
      }
    }
  }

  //  토큰을 이용하여 파이어베이스에 사용자 정보 저장
  Future<void> addKakaoUserData(OAuthToken token) async {
    // auth에 등록된 계정이 아닐경우

    user = await UserApi.instance.me();
    // oidc를 사용해 Auth에 카카오 사용자 정보 저장
    var oidcKakao = firebase_auth.OAuthProvider('oidc.kakao');

    // 카카오 로그인에서 발급된 idToken
    var credential = oidcKakao.credential(
        idToken: token.idToken, accessToken: token.accessToken);

    final firebase_auth.UserCredential authResult = await firebase_auth
        .FirebaseAuth.instance
        .signInWithCredential(credential);

    // user uid 가져오기
    print('user uid ${authResult.user!.uid}');

    // // 로그인 타입
    // print('provider id : ${credential.providerId}');

    // // id 토큰
    // print('idToken : ${credential.idToken}');

    // // 액세스 토큰
    // print('accessToken : ${credential.accessToken}');

    // 로컬에 로그인 진행상황 저장
    await storage.write(key: 'loginProgress', value: 'nav');
    await storage.write(key: 'userUid', value: authResult.user!.uid);

    var kakaoProfile = user.kakaoAccount!.profile!.nickname;

    dynamic data = {
      'loginType': 'kakao',
      'userUid': authResult.user!.uid,
      'userName': kakaoProfile,
      'userDeviceToken': "",
      'userAge': 0,
    };
    userModel = UserModel.fromJson(data);

    await FirebaseFirestore.instance
        .collection("회원정보")
        .doc(authResult.user!.uid)
        .set(data);

    // // 로그인 성공 페이지 전환
    // _currentPage = CurrentPage.main;
  }

  ////     apple login     /////

  Future<void> appleLogin() async {
    final AuthorizationCredentialAppleID credentialAppleID =
        await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    final firebase_auth.OAuthCredential credential =
        firebase_auth.OAuthProvider('apple.com').credential(
      idToken: credentialAppleID.identityToken,
      accessToken: credentialAppleID.authorizationCode,
    );

    await firebase_auth.FirebaseAuth.instance.signInWithCredential(credential);
    notifyListeners();
  }
}
