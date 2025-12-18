class LocalHaulingCommodity {
  final String? id;
  final String? code;
  final String? name;
  final String? description;
  final int? isActive;

  LocalHaulingCommodity({
    this.id,
    this.code,
    this.name,
    this.description,
    this.isActive,
  });

  factory LocalHaulingCommodity.fromJson(Map<String, dynamic> json) {
    return LocalHaulingCommodity(
      id: json['id'],
      code: json['code'],
      name: json['name'],
      description: json['description'],
      isActive: json['is_active'],
    );
  }
}
