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
  });

  factory TerritoryModel.fromJson(Map<String, dynamic> json) {
    // print('in jsonnnnnnnnnnnnnnnnnnnnnnnnnn');
    // print(json);
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
