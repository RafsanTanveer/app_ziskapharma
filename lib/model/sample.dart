import 'dart:convert';

class User {
  final double userOID;
  final double userID;
  final String userUID;
  final String userPws;

  final String userFullName;

  final double userComID;
  final String userComCode;
  final double userBrnID;

  final String userBrnCode;
  final String userBrnName;
  final String userDepartmentCode;

  final String userDepartment;

  final String muid;

  final String userDesignation;
  final String userMobileNo;
  final String userEmail;

  final String userImagePicture;
  final String userImageSignature;

  User({
    required this.userOID,
    required this.userID,
    required this.userUID,
    required this.userPws,
    required this.userFullName,
    required this.userComID,
    required this.userComCode,
    required this.userBrnID,
    required this.userBrnCode,
    required this.userBrnName,
    required this.userDepartmentCode,
    required this.userDepartment,
    required this.muid,
    required this.userDesignation,
    required this.userMobileNo,
    required this.userEmail,
    required this.userImagePicture,
    required this.userImageSignature,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        userOID: json['user_OID'].toDouble() ?? 0,
        userID: json['user_ID'].toDouble() ?? 0,
        userUID: json['user_UID'] ?? '',
        userPws: json['user_Pws'] ?? '',
        userFullName: json['user_FullName'] ?? '',
        userComID: json['user_ComID'].toDouble() ?? 0,
        userComCode: json['user_ComCode'] ?? '',
        userBrnID: json['user_BrnID'] ?? '',
        userBrnCode: json['user_BrnCode'] ?? '',
        userBrnName: json['user_BrnName'] ?? '',
        userDepartmentCode: json['user_DepartmentCode'] ?? '',
        userDepartment: json['user_Department'] ?? '',
        muid: json['user_MUID'] ?? '',
        userDesignation: json['user_Designation'] ?? '',
        userMobileNo: json['user_MobileNo'] ?? '',
        userEmail: json['user_Email'] ?? '',
        userImagePicture: json['user_imagePicture'] ?? '',
        userImageSignature: json['user_imageSignature'] ?? '');
  }
}

User parseUserFromJson(String jsonString) {
  final Map<String, dynamic> parsedJson = jsonDecode(jsonString);

  final Map<String, dynamic> userJson = parsedJson['Table'][0];
  return User.fromJson(userJson);
}
