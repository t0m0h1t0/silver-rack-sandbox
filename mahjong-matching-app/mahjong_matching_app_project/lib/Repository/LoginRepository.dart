import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app2/Entity/User.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_database/firebase_database.dart';
//import 'package:flutter_twitter_login/flutter_twitter_login.dart';
//import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:flutter_app2/Entity/AuthStatus.dart';

/*----------------------------------------------

ログインRepositoryクラス

----------------------------------------------*/
class LoginRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  LoginRepository({FirebaseAuth firebaseAuth, GoogleSignIn googleSignin})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignin ?? GoogleSignIn();
  //コンストラクタ引数の{}は名前付き任意引数で、生成時に指定できる。(しない場合はnullで生成される)
  // ??はnull判定(if null)

  //Googleサインイン部分
  Future<FirebaseUser> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await _firebaseAuth.signInWithCredential(credential);
    return _firebaseAuth.currentUser();
  }

  //fireBaseサインイン部分
  checkFireBaseLogin(FirebaseUser currentUser) async {
    final _mainReference = FirebaseDatabase.instance.reference().child("User");
    //メールアドレス正規化
    var userId = makeUserId(currentUser.email);
    User user;
    try {
      await _mainReference.child(userId).once().then((DataSnapshot result) async {
        if (result.value == null || result.value == "") {
          user = User.tmpUser(AuthStatus.signedUp, userId);
        } else {
          user = User.fromMap(userId, result.value);
        }
      });
      return user;
    } catch (e, stackTrace) {
      print(e);
      print(stackTrace);
    }
  }

  isSignedIn() async {
    try {
      final currentUser = await _firebaseAuth.currentUser();
      return currentUser;
    } catch (e, stackTrace) {
      print(e);
      print(stackTrace);
    }
  }

  //ログアウト
  Future<void> signOut() async {
    try {
      return Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
      ]);
    } catch (e, stackTrace) {
      print(e);
      print(stackTrace);
    }
  }

  String makeUserId(String key) {
    String userId = key.replaceAll(RegExp(r'@[A-Za-z]+.[A-Za-z]+'), "");
    return userId.replaceAll(".", "[dot]");
  }
/* ------Twitterサインイン機能------
  final TwitterLogin twitterLogin = TwitterLogin(
    consumerKey: consumerKey,
    consumerSecret: secretkey,
  );
  Future<FirebaseUser> signInWithTwitter() async {
    // twitter認証の許可画面が出現
    final TwitterLoginResult result = await twitterLogin.authorize();
    //Firebaseのユーザー情報にアクセス & 情報の登録 & 取得
    final AuthCredential credential = TwitterAuthProvider.getCredential(
      authToken: result.session.token,
      authTokenSecret: result.session.secret,
    );
    //Firebaseのuser id取得
    final FirebaseUser user = (await _firebaseAuth.signInWithCredential(credential)).user;
    return _firebaseAuth.currentUser();
  }*/

/*------Appleサインイン機能------
  Future signInWithApple() async {
    final AuthorizationResult result = await AppleSignIn.performRequests([
      AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
    ]);

    switch (result.status) {
      case AuthorizationStatus.authorized:
        print("success");
        print(result.credential.user);
        // ログイン成功

        break;

      case AuthorizationStatus.error:
        print("Sign in failed: ${result.error.localizedDescription}");

        throw Exception(result.error.localizedDescription);
        break;

      case AuthorizationStatus.cancelled:
        print('User cancelled');
        break;
    }
  }
  * */
}
