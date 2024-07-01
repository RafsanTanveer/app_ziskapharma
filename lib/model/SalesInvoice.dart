class SalesInvoiceList {
  final String invoiceNo;
  final String invoiceDate;
  final String customerName;
  final double totalBillAmount;
  final String CustomerAdd;
  final String MobileNo;

  SalesInvoiceList(
      {required this.invoiceNo,
      required this.invoiceDate,
      required this.customerName,
      required this.totalBillAmount,
      required this.CustomerAdd,
      required this.MobileNo});

  factory SalesInvoiceList.fromJson(Map<String, dynamic> json) {
    return SalesInvoiceList(
      invoiceNo: json['StoreMain_InvoiceNo'],
      invoiceDate: json['StoreMain_InvoiceDate'],
      customerName: json['StoreMain_CustomerName'],
      totalBillAmount: json['StoreMain_TotalBillAmount'],
      CustomerAdd: json['StoreMain_CustomerAdd'],
      MobileNo: json['StoreMain_MobileNo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'StoreMain_InvoiceNo': invoiceNo,
      'StoreMain_InvoiceDate': invoiceDate,
      'StoreMain_CustomerName': customerName,
      'StoreMain_TotalBillAmount': totalBillAmount,
      "StoreMain_CustomerAdd": CustomerAdd,
      "StoreMain_MobileNo": MobileNo
    };
  }
}
