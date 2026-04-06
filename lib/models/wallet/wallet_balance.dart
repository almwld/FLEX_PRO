class WalletBalance {
  final double total;
  final double yerBalance;
  final double sarBalance;
  final double usdBalance;
  final double available;
  
  WalletBalance({
    required this.total,
    required this.yerBalance,
    required this.sarBalance,
    required this.usdBalance,
    this.available = 0,
  });
}
