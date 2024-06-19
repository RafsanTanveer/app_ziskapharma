class Product {
  final String finPrdCode;
  final String finPrdName;
  final String finPrdPackSize;
  final int orderQnty;

  Product({
    required this.finPrdCode,
    required this.finPrdName,
    required this.finPrdPackSize,
    required this.orderQnty,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      finPrdCode: json['finPrd_Code'],
      finPrdName: json['finPrd_Name'],
      finPrdPackSize: json['finPrd_PackSize'],
      orderQnty: json['OrderQnty'],
    );
  }
}
