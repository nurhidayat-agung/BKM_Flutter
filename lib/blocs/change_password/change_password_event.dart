part of 'change_password_bloc.dart';

abstract class ChangePasswordEvent extends Equatable {
  const ChangePasswordEvent();
}

class ChangePassword extends ChangePasswordEvent {
  final String oldPassword;
  final String newPassword;
  final String confirmPassword;

  const ChangePassword({
    required this.oldPassword,
    required this.newPassword,
    required this.confirmPassword,
  });

  @override
  List<Object> get props => [oldPassword, newPassword, confirmPassword];

  @override
  String toString() => "ChangePassword { oldPassword: $oldPassword, newPassword: $newPassword, confirmPassword: $confirmPassword }";
}