class DoctorListModel {
  final double custID;
  final String custNumber;
  final String custName;
  final String custMobile;
  final String custAddress;

  final String custContractPerson;
  final double teryDepotID;
  final String teryDepotCode;
  final String teryDepotName;
  final String custRefCode;
  final String custRefName;
  final String CustomerName;
  final String SalesOrder;

  DoctorListModel({
    required this.custID,
    required this.custNumber,
    required this.custName,
    required this.custMobile,
    required this.custAddress,
    required this.custContractPerson,
    required this.teryDepotID,
    required this.teryDepotCode,
    required this.teryDepotName,
    required this.custRefCode,
    required this.custRefName,
    required this.CustomerName,
    required this.SalesOrder,
  });

  factory DoctorListModel.fromJson(Map<String, dynamic> json) {
    return DoctorListModel(
      custID: json['cust_ID'],
      custNumber: json['cust_Number'],
      custName: json['cust_Name'],
      custMobile: json['cust_Mobile'],
      custAddress: json['cust_Address'],
      custContractPerson: json['cust_ContractPerson'],
      teryDepotID: json['tery_DepotID'],
      teryDepotCode: json['tery_DepotCode'],
      teryDepotName: json['tery_DepotName'],
      custRefCode: json['cust_RefCode'],
      custRefName: json['cust_RefName'],
      CustomerName: json['CustomerName'],
      SalesOrder: json['SalesOrder'],
    );
  }
}
