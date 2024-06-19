class UserModel {
  final String? comID;
  final String? comCode;
  final String? comName;
  final String? comimgimageLine;
  final String? comimgimageLogo;
  final String? comimgImageScreen;
  final String? comimgImageLogInScreen;

  UserModel({
    required this.comID,
    required this.comCode,
    required this.comName,
    required this.comimgimageLine,
    required this.comimgimageLogo,
    required this.comimgImageScreen,
    required this.comimgImageLogInScreen,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    print('++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++');
    print(json);
    return UserModel(
      comID: json['Com_ID'].toString(),
      comCode: json['Com_Code'],
      comName: json['Com_Name'],
      comimgimageLine: json['comimg_imageLine'],
      comimgimageLogo: json['comimg_imageLogo'],
      comimgImageScreen: json['comimg_ImageScreen'],
      comimgImageLogInScreen: json['comimg_ImageLogInScreen'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Com_ID': comID,
      'Com_Code': comCode,
      'Com_Name': comName,
      'comimg_imageLine': comimgimageLine,
      'comimg_imageLogo': comimgimageLogo,
      'comimg_ImageScreen': comimgImageScreen,
      'comimg_ImageLogInScreen': comimgImageLogInScreen,
    };
  }
}
