import 'dart:convert';

class UserPreferences {
  String userUID;
  String userFullName;
  double userBrnID;
  String userBrnCode;
  String userBrnName;
  String userImagePicture;
  double teryID;
  String teryCode;
  String teryName;
  double teryAreaId;
  String teryAreaCode;
  String teryAreaName;
  String teryRegionCode;
  String teryRegionName;
  String teryMarketTypeCode;

  UserPreferences({
    required this.userUID,
    required this.userFullName,
    required this.userBrnID,
    required this.userBrnCode,
    required this.userBrnName,
    required this.userImagePicture,
    required this.teryID,
    required this.teryCode,
    required this.teryName,
    required this.teryAreaId,
    required this.teryAreaCode,
    required this.teryAreaName,
    required this.teryRegionCode,
    required this.teryRegionName,
    required this.teryMarketTypeCode,
  });

  Map<String, dynamic> toJson() {
    return {
      'user_UID': userUID,
      'user_FullName': userFullName,
      'user_BrnID': userBrnID,
      'user_BrnCode': userBrnCode,
      'user_BrnName': userBrnName,
      'user_ImagePicture': userImagePicture,
      'tery_ID': teryID,
      'tery_Code': teryCode,
      'tery_Name': teryName,
      'tery_AreaId': teryAreaId,
      'tery_AreaCode': teryAreaCode,
      'tery_AreaName': teryAreaName,
      'tery_RegionCode': teryRegionCode,
      'tery_RegionName': teryRegionName,
      'tery_MarketTypeCode': teryMarketTypeCode,
    };
  }

  factory UserPreferences.fromJson(Map<String, dynamic> map) {
    return UserPreferences(
      userUID: map['user_UID'] ?? '',
      userFullName: map['user_FullName'] ?? '',
      userBrnID: (map['user_BrnID'] as num?)?.toDouble() ?? 0,
      userBrnCode: map['user_BrnCode'] ?? '',
      userBrnName: map['user_BrnName'] ?? '',
      userImagePicture: map['user_ImagePicture'] ?? '',
      teryID: (map['tery_ID'] as num?)?.toDouble() ?? 0,
      teryCode: map['tery_Code'] ?? '',
      teryName: map['tery_Name'] ?? '',
      teryAreaId: (map['tery_AreaId'] as num?)?.toDouble() ?? 0,
      teryAreaCode: map['tery_AreaCode'] ?? '',
      teryAreaName: map['tery_AreaName'] ?? '',
      teryRegionCode: map['tery_RegionCode'] ?? '',
      teryRegionName: map['tery_RegionName'] ?? '',
      teryMarketTypeCode: map['tery_MarketTypeCode'] ?? '',
    );
  }
}
