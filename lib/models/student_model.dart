import 'dart:convert';

List<StudentModel> studentModelFromJson(String str) => List<StudentModel>.from(json.decode(str).map((x) => StudentModel.fromJson(x)));

String studentModelToJson(List<StudentModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StudentModel {
  String name;
  String surname;
  String moduleName;
  int level;
  int contract;
  String? id;

  StudentModel({
    required this.name,
    required this.surname,
    required this.moduleName,
    required this.level,
    required this.contract,
    this.id
  });

  StudentModel copyWith({
    String? name,
    String? surname,
    int? salary,
    String? moduleName,
    int? level,
    int? contract,
    String? id
  }) =>
      StudentModel(
        name: name ?? this.name,
        surname: surname ?? this.surname,
        moduleName: moduleName ?? this.moduleName,
        level: level ?? this.level,
        contract: contract ?? this.contract,
        id: id
      );

  factory StudentModel.fromJson(Map<String, dynamic> json) => StudentModel(
    name: json["name"],
    surname: json["surname"],
    moduleName: json["moduleName"],
    level: json["level"],
    contract: json["contract"],
    id: json["id"]
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "surname": surname,
    "moduleName": moduleName,
    "level": level,
    "contract": contract,
    "id": id
  };
}
