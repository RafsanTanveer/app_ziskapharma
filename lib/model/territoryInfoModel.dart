import 'dart:convert';

class TerritoryModel {
  final String userUID;
  final String teryCode;
  final String teryName;
  final String teryAreaCode;
  final String teryAreaName;
  final String teryRegionCode;
  final String teryRegionName;
  final String teryDepotCode;
  final String teryDepotName;

  final String muid;
  final double userComID;
  final String userComCode;
  final String userComName;
  final double userSysId;
  final String userCUID;
  final String teryStatus;

  TerritoryModel({
    required this.userUID,
    required this.teryCode,
    required this.teryName,
    required this.teryAreaCode,
    required this.teryAreaName,
    required this.teryRegionCode,
    required this.teryRegionName,
    required this.teryDepotCode,
    required this.teryDepotName,
    required this.muid,
    required this.userComID,
    required this.userComCode,
    required this.userComName,
    required this.userSysId,
    required this.userCUID,
    required this.teryStatus,
  });

  factory TerritoryModel.fromJson(Map<String, dynamic> json) {
    // print('in jsonnnnnnnnnnnnnnnnnnnnnnnnnn');
    // print(json); user_SysId
    return TerritoryModel(
      userUID: json['user_UID'] ?? '',
      teryCode: json['tery_Code'] ?? '',
      teryName: json['tery_Name'] ?? '',
      teryAreaCode: json['tery_AreaCode'] ?? '',
      teryAreaName: json['tery_AreaName'] ?? '',
      teryRegionCode: json['tery_RegionCode'] ?? '',
      teryRegionName: json['tery_RegionName'] ?? '',
      teryDepotCode: json['tery_DepotCode'] ?? '',
      teryDepotName: json['tery_DepotName'] ?? '',
      muid: json['user_MUID'] ?? '',
      userComID: json['user_ComID'].toDouble() ?? 0,
      userComCode: json['user_ComCode'] ?? '',
      userComName: json['user_ComName'] ?? '',
      userSysId: json['user_SysId'] ?? 0,
      userCUID: json['user_CUID'] ?? '',
      teryStatus: json['tery_Status'] ?? '',
    );
  }
}

TerritoryModel parseTerritoryFromJson(String jsonString) {
  // print('in sample fileffffffffffffffffffffffffffffffffffffff');
  final Map<String, dynamic> parsedJson = jsonDecode(jsonString);
  // print(parsedJson);
  final Map<String, dynamic> territoryJson = parsedJson['Table'][0];
  // print('teeeeeeeeeeeeeeeeeeeeeeeeeery');
  // print(userJson);
  print(territoryJson);
  return TerritoryModel.fromJson(territoryJson);
}
