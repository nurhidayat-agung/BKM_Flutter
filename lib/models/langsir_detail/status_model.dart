class StatusModel {
  final String? id;
  final String? name;
  final String? code;
  final String? description;
  final String? color;

  StatusModel({
    this.id,
    this.name,
    this.code,
    this.description,
    this.color,
  });

  factory StatusModel.fromJson(Map<String, dynamic> json) {
    return StatusModel(
      id: json['id'],
      name: json['name'],
      code: json['code'],
      description: json['description'],
      color: json['color'],
    );
  }
}
