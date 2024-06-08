import 'dart:convert';

class TerritoryDropDownlModel {
  final double teryID;
  final String teryCode;
  final String teryName;
  final String teryParentID;
  final String teryParentCode;
  final String teryParentName;

  TerritoryDropDownlModel({
    required this.teryID,
    required this.teryCode,
    required this.teryName,
    required this.teryParentID,
    required this.teryParentCode,
    required this.teryParentName,
  });

  factory TerritoryDropDownlModel.fromJson(Map<String, dynamic> json) {
    return TerritoryDropDownlModel(
      teryID: (json['tery_ID'] ?? 0).toDouble(),
      teryCode: json['tery_Code'] ?? '',
      teryName: json['tery_Name'] ?? '',
      teryParentID: json['tery_ParentID'] ?? '',
      teryParentCode: json['tery_ParentCode'] ?? '',
      teryParentName: json['tery_ParentName'] ?? '',
    );
  }
}

List<TerritoryDropDownlModel> parseTerritoryDropDownListFromJson(
    String jsonString) {
  final parsedJson = jsonDecode(jsonString);
  final List<dynamic> territoryListJson =
      parsedJson['Table']; // Assuming the key is 'Table'
  return territoryListJson
      .map((json) => TerritoryDropDownlModel.fromJson(json))
      .toList();
}
