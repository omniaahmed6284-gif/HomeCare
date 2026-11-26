import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  Future<UserModel> signUp({
    required String name,
    required String email,
    required String password,
    required String phone,
    String? address,
    required String role,
  }) async {
    UserCredential credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final firebaseUser = credential.user;

    if (firebaseUser == null) {
      throw Exception('Failed to create user account.');
    }

    try {
      UserModel user = UserModel(
        userId: firebaseUser.uid,
        name: name,
        email: email,
        phone: phone,
        address: address,
        role: role,
        createdAt: DateTime.now(),
      );

      await _firestore
          .collection('users')
          .doc(firebaseUser.uid)
          .set(user.toMap());

      return user;
    } catch (e) {
      try {
        await firebaseUser.delete();
      } catch (_) {}

      rethrow;
    }
  }


  Future<UserModel?> login({
    required String email,
    required String password,
  }) async {

    UserCredential credential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    String uid = credential.user!.uid;

    // Get user data from Firestore
    DocumentSnapshot document =
    await _firestore.collection('users').doc(uid).get();

    if (!document.exists) {
      await _auth.signOut();
      return null;
    }
    return UserModel.fromMap(
      document.data() as Map<String, dynamic>,
    );
  }

  Future<UserModel?> getCurrentUserData() async {
    final firebaseUser = _auth.currentUser;

    if (firebaseUser == null) {
      return null;
    }

    final document = await _firestore
        .collection('users')
        .doc(firebaseUser.uid)
        .get();

    if (!document.exists || document.data() == null) {
      await _auth.signOut();
      return null;
    }

    return UserModel.fromMap(document.data()!);
  }


  Future<void> logout() async {
    await _auth.signOut();
  }


  User? get currentUser => _auth.currentUser;

}
