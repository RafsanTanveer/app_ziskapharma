class Branch {
  final double oid;
  final double id;
  final String code;
  final String name;
  final String address1;
  final String? address2;
  final String? address3;
  final String mobile;
  final String? email;
  final String? fax;
  final String? web;
  final bool isSalesDepot;
  final bool isOthersDepot;
  final String? remarks;
  final String? createdUID;
  final String modifyUID;
  final DateTime? createdDate;
  final DateTime modifyDate;
  final double comID;
  final String comCode;
  final String comName;

  Branch({
    required this.oid,
    required this.id,
    required this.code,
    required this.name,
    required this.address1,
    this.address2,
    this.address3,
    required this.mobile,
    this.email,
    this.fax,
    this.web,
    required this.isSalesDepot,
    required this.isOthersDepot,
    this.remarks,
    this.createdUID,
    required this.modifyUID,
    this.createdDate,
    required this.modifyDate,
    required this.comID,
    required this.comCode,
    required this.comName,
  });

  factory Branch.fromJson(Map<String, dynamic> json) {
    return Branch(
      oid: json['Brn_OID'],
      id: json['Brn_ID'],
      code: json['Brn_Code'],
      name: json['Brn_Name'],
      address1: json['Brn_Address1'],
      address2: json['Brn_Address2'],
      address3: json['Brn_Address3'],
      mobile: json['Brn_Mob'],
      email: json['Brn_Email'],
      fax: json['Brn_Fax'],
      web: json['Brn_Web'],
      isSalesDepot: json['Brn_SalesDepot'].toString().toLowerCase() == 'true',
      isOthersDepot: json['Brn_OthersDepot'].toString().toLowerCase() == 'true',
      remarks: json['Brn_Remarks'],
      createdUID: json['Brn_CreatedUID'],
      modifyUID: json['Brn_ModifyUID'],
      createdDate: json['Brn_CreatedDate'] != null
          ? DateTime.parse(json['Brn_CreatedDate'])
          : null,
      modifyDate: DateTime.parse(json['Brn_ModifyDate']),
      comID: json['Brn_ComID'],
      comCode: json['Brn_ComCode'],
      comName: json['Brn_ComName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Brn_OID': oid,
      'Brn_ID': id,
      'Brn_Code': code,
      'Brn_Name': name,
      'Brn_Address1': address1,
      'Brn_Address2': address2,
      'Brn_Address3': address3,
      'Brn_Mob': mobile,
      'Brn_Email': email,
      'Brn_Fax': fax,
      'Brn_Web': web,
      'Brn_SalesDepot': isSalesDepot.toString(),
      'Brn_OthersDepot': isOthersDepot.toString(),
      'Brn_Remarks': remarks,
      'Brn_CreatedUID': createdUID,
      'Brn_ModifyUID': modifyUID,
      'Brn_CreatedDate': createdDate?.toIso8601String(),
      'Brn_ModifyDate': modifyDate.toIso8601String(),
      'Brn_ComID': comID,
      'Brn_ComCode': comCode,
      'Brn_ComName': comName,
    };
  }
}
