import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseCloudHelper {
  FirebaseCloudHelper._();

  static final FirebaseCloudHelper firebaseCloudHelper = FirebaseCloudHelper._();

  static final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  CollectionReference author = firebaseFirestore.collection("movies");

  insertData({
    required int id,
    required String name,
    required String genre,
    required String type,
    required String rating,
    required String wood,
    required String language,
  }) async {

    await author.doc().set({'id': id,'name': name, 'genre': genre, "type": type,'rating': rating,'wood': wood,'language': language,});
  }

  Stream<QuerySnapshot> fetchAllData() {
    Stream<QuerySnapshot> stream = author.snapshots();

    return stream;
  }
}
