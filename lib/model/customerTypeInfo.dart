class CustomerTypeInfo {
  final double cpOID;
  final double cpID;
  final String cpCode;
  final String cpName;
  final String cpReferenceYes;
  final String cpReferenceNo;
  final String? cpNote;
  final String cpCUID;
  final String cpMUID;
  final DateTime cpCDate;
  final DateTime cpMDate;
  final double cpComID;
  final String cpComCode;
  final String cpComName;

  CustomerTypeInfo({
    required this.cpOID,
    required this.cpID,
    required this.cpCode,
    required this.cpName,
    required this.cpReferenceYes,
    required this.cpReferenceNo,
    this.cpNote,
    required this.cpCUID,
    required this.cpMUID,
    required this.cpCDate,
    required this.cpMDate,
    required this.cpComID,
    required this.cpComCode,
    required this.cpComName,
  });

  factory CustomerTypeInfo.fromJson(Map<String, dynamic> json) {
    return CustomerTypeInfo(
      cpOID: json['cp_OID'] ?? 0,
      cpID: json['cp_ID'] ?? 0,
      cpCode: json['cp_Code'] ?? '',
      cpName: json['cp_Name'] ?? '',
      cpReferenceYes: json['cp_ReferenceYes'] ?? '',
      cpReferenceNo: json['cp_ReferenceNo'] ?? '',
      cpNote: json['cp_Note'] ?? '',
      cpCUID: json['cp_CUID'] ?? '',
      cpMUID: json['cp_MUID'] ?? '',
      cpCDate: DateTime.parse(json['cp_CDate']),
      cpMDate: DateTime.parse(json['cp_MDate']),
      cpComID: json['cp_ComID'] ?? '',
      cpComCode: json['cp_ComCode'] ?? '',
      cpComName: json['cp_ComName'] ?? '',
    );
  }
}
