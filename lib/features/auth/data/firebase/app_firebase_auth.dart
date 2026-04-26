import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tasky/core/network/resulet_firebase.dart';
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
  static Future<ResuletFirebase<AppUser>> addUser(AppUser user) async {
    try {
      await _collection.doc(user.id).set(user);
      return Success(user);
    } catch (e) {
      return Error(e.toString());
    }
  }

  static Future<ResuletFirebase<AppUser>> updateUser(AppUser user) async {
    await _collection.doc(user.id).update(user.toJson());
    try {
      await _collection.doc(user.id).update(user.toJson());
      return Success(user);
    } catch (e) {
      return Error(e.toString());
    }
  }

  static Future<ResuletFirebase<bool>> deleteUser(String id) async {
    try {
      await _collection.doc(id).delete();
      return Success(true);
    } catch (e) {
      return Error(e.toString());
    }
  }

  static Future<ResuletFirebase<AppUser>> register({
    required AppUser user,
  }) async {
    try {
      final UserCredential credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: user.email ?? "",
            password: user.password ?? "",
          );
      user.id = credential.user!.uid;
      var res = await addUser(user);
      switch (res) {
        case Success<AppUser>():
          return Success(user);
        case Error<AppUser>():
          return Error("Error from store the user on database");
      }
    } on FirebaseAuthException catch (e) {
      return Error(e.toString());
    } catch (e) {
      return Error(e.toString());
    }
  }

  static Future<ResuletFirebase<bool>> logIn({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Success(true);
    } on FirebaseAuthException catch (e) {
      return Error(e.toString());
    } catch (e) {
      return Error(e.toString());
    }
  }
}
