// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class AuthMethod {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   // SignUp User
//   Future<String> signupUser({
//     required String email,
//     required String password,
//     required String name,
//     required String phone,
//   }) async {
//     String res = "Some error Occurred";
//     try {
//       if (email.isNotEmpty && password.isNotEmpty && name.isNotEmpty && phone.isNotEmpty) {
//         // Register user in auth with email and password
//         UserCredential cred = await _auth.createUserWithEmailAndPassword(
//           email: email,
//           password: password,
//         );
//         // Add user to your Firestore database
//         await _firestore.collection("users").doc(cred.user!.uid).set({
//           'name': name,
//           'uid': cred.user!.uid,
//           'email': email,
//           'phone': phone,
//         });
//         res = "success";
//       }
//     } catch (err) {
//       return err.toString();
//     }
//     return res;
//   }

//   // LogIn User
//   Future<String> SignInUser({
//     required String email,
//     required String password,
//   }) async {
//     String res = "Some error Occurred";
//     try {
//       if (email.isNotEmpty || password.isNotEmpty) {
//         // Log in user with email and password
//         await _auth.signInWithEmailAndPassword(
//           email: email,
//           password: password,
//         );
//         res = "success";
//       } else {
//         res = "Please enter all the fields";
//       }
//     } catch (err) {
//       return err.toString();
//     }
//     return res;
//   }

//   // For signOut
//   Future<void> signOut() async {
//     try {
//       await _auth.signOut();
//     } catch (e) {
//       print("Error signing out: $e");
//     }
//   }

//   // Get User ID
//   Future<String?> getUserId() async {
//     try {
//       User? user = _auth.currentUser;
//       if (user != null) {
//         return user.uid; // Return the user ID
//       } else {
//         return null; // No user is logged in
//       }
//     } catch (e) {
//       print("Error fetching user ID: $e");
//       return null; // Return null in case of an error
//     }
//   }
// }

//2
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethod {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
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
      if (email.isNotEmpty && password.isNotEmpty && name.isNotEmpty && phone.isNotEmpty) {
        // Register user in Firebase Authentication
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Add user to Firestore database
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
      if (email.isNotEmpty && password.isNotEmpty) { // تم تصحيح الخطأ هنا
        // Log in user with email and password
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
