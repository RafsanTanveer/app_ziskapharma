class CustomerCategory {
  // final double cpOID;
  final double cpID;
  final String cpCode;
  final String cpName;
  // final bool cpReferenceYes;
  // final bool cpReferenceNo;
  // final String? cpNote;
  // final String cpCUID;
  // final String cpMUID;
  // final DateTime cpCDate;
  // final DateTime cpMDate;
  // final double cpComID;
  // final String cpComCode;
  // final String cpComName;
  // final String cNewCustomer;

  CustomerCategory({
    // required this.cpOID,
    required this.cpID,
    required this.cpCode,
    required this.cpName,
    // required this.cpReferenceYes,
    // required this.cpReferenceNo,
    // this.cpNote,
    // required this.cpCUID,
    // required this.cpMUID,
    // required this.cpCDate,
    // required this.cpMDate,
    // required this.cpComID,
    // required this.cpComCode,
    // required this.cpComName,
    // required this.cNewCustomer,
  });

  factory CustomerCategory.fromJson(Map<String, dynamic> json) {
    return CustomerCategory(
      // cpOID: json['cp_OID'],
      cpID: json['cp_ID'],
      cpCode: json['cp_Code'],
      cpName: json['cp_Name'],
      // cpReferenceYes: json['cp_ReferenceYes'].toLowerCase() == 'true',
      // cpReferenceNo: json['cp_ReferenceNo'].toLowerCase() == 'true',
      // cpNote: json['cp_Note'],
      // cpCUID: json['cp_CUID'],
      // cpMUID: json['cp_MUID'],
      // cpCDate: DateTime.parse(json['cp_CDate']),
      // cpMDate: DateTime.parse(json['cp_MDate']),
      // cpComID: json['cp_ComID'],
      // cpComCode: json['cp_ComCode'],
      // cpComName: json['cp_ComName'],
      // cNewCustomer: json['cNewCustomer'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // 'cp_OID': cpOID,
      'cp_ID': cpID,
      'cp_Code': cpCode,
      'cp_Name': cpName,
      // 'cp_ReferenceYes': cpReferenceYes.toString(),
      // 'cp_ReferenceNo': cpReferenceNo.toString(),
      // 'cp_Note': cpNote,
      // 'cp_CUID': cpCUID,
      // 'cp_MUID': cpMUID,
      // 'cp_CDate': cpCDate.toIso8601String(),
      // 'cp_MDate': cpMDate.toIso8601String(),
      // 'cp_ComID': cpComID,
      // 'cp_ComCode': cpComCode,
      // 'cp_ComName': cpComName,
      // 'cNewCustomer': cNewCustomer,
    };
  }
}
