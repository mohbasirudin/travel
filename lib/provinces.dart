import 'dart:convert';

class ModelProvince {
  final String id;
  final String name;

  ModelProvince({
    required this.id,
    required this.name,
  });

  factory ModelProvince.fromRawJson(String str) =>
      ModelProvince.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ModelProvince.fromJson(Map<String, dynamic> json) => ModelProvince(
        id: json["id"] ?? "",
        name: json["name"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
