class salesCustomer {
  final double custOID;
  final double custID;
  final double custYear;
  final double custYearSl;
  final DateTime custDate;
  final String custNumber;
  final String custName;
  final double custRefID;
  final String custRefCode;
  final String custRefName;
  final String custAddress;
  final String custContractPerson;
  final String custMobile;
  final String custBillingTypeCash;
  final String custBillingTypeCredit;
  final double custBillingCreditLimit;
  final String custMultipleProjectYn;
  final String custSingleProjectYn;
  final double custTypeId;
  final String custTypeCode;
  final String custTypeName;
  final String? custCategoryId;
  final String custCategoryCode;
  final String custCategoryName;
  final String custActive;
  final String custInActive;
  final DateTime custCDate;
  final DateTime custMDate;
  final String custCUID;
  final String custMUID;
  final double custComID;
  final String custComCode;
  final String custComName;
  final String? custReferenceYesNo;
  final String? pbRulesNo;
  final String? pbRulesTypeId;
  final String? pbRulesTypeCode;
  final String? pbRulesTypeName;
  final String? pbPrdBonusYesNo;
  final double teryID;
  final String teryCode;
  final String teryName;
  final double teryAreaID;
  final String teryAreaCode;
  final String teryAreaName;
  final double teryRegionID;
  final String teryRegionCode;
  final String teryRegionName;
  final double teryLevelId;
  final String teryLevelName;
  final double teryDepotID;
  final String teryDepotCode;
  final String teryDepotName;
  final double teryMarketTypeId;
  final String teryMarketTypeCode;
  final String teryMarketTypeName;
  final String srHrNo;
  final String srName;
  final String srDesignation;

  salesCustomer({
    required this.custOID,
    required this.custID,
    required this.custYear,
    required this.custYearSl,
    required this.custDate,
    required this.custNumber,
    required this.custName,
    required this.custRefID,
    required this.custRefCode,
    required this.custRefName,
    required this.custAddress,
    required this.custContractPerson,
    required this.custMobile,
    required this.custBillingTypeCash,
    required this.custBillingTypeCredit,
    required this.custBillingCreditLimit,
    required this.custMultipleProjectYn,
    required this.custSingleProjectYn,
    required this.custTypeId,
    required this.custTypeCode,
    required this.custTypeName,
    this.custCategoryId,
    required this.custCategoryCode,
    required this.custCategoryName,
    required this.custActive,
    required this.custInActive,
    required this.custCDate,
    required this.custMDate,
    required this.custCUID,
    required this.custMUID,
    required this.custComID,
    required this.custComCode,
    required this.custComName,
    this.custReferenceYesNo,
    this.pbRulesNo,
    this.pbRulesTypeId,
    this.pbRulesTypeCode,
    this.pbRulesTypeName,
    this.pbPrdBonusYesNo,
    required this.teryID,
    required this.teryCode,
    required this.teryName,
    required this.teryAreaID,
    required this.teryAreaCode,
    required this.teryAreaName,
    required this.teryRegionID,
    required this.teryRegionCode,
    required this.teryRegionName,
    required this.teryLevelId,
    required this.teryLevelName,
    required this.teryDepotID,
    required this.teryDepotCode,
    required this.teryDepotName,
    required this.teryMarketTypeId,
    required this.teryMarketTypeCode,
    required this.teryMarketTypeName,
    required this.srHrNo,
    required this.srName,
    required this.srDesignation,
  });

