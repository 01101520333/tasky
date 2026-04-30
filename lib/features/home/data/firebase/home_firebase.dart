import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tasky/core/network/resulet_firebase.dart';
import 'package:tasky/features/home/data/models/app_task_model.dart';

class HomeFirebase {
  static CollectionReference<AppTaskModel> get _getCollection {
    var id = FirebaseAuth.instance.currentUser?.uid;
    return FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .collection("Tasks")
        .withConverter<AppTaskModel>(
          fromFirestore: (snapshot, options) =>
              AppTaskModel.fromJeson(snapshot.data()!),
          toFirestore: (task, options) => task.toJson(),
        );
  }

  static Future<ResuletFirebase<AppTaskModel>> addTask(
    AppTaskModel task,
  ) async {
    try {
      final doc = _getCollection.doc();
      task.id = doc.id;
      await doc.set(task);
      log("success");
      return Success<AppTaskModel>(task);
    } catch (e) {
      return Error(e.toString());
    }
  }

  static Future<ResuletFirebase<AppTaskModel>> updateTask(
    AppTaskModel task,
  ) async {
    try {
      await _getCollection.doc(task.id).update(task.toJson());
      return Success<AppTaskModel>(task);
    } catch (e) {
      return Error(e.toString());
    }
  }

  static Future<ResuletFirebase<bool>> deleteTask(String id) async {
    try {
      await _getCollection.doc(id).delete();
      return Success<bool>(true);
    } catch (e) {
      return Error(e.toString());
    }
  }

  static Future<ResuletFirebase<List<AppTaskModel>>> getTasks(
    DateTime data,
  ) async {
    final date = DateTime(data.year, data.month, data.day);
    try {
      final QuerySnapshot<AppTaskModel> getTasks = await _getCollection
          .where("date", isEqualTo: date.millisecondsSinceEpoch)
          .get();
      final List<QueryDocumentSnapshot<AppTaskModel>> docs = getTasks.docs;
      List<AppTaskModel> tasks = docs
          .map<AppTaskModel>((task) => task.data())
          .toList();
      return Success<List<AppTaskModel>>(tasks);
    } catch (e) {
      return Error(e.toString());
    }
  }
}
