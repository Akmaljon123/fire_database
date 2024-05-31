import 'package:fire_database/models/post_model.dart';
import 'package:fire_database/models/student_grant_model.dart';
import 'package:fire_database/models/teacher_model.dart';
import 'package:fire_database/models/uni_model.dart';
import 'package:firebase_database/firebase_database.dart';

import '../models/student_model.dart';

class RealTimeDatabase{
  static DatabaseReference ref = FirebaseDatabase.instance.ref();

  static Future<void> saveData(PostModel post,String path)async{
    String? key = ref.child(path).push().key;
    post.id = key;
    await ref.child(path).child(post.id!).set(post.toJson());
  }

  static Future<void> saveDataUni(UniModel uni,String path)async{
    String? key = ref.child(path).push().key;
    uni.id = key;
    await ref.child(path).child(uni.id!).set(uni.toJson());
  }

  static Future<void> saveDataTeachers(TeacherModel teacher,String path)async{
    String? key = ref.child(path).push().key;
    teacher.id = key;
    await ref.child(path).child(teacher.id!).set(teacher.toJson());
  }

  static Future<void> saveDataGrants(StudentGrantModel student)async{
    String? key = ref.child("students").child("grants_students").push().key;
    student.id = key;
    await ref.child("students").child("grants_students").child(student.id!).set(student.toJson());
  }

  static Future<void> saveDataContracts(StudentModel student)async{
    String? key = ref.child("students").child("contract_students").push().key;
    student.id = key;
    await ref.child("students").child("contract_students").child(student.id!).set(student.toJson());
  }

  static Future<List<PostModel>> getData(String path)async{
    List<PostModel> list = [];

    Query query = ref.child(path);
    DatabaseEvent event = await query.once();
    Iterable<DataSnapshot> data = event.snapshot.children;
    for (DataSnapshot e in data) {
      if(e!=null){
        list.add(PostModel.fromJson(Map<String, dynamic>.from(e.value as Map)));
      }
    }

    return list;
  }

  static Future<List<UniModel>> getDataUni(String path)async{
    List<UniModel> list = [];

    Query query = ref.child(path);
    DatabaseEvent event = await query.once();
    Iterable<DataSnapshot> data = event.snapshot.children;
    for (DataSnapshot e in data) {
      if(e!=null){
        list.add(UniModel.fromJson(Map<String, dynamic>.from(e.value as Map)));
      }
    }

    return list;
  }

  static Future<List<TeacherModel>> getDataTeachers(String path)async{
    List<TeacherModel> list = [];

    Query query = ref.child(path);
    DatabaseEvent event = await query.once();
    Iterable<DataSnapshot> data = event.snapshot.children;
    for (DataSnapshot e in data) {
      if(e!=null){
        list.add(TeacherModel.fromJson(Map<String, dynamic>.from(e.value as Map)));
      }
    }

    return list;
  }

  static Future<List<StudentGrantModel>> getDataGrants()async{
    List<StudentGrantModel> list = [];

    Query query = ref.child("students").child("grants_students");
    DatabaseEvent event = await query.once();
    Iterable<DataSnapshot> data = event.snapshot.children;
    for (DataSnapshot e in data) {
      if(e!=null){
        list.add(StudentGrantModel.fromJson(Map<String, dynamic>.from(e.value as Map)));
      }
    }

    return list;
  }

  static Future<List<StudentModel>> getDataContracts()async{
    List<StudentModel> list = [];

    Query query = ref.child("students").child("contract_students");
    DatabaseEvent event = await query.once();
    Iterable<DataSnapshot> data = event.snapshot.children;
    for (DataSnapshot e in data) {
      if(e!=null){
        list.add(StudentModel.fromJson(Map<String, dynamic>.from(e.value as Map)));
      }
    }

    return list;
  }


  static Future<void> updateData(PostModel post, String main, String path)async{
    await ref.child(main).child(post.id!).set(post.toJson());
  }

  static Future<void> updateDataUni(UniModel uni, String main)async{
    await ref.child(main).child(uni.id!).set(uni.toJson());
  }

  static Future<void> updateDataTeachers(TeacherModel teacher, String main)async{
    await ref.child(main).child(teacher.id!).set(teacher.toJson());
  }

  static Future<void> updateDataGrants(StudentGrantModel grant)async{
    await ref.child("students").child("grants_students").child(grant.id!).set(grant.toJson());
  }

  static Future<void> updateDataStudents(StudentModel grant)async{
    await ref.child("students").child("contract_students").child(grant.id!).set(grant.toJson());
  }

  static Future<void> deletePost(String main,String path)async{
    await ref.child(main).child(path).remove();
  }

  static Future<void> deleteDataStudents(StudentModel grant)async{
    await ref.child("students").child("contract_students").child(grant.id!).remove();
  }

  static Future<void> deleteDataGrants(StudentGrantModel grant)async{
    await ref.child("students").child("grants_students").child(grant.id!).remove();
  }

  static Future<void> deleteDataTeachers(TeacherModel teacher, String main)async{
    await ref.child(main).child(teacher.id!).remove();
  }

  static Future<void> deleteDataUni(UniModel uni, String main)async{
    await ref.child(main).child(uni.id!).remove();
  }
}