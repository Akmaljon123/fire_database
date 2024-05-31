import 'dart:convert';

List<StudentGrantModel> studentGrantModelFromJson(String str) => List<StudentGrantModel>.from(json.decode(str).map((x) => StudentGrantModel.fromJson(x)));

String studentGrantModelToJson(List<StudentGrantModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StudentGrantModel {
  String name;
  String surname;
  String moduleName;
  int level;
  String? id;

  StudentGrantModel({
    required this.name,
    required this.surname,
    required this.moduleName,
    required this.level,
    this.id
  });

  StudentGrantModel copyWith({
    String? name,
    String? surname,
    String? moduleName,
    int? level,
    String? id
  }) =>
      StudentGrantModel(
        name: name ?? this.name,
        surname: surname ?? this.surname,
        moduleName: moduleName ?? this.moduleName,
        level: level ?? this.level,
        id: id
      );

  factory StudentGrantModel.fromJson(Map<String, dynamic> json) => StudentGrantModel(
    name: json["name"],
    surname: json["surname"],
    moduleName: json["moduleName"],
    level: json["level"],
    id: json["id"]
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "surname": surname,
    "moduleName": moduleName,
    "level": level,
    "id": id
  };
}
