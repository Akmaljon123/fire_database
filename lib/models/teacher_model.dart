import 'dart:convert';

List<TeacherModel> teacherModelFromJson(String str) => List<TeacherModel>.from(json.decode(str).map((x) => TeacherModel.fromJson(x)));

String teacherModelToJson(List<TeacherModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TeacherModel {
  String name;
  String surname;
  int salary;
  String moduleName;
  String level;
  String? id;

  TeacherModel({
    required this.name,
    required this.surname,
    required this.salary,
    required this.moduleName,
    required this.level,
    this.id
  });

  TeacherModel copyWith({
    String? name,
    String? surname,
    int? salary,
    String? moduleName,
    String? level,
  }) =>
      TeacherModel(
        name: name ?? this.name,
        surname: surname ?? this.surname,
        salary: salary ?? this.salary,
        moduleName: moduleName ?? this.moduleName,
        level: level ?? this.level,
        id: id
      );

  factory TeacherModel.fromJson(Map<String, dynamic> json) => TeacherModel(
    name: json["name"],
    surname: json["surname"],
    salary: json["salary"],
    moduleName: json["moduleName"],
    level: json["level"],
    id: json["id"]
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "surname": surname,
    "salary": salary,
    "moduleName": moduleName,
    "level": level,
    "id": id
  };
}
