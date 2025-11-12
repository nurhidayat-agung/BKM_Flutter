import '../login_local.dart';
import 'UserSession.dart';

class LoginResp {
  int? status;
  String? message;
  String? userId;
  String? token;
  String? firebaseToken;

  LoginResp({
    this.status,
    this.message,
    this.userId,
    this.token,
    this.firebaseToken
  });

  LoginResp.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    userId = json['user_id'];
    token = json['token'];
    firebaseToken = json['firebase_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = this.status;
    data['message'] = this.message;
    data['user_id'] = this.userId;
    data['token'] = this.token;
    data['firebase_token'] = this.firebaseToken;
    return data;
  }

  LoginLocal toLocal() {
    return LoginLocal(
      status: status ?? 0,
      message: message ?? "",
      userId: userId ?? "",
      token: token ?? "",
      firebaseToken: firebaseToken ?? "",
    );
  }
}
