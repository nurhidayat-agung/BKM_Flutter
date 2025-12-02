class LangsirItem {
  final String id;
  final String doNumber;
  final String route;
  final String tanggal;

  LangsirItem({
    required this.id,
    required this.doNumber,
    required this.route,
    required this.tanggal,
  });
}

class LangsirDetail {
  final String id;
  final String route;
  final String komoditi;
  final String noDoBesar;
  final String noDoKecil;
  final String namaSupir;
  final String noKendaraan;
  final List<Map<String, dynamic>> muat;
  final List<Map<String, dynamic>> bongkar;

  LangsirDetail({
    required this.id,
    required this.route,
    required this.komoditi,
    required this.noDoBesar,
    required this.noDoKecil,
    required this.namaSupir,
    required this.noKendaraan,
    required this.muat,
    required this.bongkar,
  });
}
