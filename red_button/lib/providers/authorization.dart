import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  /// Changed to idTokenChanges as it updates depending on more cases.
  Stream<User> get authStateChanges => _firebaseAuth.idTokenChanges();

  /// This won't pop routes so you could do something like
  /// Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  /// after you called this method if you want to pop all routes.
  bool _isNew = false;

  bool get isNewUser {
    return _isNew;
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  /// There are a lot of different ways on how you can do exception handling.
  /// This is to make it as easy as possible but a better way would be to
  /// use your own custom class that would take the exception and return better
  /// error messages. That way you can throw, return or whatever you prefer with that instead.
  Future<String> signIn({String email, String password}) async {
    try {
      final info = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      final User user = info.user;
      AdditionalUserInfo _additionalUserInfo = info.additionalUserInfo;
      _isNew = _additionalUserInfo.isNewUser;
      print(user);
      return "Signed in";
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return e.message;
    }
  }

  /// There are a lot of different ways on how you can do exception handling.
  /// This is to make it as easy as possible but a better way would be to
  /// use your own custom class that would take the exception and return better
  /// error messages. That way you can throw, return or whatever you prefer with that instead.
  String boxName = '';
  String get getBoxName {
    return boxName;
  }

  Future<String> signUp({String email, String password}) async {
    print('singUP');
    try {
      final result = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      print('###############3');
      print(result.user.email);
      //String idToken = await result.user.getIdToken();
      // Hive.box('cart').put('currentuser',result.user.email);
      boxName = result.user.email;

      AdditionalUserInfo _additionalUserInfo = result.additionalUserInfo;
      _isNew = _additionalUserInfo.isNewUser;

      return 'Signed in';
    } on FirebaseAuthException catch (e) {
      return e.message;
    } on SocketException catch (e) {
      print(e);
      return 'No INTERNET';
    } catch (e) {
      print(e);
      return e;
    }
  }

  Future<String> signInWithPhone({String phone}) async {
    try {
      await _firebaseAuth.signInWithPhoneNumber(phone);
      return "Signed up";
    } on FirebaseAuthException catch (e) {
      return e.message;
    } on SocketException catch (e) {
      print(e);
      return 'No INTERNET';
    }
  }
}