  factory salesCustomer.fromJson(Map<String, dynamic> json) {
    return salesCustomer(
      custOID: json['cust_OID'],
      custID: json['cust_ID'],
      custYear: json['cust_Year'],
      custYearSl: json['cust_YearSl'],
      custDate: DateTime.parse(json['cust_Date']),
      custNumber: json['cust_Number'],
      custName: json['cust_Name'],
      custRefID: json['cust_RefID'],
      custRefCode: json['cust_RefCode'],
      custRefName: json['cust_RefName'],
      custAddress: json['cust_Address'],
      custContractPerson: json['cust_ContractPerson'],
      custMobile: json['cust_Mobile'],
      custBillingTypeCash: json['cust_BillingTypeCash'],
      custBillingTypeCredit: json['cust_BillingTypeCredit'],
      custBillingCreditLimit: json['cust_BillingCreditLimit'],
      custMultipleProjectYn: json['cust_MultipleProjectYn'],
      custSingleProjectYn: json['cust_SingleProjectYn'],
      custTypeId: json['cust_TypeId'],
      custTypeCode: json['cust_TypeCode'],
      custTypeName: json['cust_TypeName'],
      custCategoryId: json['cust_CategoryId'],
      custCategoryCode: json['cust_CategoryCode'],
      custCategoryName: json['cust_CategoryName'],
      custActive: json['cust_Active'],
      custInActive: json['cust_InActive'],
      custCDate: DateTime.parse(json['cust_CDate']),
      custMDate: DateTime.parse(json['cust_MDate']),
      custCUID: json['cust_CUID'],
      custMUID: json['cust_MUID'],
      custComID: json['cust_ComID'],
      custComCode: json['cust_ComCode'],
      custComName: json['cust_ComName'],
      custReferenceYesNo: json['cust_ReferenceYesNo'],
      pbRulesNo: json['pb_RulesNo'],
      pbRulesTypeId: json['pb_RulesTypeId'],
      pbRulesTypeCode: json['pb_RulesTypeCode'],
      pbRulesTypeName: json['pb_RulesTypeName'],
      pbPrdBonusYesNo: json['pb_PrdBonusYesNo'],
      teryID: json['tery_ID'],
      teryCode: json['tery_Code'],
      teryName: json['tery_Name'],
      teryAreaID: json['tery_AreaID'],
      teryAreaCode: json['tery_AreaCode'],
      teryAreaName: json['tery_AreaName'],
      teryRegionID: json['tery_RegionID'],
      teryRegionCode: json['tery_RegionCode'],
      teryRegionName: json['tery_RegionName'],
      teryLevelId: json['tery_LevelId'],
      teryLevelName: json['tery_LevelName'],
      teryDepotID: json['tery_DepotID'],
      teryDepotCode: json['tery_DepotCode'],
      teryDepotName: json['tery_DepotName'],
      teryMarketTypeId: json['tery_MarketTypeId'],
      teryMarketTypeCode: json['tery_MarketTypeCode'],
      teryMarketTypeName: json['tery_MarketTypeName'],
      srHrNo: json['SrHrNo'],
      srName: json['SrName'],
      srDesignation: json['SrDesignation'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cust_OID': custOID,
      'cust_ID': custID,
      'cust_Year': custYear,
      'cust_YearSl': custYearSl,
      'cust_Date': custDate.toIso8601String(),
      'cust_Number': custNumber,
      'cust_Name': custName,
      'cust_RefID': custRefID,
      'cust_RefCode': custRefCode,
      'cust_RefName': custRefName,
      'cust_Address': custAddress,
      'cust_ContractPerson': custContractPerson,
      'cust_Mobile': custMobile,
      'cust_BillingTypeCash': custBillingTypeCash,
      'cust_BillingTypeCredit': custBillingTypeCredit,
      'cust_BillingCreditLimit': custBillingCreditLimit,
      'cust_MultipleProjectYn': custMultipleProjectYn,
      'cust_SingleProjectYn': custSingleProjectYn,
      'cust_TypeId': custTypeId,
      'cust_TypeCode': custTypeCode,
      'cust_TypeName': custTypeName,
      'cust_CategoryId': custCategoryId,
      'cust_CategoryCode': custCategoryCode,
      'cust_CategoryName': custCategoryName,
      'cust_Active': custActive,
      'cust_InActive': custInActive,
      'cust_CDate': custCDate.toIso8601String(),
      'cust_MDate': custMDate.toIso8601String(),
      'cust_CUID': custCUID,
      'cust_MUID': custMUID,
      'cust_ComID': custComID,
      'cust_ComCode': custComCode,
      'cust_ComName': custComName,
      'cust_ReferenceYesNo': custReferenceYesNo,
      'pb_RulesNo': pbRulesNo,
      'pb_RulesTypeId': pbRulesTypeId,
      'pb_RulesTypeCode': pbRulesTypeCode,
      'pb_RulesTypeName': pbRulesTypeName,
      'pb_PrdBonusYesNo': pbPrdBonusYesNo,
      'tery_ID': teryID,
      'tery_Code': teryCode,
      'tery_Name': teryName,
      'tery_AreaID': teryAreaID,
      'tery_AreaCode': teryAreaCode,
      'tery_AreaName': teryAreaName,
      'tery_RegionID': teryRegionID,
      'tery_RegionCode': teryRegionCode,
      'tery_RegionName': teryRegionName,
      'tery_LevelId': teryLevelId,
      'tery_LevelName': teryLevelName,
      'tery_DepotID': teryDepotID,
      'tery_DepotCode': teryDepotCode,
      'tery_DepotName': teryDepotName,
      'tery_MarketTypeId': teryMarketTypeId,
      'tery_MarketTypeCode': teryMarketTypeCode,
      'tery_MarketTypeName': teryMarketTypeName,
      'SrHrNo': srHrNo,
      'SrName': srName,
      'SrDesignation': srDesignation,
    };
  }
}
