import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';

class LoginService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  String errorMessage = '';

  void signOut() async {
    await _auth.signOut();
  }

  Future<User> getFirebaseUser() async {
    var user = _auth.currentUser;
    if (user == null) {
      user = await _auth.authStateChanges().first;
    }
    return user;
  }

  // ignore: missing_return
  Future<User> signinWithEmailPassword(String email, String password) async {
    UserCredential userCredential;
    try {
      userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('user: ${userCredential.user}');
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found".trim()) {
        errorMessage = "No User found with this email";
        // print("No user found.");
      } else if (e.code == "wrong-password".trim()) {
        errorMessage = "Please check your credentials";
        // print("Wrong password provided.");
      } else if (e.code == "invalid-email".trim()) {
        errorMessage = "Please check your email";
        // print('wrong email proivided');
      } else if (e.code == 'user-disabled'.trim()) {
        errorMessage = "Email Disabled";
        // print('email disabled');
      } else {
        errorMessage = 'Something went wrong';
      }
    } catch (e) {
      throw e;
    }
    return userCredential.user;
  }

  Future<User> signupWithEmailPassword(String email, String password) async {
    UserCredential userCredential;
    try {
      userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('user: ${userCredential.user}');
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found".trim()) {
        errorMessage = "No User found with this email";
        // print("No user found.");
      } else if (e.code == "wrong-password".trim()) {
        errorMessage = "Please check your credentials";
        // print("Wrong password provided.");
      } else if (e.code == "invalid-email".trim()) {
        errorMessage = "Please check your email";
        // print('wrong email proivided');
      } else if (e.code == 'user-disabled'.trim()) {
        errorMessage = "Email Disabled";
        // print('email disabled');
      } else if (e.code == 'account-exists-with-different-credential') {
        errorMessage =
            'Account already exist with different provider. Try by resetting your password';
      } else {
        print(e.code.toLowerCase().toString() + '..login error');
        errorMessage = 'Something went wrong';
      }
    } catch (e) {
      print(e);
      throw e;
    }
    return userCredential.user;
  }
}
