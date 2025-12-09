class UserData {
  String? id;
  String? roleId;
  String? name;
  String? phone;
  String? email;
  String? emailVerifiedAt;
  String? password;
  String? platform;
  String? firebaseToken;
  String? lastLoginAt;
  String? createdAt;
  String? updatedAt;

  UserData({
    this.id,
    this.roleId,
    this.name,
    this.phone,
    this.email,
    this.emailVerifiedAt,
    this.password,
    this.platform,
    this.firebaseToken,
    this.lastLoginAt,
    this.createdAt,
    this.updatedAt,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    id: json["id"],
    roleId: json["role_id"],
    name: json["name"],
    phone: json["phone"],
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"],
    password: json["password"],
    platform: json["platform"],
    firebaseToken: json["firebase_token"],
    lastLoginAt: json["last_login_at"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );
}