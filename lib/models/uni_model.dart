class UniModel {
  String? name;
  String? url;
  String? year;
  String? location;
  String? desc;
  String? id;

  UniModel({
    this.name,
    this.url,
    this.year,
    this.location,
    this.desc,
    this.id,
  });

  UniModel.fromJson(Map<String, dynamic> json) {
    name = json["name"] ?? ''; // Provide default value if null
    url = json["url"] ?? '';   // Provide default value if null
    year = json["year"] ?? ''; // Provide default value if null
    location = json["location"] ?? ''; // Provide default value if null
    desc = json["desc"] ?? ''; // Provide default value if null
    id = json["id"];
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "url": url,
      "year": year,
      "location": location,
      "desc": desc,
      "id": id,
    };
  }

  UniModel copyWith({
    String? name,
    String? url,
    String? year,
    String? location,
    String? desc,
    String? id,
  }) {
    return UniModel(
      name: name ?? this.name,
      url: url ?? this.url,
      year: year ?? this.year,
      location: location ?? this.location,
      desc: desc ?? this.desc,
      id: id ?? this.id,
    );
  }
}
