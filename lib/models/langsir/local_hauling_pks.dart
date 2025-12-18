class LocalHaulingPks {
  final String? id;
  final String? siteId;
  final String? code;
  final String? name;
  final String? address;
  final String? description;
  final int? isActive;

  LocalHaulingPks({
    this.id,
    this.siteId,
    this.code,
    this.name,
    this.address,
    this.description,
    this.isActive,
  });

  factory LocalHaulingPks.fromJson(Map<String, dynamic> json) {
    return LocalHaulingPks(
      id: json['id'],
      siteId: json['site_id'],
      code: json['code'],
      name: json['name'],
      address: json['address'],
      description: json['description'],
      isActive: json['is_active'],
    );
  }
}
