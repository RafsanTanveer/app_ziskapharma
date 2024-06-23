class CustomerListModel {
  final double custID;
  final String custNumber;
  final String customerName;
  final String custMobile;
  final String custAddress;
  final String custRef;
  final String custRefCode;

  CustomerListModel({
    required this.custID,
    required this.custNumber,
    required this.customerName,
    required this.custMobile,
    required this.custAddress,
    required this.custRef,
    required this.custRefCode,
  });

  factory CustomerListModel.fromJson(Map<String, dynamic> json) {
    return CustomerListModel(
      custID: json['cust_ID'],
      custNumber: json['cust_Number'],
      customerName: json['cust_Name'],
      custMobile: json['cust_Mobile'],
      custAddress: json['cust_Address'],
      custRef: json['cust_RefName'],
      custRefCode: json['cust_RefCode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cust_ID': custID,
      'cust_Number': custNumber,
      'cust_Name': customerName,
      'cust_Mobile': custMobile,
      'cust_Address': custAddress,
      'cust_RefCode': custRefCode,
      'cust_RefName': custRef,
    };
  }
}
