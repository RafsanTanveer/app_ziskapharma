class Product {
  final String finPrdCode;
  final String finPrdName;
  final String finPrdPackSize;
  final double finPrdTradePrice;

  Product({
    required this.finPrdCode,
    required this.finPrdName,
    required this.finPrdPackSize,
    required this.finPrdTradePrice,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      finPrdCode: json['finPrd_Code'] ?? '',
      finPrdName: json['finPrd_Name'] ?? '',
      finPrdPackSize: json['finPrd_PackSize'] ?? '',
      finPrdTradePrice: (json['finPrd_TradePrice'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
