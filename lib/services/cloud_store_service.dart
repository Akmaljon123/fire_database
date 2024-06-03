import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class CFSService {
  static FirebaseFirestore db = FirebaseFirestore.instance;

  static Future<void> createData({
    required bool isBuilding,
    required Map<String, dynamic> data,
  }) async {
    String main = isBuilding ? "buildings" : "teachers";

    var documentRef = db
        .collection('university')
        .doc("university1")
        .collection(main)
        .doc();

    data["id"] = documentRef.id;

    await documentRef.set(data);

  }

  static Future<List<QueryDocumentSnapshot<Object?>>> readData(
      {required bool isBuilding}) async {
    List<QueryDocumentSnapshot> result = [];
    String main = isBuilding ? "buildings": "teachers";

    QuerySnapshot querySnapshot = await db
        .collection('university')
        .doc("university1")
        .collection(main)
        .get();

    for (var e in querySnapshot.docs) {
      result.add(e);
    }
    return result;
  }

  static Future<void> updateData(
      {required bool isBuilding,
        required Map<String, dynamic> data}) async {
    String main = isBuilding ? "buildings" : "teachers";

    await db
        .collection('university')
        .doc("university1")
        .collection(main)
        .doc(data["id"])
        .set(data);
  }

  static Future<void> deleteData(
      {required bool isBuilding,
        required Map<String, dynamic> data}) async {
    String main = isBuilding ? "buildings" : "teachers";

    await db
        .collection('university')
        .doc("university1")
        .collection(main)
        .doc(data["id"]).delete();
  }



  static Future<void> createDataStudents({
    required bool isContract,
    required Map<String, dynamic> data,
  }) async {
    String main = isContract ? "contract_students" : "grant_students";

    var documentRef = FirebaseFirestore.instance
        .collection('university')
        .doc("university1")
        .collection('students')
        .doc("student1")
        .collection(main)
        .doc();

    data["id"] = documentRef.id;

    await documentRef.set(data);

  }


  static Future<List<QueryDocumentSnapshot<Object?>>> readDataStudents(
      {required bool isContract}) async {
    List<QueryDocumentSnapshot> result = [];
    String main = isContract ? "contract_students": "grant_students";

    QuerySnapshot querySnapshot = await db
        .collection('university')
        .doc("university1")
        .collection('students')
        .doc("student1")
        .collection(main).get();

    for (var e in querySnapshot.docs) {
      result.add(e);
    }
    return result;
  }

  static Future<void> updateDataStudents(
      {required bool isContract,
      required Map<String, dynamic> data}) async {
    String main = isContract ? "contract_students": "grant_students";

    await db
        .collection('university')
        .doc("university1")
        .collection('students')
        .doc("student1")
        .collection(main)
        .doc(data["id"])
        .set(data);
  }

  static Future<void> deleteDataStudents({
    required bool isContract,
    required Map<String, dynamic> data
  }) async {
    String main = isContract ? "contract_students": "grant_students";


    try {
      log(data["id"]);
      await db
          .collection('university')
          .doc("university1")
          .collection('students')
          .doc("student1")
          .collection(main)
          .doc(data["id"])
          .delete();
      log('Document deleted successfully.');
    } catch (e) {
      log('Error deleting document: $e');
    }
  }
}
