import 'package:firebase_auth/firebase_auth.dart';
import 'package:modoh/models/budget.dart';
import 'package:modoh/models/student.dart';
import 'package:modoh/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create Student object base on User from Firebase
  Student _studentFromUser(User user) {
    return user != null ? Student(uid: user.uid, email: user.email) : null;
  }

  // sign in anon
  Future signInAnon() async {
    try {
      print(_auth.toString());
      UserCredential cred = await _auth.signInAnonymously();
      return _studentFromUser(cred.user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // log in with email & password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential cred = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return _studentFromUser(cred.user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  // auth change user stream
  Stream<Student> get user {
    return _auth.authStateChanges().map((User user) => _studentFromUser(user));
  }

  // register with email & password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      // create a new document for each new user
      await DatabaseService(uid: cred.user.uid).updateUserData(new Budget());
      return _studentFromUser(cred.user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
