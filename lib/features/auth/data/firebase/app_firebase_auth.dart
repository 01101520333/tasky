import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tasky/features/auth/data/model/app_user.dart';

abstract class AppFirebaseAuth {
  static CollectionReference<AppUser> get _collection => FirebaseFirestore
      .instance
      .collection("users")
      .withConverter<AppUser>(
        fromFirestore: (snapshot, options) =>
            AppUser.fromJson(snapshot.data()!),
        toFirestore: (value, options) => value.toJson(),
      );
  static Future<AppUser?> addUser(AppUser user) async {
    try {
      await _collection.doc(user.id).set(user);
      return user;
    } catch (e) {
      return null;
    }
  }

  static Future<AppUser?> updateUser(AppUser user) async {
    await _collection.doc(user.id).update(user.toJson());
    try {
      await _collection.doc(user.id).update(user.toJson());
      return user;
    } catch (e) {
      return null;
    }
  }

  static Future<bool> deleteUser(String id) async {
    try {
      await _collection.doc(id).delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<AppUser?> register({required AppUser user}) async {
    try {
      final UserCredential credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: user.email ?? "",
            password: user.password ?? "",
          );
      user.id = credential.user!.uid;
      await addUser(user);
      return user;
    } on FirebaseAuthException catch (e) {
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<bool> logIn({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return true;
    } on FirebaseAuthException catch (e) {
      return false;
    } catch (e) {
      return false;
    }
  }
}
