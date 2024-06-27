class CustomerListModel {
  final double custID;
  final String custNumber;
  final String customerName;
  final String custMobile;
  final String custAddress;
  final String custRef;
  final String custRefCode;
  final String contactPerson;

  // final String custAddress1;
  // final String teryCode;
  // final String teryDepotId;
  // final String teryDepotCode;
  // final String teryDepotName;
  // final String custActive;
  // final String custCUID;

  CustomerListModel({
    required this.custID,
    required this.custNumber,
    required this.customerName,
    required this.custMobile,
    required this.custAddress,
    required this.custRef,
    required this.custRefCode,
    required this.contactPerson,


// required this.custAddress1,
// required this.teryCode,
// required this.teryDepotId,
// required this.teryDepotCode,
//     required this.teryDepotName,
// required this.custActive,
// required this.custCUID,


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
      contactPerson: json['cust_ContractPerson'],

      // custAddress1: json['cust_Address1'],
      // teryCode: json['tery_Code'],
      // teryDepotId: json['tery_DepotID'],
      // teryDepotCode: json['tery_DepotCode'],
      // teryDepotName: json['tery_DepotName'],
      // custActive: json['cust_Active'],
      // custCUID: json['cust_CUID'],





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
      'cust_ContractPerson': contactPerson,


      // 'cust_Address1': custAddress1,
      // 'tery_Code': teryCode,
      // 'tery_DepotID': teryDepotId,
      // 'tery_DepotCode': teryDepotCode,
      // 'tery_DepotName': teryDepotName,
      // 'cust_Active': custActive,
      // 'cust_CUID': custCUID,


    };
  }
}
