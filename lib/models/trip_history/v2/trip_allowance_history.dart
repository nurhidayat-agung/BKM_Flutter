class TripAllowanceHistory {
  final String? id;
  final String? siteId;
  final String? doDetailId;
  final String? originalAmount;
  final String? amount;
  final String? saving;
  final String? transferredAmount;
  final String? status;

  TripAllowanceHistory({
    this.id,
    this.siteId,
    this.doDetailId,
    this.originalAmount,
    this.amount,
    this.saving,
    this.transferredAmount,
    this.status,
  });

  factory TripAllowanceHistory.fromJson(Map<String, dynamic> json) {
    return TripAllowanceHistory(
      id: json['id'],
      siteId: json['site_id'],
      doDetailId: json['do_detail_id'],
      originalAmount: json['original_amount'],
      amount: json['amount'],
      saving: json['saving'],
      transferredAmount: json['transferred_amount'],
      status: json['status'],
    );
  }
}
