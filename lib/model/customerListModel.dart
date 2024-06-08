class CustomerListModel {
  final double custID;
  final String custNumber;
  final String customerName;
  final String custMobile;
  final String custAddress;

  CustomerListModel({
    required this.custID,
    required this.custNumber,
    required this.customerName,
    required this.custMobile,
    required this.custAddress,
  });

  factory CustomerListModel.fromJson(Map<String, dynamic> json) {
    return CustomerListModel(
      custID: json['cust_ID'],
      custNumber: json['cust_Number'],
      customerName: json['cust_Name'],
      custMobile: json['cust_Mobile'],
      custAddress: json['cust_Address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cust_ID': custID,
      'cust_Number': custNumber,
      'cust_Name': customerName,
      'cust_Mobile': custMobile,
      'cust_Address': custAddress,
    };
  }
}
