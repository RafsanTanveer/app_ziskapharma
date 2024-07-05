class DoctorListModel2 {
  final String cDelete;
  final double custID;
  final String custNumber;
  final String custName;
  final String custMobile;
  final String custAddress;
  final String custAddress1;
  final String teryCode;
  final double teryDepotId;
  final String teryDepotCode;
  final String teryDepotName;
  final String custActive;
  final String custCUID;

  DoctorListModel2({
    required this.cDelete,
    required this.custID,
    required this.custNumber,
    required this.custName,
    required this.custMobile,
    required this.custAddress,
    required this.custAddress1,
    required this.teryCode,
    required this.teryDepotId,
    required this.teryDepotCode,
    required this.teryDepotName,
    required this.custActive,
    required this.custCUID,
  });

  factory DoctorListModel2.fromJson(Map<String, dynamic> json) {
    return DoctorListModel2(
      cDelete: json['cDelete'] ?? "",
      custID: (json['cust_ID'] ?? 0).toDouble(),
      custNumber: json['cust_Number'] ?? "",
      custName: json['cust_Name'] ?? "",
      custMobile: json['cust_Mobile'] ?? "",
      custAddress: json['cust_Address'] ?? "",
      custAddress1: json['cust_Address1'] ?? "",
      teryCode: json['tery_Code'] ?? "",
      teryDepotId: (json['tery_DepotID'] ?? 0).toDouble(),
      teryDepotCode: json['tery_DepotCode'] ?? "",
      teryDepotName: json['tery_DepotName'] ?? "",
      custActive: json['cust_Active'] ?? "",
      custCUID: json['cust_CUID'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cDelete': cDelete,
      'cust_ID': custID,
      'cust_Number': custNumber,
      'cust_Name': custName,
      'cust_Mobile': custMobile,
      'cust_Address': custAddress,
      'cust_Address1': custAddress1,
      'tery_Code': teryCode,
      'tery_DepotID': teryDepotId,
      'tery_DepotCode': teryDepotCode,
      'tery_DepotName': teryDepotName,
      'cust_Active': custActive,
      'cust_CUID': custCUID,
    };
  }
}
