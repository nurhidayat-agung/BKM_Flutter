import 'dart:io';

class LoadUnloadRequest {
  // DO Utama
  final String noDo;
  final String spb;
  final String tarra;
  final String bruto;
  final String netto;

  // Foto SPB Utama
  final File? fotoSpb;

  // DO Sambung (opsional)
  final String? noDoSambung;
  final String? spbSambung;
  final String? tarraSambung;
  final String? brutoSambung;
  final String? nettoSambung;

  LoadUnloadRequest({
    required this.noDo,
    required this.spb,
    required this.tarra,
    required this.bruto,
    required this.netto,
    this.fotoSpb,
    this.noDoSambung,
    this.spbSambung,
    this.tarraSambung,
    this.brutoSambung,
    this.nettoSambung,
  });
}
