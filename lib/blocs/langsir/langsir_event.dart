import 'dart:io';
import 'package:equatable/equatable.dart';

abstract class LangsirEvent extends Equatable {
  const LangsirEvent();

  @override
  List<Object?> get props => [];
}

class FetchLangsirList extends LangsirEvent {}

class FetchLangsirDetail extends LangsirEvent {
  final String id;
  const FetchLangsirDetail(this.id);

  @override
  List<Object?> get props => [id];
}

class SaveLangsirMuat extends LangsirEvent {
  final String id;
  final String jumlahMuat;
  final String tanggalMuat;
  final String actionButton;
  final File? photoMuat;

  const SaveLangsirMuat({
    required this.id,
    required this.jumlahMuat,
    required this.tanggalMuat,
    required this.actionButton,
    this.photoMuat,
  });

  @override
  List<Object?> get props => [id, jumlahMuat, tanggalMuat, actionButton, photoMuat];
}

class SaveLangsirBongkar extends LangsirEvent {
  final String id;
  final String jumlahBongkar;
  final String tanggalBongkar;
  final String actionButton;
  final File? photoBongkar;

  const SaveLangsirBongkar({
    required this.id,
    required this.jumlahBongkar,
    required this.tanggalBongkar,
    required this.actionButton,
    this.photoBongkar,
  });

  @override
  List<Object?> get props => [id, jumlahBongkar, tanggalBongkar, actionButton, photoBongkar];
}
