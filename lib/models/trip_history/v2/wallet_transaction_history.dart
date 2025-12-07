class WalletTransactionHistory {
  final String? id;
  final String? walletId;
  final String? doDetailId;
  final String? type;
  final String? amount;
  final String? direction;
  final String? description;

  WalletTransactionHistory({
    this.id,
    this.walletId,
    this.doDetailId,
    this.type,
    this.amount,
    this.direction,
    this.description,
  });

  factory WalletTransactionHistory.fromJson(Map<String, dynamic> json) {
    return WalletTransactionHistory(
      id: json['id'],
      walletId: json['wallet_id'],
      doDetailId: json['do_detail_id'],
      type: json['type'],
      amount: json['amount'],
      direction: json['direction'],
      description: json['description'],
    );
  }
}
