import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethod {
  // Instance of Firestore to interact with the database
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // Instance of FirebaseAuth to handle authentication
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign Up User
  Future<String> signupUser({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    String res = "Some error occurred";
    try {
      // Check that all fields are filled
      if (email.isNotEmpty &&
          password.isNotEmpty &&
          name.isNotEmpty &&
          phone.isNotEmpty) {
        // Validate email format
        if (!isValidEmail(email)) {
          return "Please enter a valid email address";
        }

        // Validate phone number (digits only)
        if (!isValidPhone(phone)) {
          return "Phone number must contain digits only";
        }
        // Register user in Firebase Authentication with email and password
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Save additional user information to Firestore using the UID
        await _firestore.collection("users").doc(cred.user!.uid).set({
          'name': name,
          'uid': cred.user!.uid,
          'email': email,
          'phone': phone,
        });

        res = "success";
      } else {
        res = "Please fill all fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  // Log In User
  Future<String> signInUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  // Sign Out User
  Future<String> signOut() async {
    try {
      await _auth.signOut();
      return "Signed out successfully";
    } catch (e) {
      return "Error signing out: $e";
    }
  }

  // Get User ID
  String? getUserId() {
    return _auth.currentUser?.uid;
  }
}

bool isValidEmail(String email) {
  return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
}

bool isValidPhone(String phone) {
  return RegExp(r'^\d+$').hasMatch(phone);
}
