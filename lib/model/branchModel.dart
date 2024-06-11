class Branch {
  final double? brnOID;
  final double? brnID;
  final String? brnCode;
  final String? brnName;
  final String? brnAddress1;
  final String? brnAddress2;
  final String? brnAddress3;
  final String? brnMob;
  final String? brnEmail;
  final String? brnFax;
  final String? brnWeb;
  final bool? brnSalesDepot;
  final bool? brnOthersDepot;
  final String? brnRemarks;
  final String? brnCreatedUID;
  final String? brnModifyUID;
  final String? brnCreatedDate;
  final String? brnModifyDate;
  final double? brnComID;
  final String? brnComCode;
  final String? brnComName;

  Branch({
    this.brnOID,
    this.brnID,
    this.brnCode,
    this.brnName,
    this.brnAddress1,
    this.brnAddress2,
    this.brnAddress3,
    this.brnMob,
    this.brnEmail,
    this.brnFax,
    this.brnWeb,
    this.brnSalesDepot,
    this.brnOthersDepot,
    this.brnRemarks,
    this.brnCreatedUID,
    this.brnModifyUID,
    this.brnCreatedDate,
    this.brnModifyDate,
    this.brnComID,
    this.brnComCode,
    this.brnComName,
  });

  factory Branch.fromJson(Map<String, dynamic> json) {
    return Branch(
      brnOID: (json['Brn_OID'] as num?)?.toDouble(),
      brnID: (json['Brn_ID'] as num?)?.toDouble(),
      brnCode: json['Brn_Code'] as String?,
      brnName: json['Brn_Name'] as String?,
      brnAddress1: json['Brn_Address1'] as String?,
      brnAddress2: json['Brn_Address2'] as String?,
      brnAddress3: json['Brn_Address3'] as String?,
      brnMob: json['Brn_Mob'] as String?,
      brnEmail: json['Brn_Email'] as String?,
      brnFax: json['Brn_Fax'] as String?,
      brnWeb: json['Brn_Web'] as String?,
      brnSalesDepot: json['Brn_SalesDepot'] == 'True',
      brnOthersDepot: json['Brn_OthersDepot'] == 'True',
      brnRemarks: json['Brn_Remarks'] as String?,
      brnCreatedUID: json['Brn_CreatedUID'] as String?,
      brnModifyUID: json['Brn_ModifyUID'] as String?,
      brnCreatedDate: json['Brn_CreatedDate'] as String?,
      brnModifyDate: json['Brn_ModifyDate'] as String?,
      brnComID: (json['Brn_ComID'] as num?)?.toDouble(),
      brnComCode: json['Brn_ComCode'] as String?,
      brnComName: json['Brn_ComName'] as String?,
    );
  }
}
