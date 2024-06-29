class InvoiceModel {
  final double storeMainId;
  final String storeMainInvoiceNo;
  final String storeMainCustomerName;
  final double storeMainTotalPrdAmount;
  final double storeMainTotalDiscountAmount;
  final double storeMainTotalPrdAmountAfterDiscount;
  final double storeMainTotalVatAmount;
  final double storeMainTotalSpecialDiscountAmount;
  final double storeMainTotalBillAmount;

  InvoiceModel({
    required this.storeMainId,
    required this.storeMainInvoiceNo,
    required this.storeMainCustomerName,
    required this.storeMainTotalPrdAmount,
    required this.storeMainTotalDiscountAmount,
    required this.storeMainTotalPrdAmountAfterDiscount,
    required this.storeMainTotalVatAmount,
    required this.storeMainTotalSpecialDiscountAmount,
    required this.storeMainTotalBillAmount,
  });

  // Convert a StoreMain object into a Map object
  Map<String, dynamic> toJson() {
    return {
      'StoreMain_ID': storeMainId,
      'StoreMain_InvoiceNo': storeMainInvoiceNo,
      'StoreMain_CustomerName': storeMainCustomerName,
      'StoreMain_TotalPrdAmount': storeMainTotalPrdAmount,
      'StoreMain_TotalDiscountAmount': storeMainTotalDiscountAmount,
      'StoreMain_TotalPrdAmountAfterDiscount':
          storeMainTotalPrdAmountAfterDiscount,
      'StoreMain_TotalVatAmount': storeMainTotalVatAmount,
      'StoreMain_TotalSpecialDiscountAmount':
          storeMainTotalSpecialDiscountAmount,
      'StoreMain_TotalBillAmount': storeMainTotalBillAmount,
    };
  }

  // Create a StoreMain object from a Map object
  factory InvoiceModel.fromJson(Map<String, dynamic> json) {
    return InvoiceModel(
      storeMainId: json['StoreMain_ID'],
      storeMainInvoiceNo: json['StoreMain_InvoiceNo'],
      storeMainCustomerName: json['StoreMain_CustomerName'],
      storeMainTotalPrdAmount: json['StoreMain_TotalPrdAmount'],
      storeMainTotalDiscountAmount: json['StoreMain_TotalDiscountAmount'],
      storeMainTotalPrdAmountAfterDiscount:
          json['StoreMain_TotalPrdAmountAfterDiscount'],
      storeMainTotalVatAmount: json['StoreMain_TotalVatAmount'],
      storeMainTotalSpecialDiscountAmount:
          json['StoreMain_TotalSpecialDiscountAmount'],
      storeMainTotalBillAmount: json['StoreMain_TotalBillAmount'],
    );
  }
}
