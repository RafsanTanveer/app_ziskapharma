import 'dart:typed_data';

import 'package:app_ziskapharma/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'dart:convert';
import '../model/sample.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../dataaccess/apiAccess.dart' as apiAccess;

import '../custom_widgets/textFormField.dart';

class Userinfoscreen extends HookWidget {
  const Userinfoscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthProvider>(context, listen: false);
    final userData = useState<User?>(null);
    final snapData = useState<String?>(null);
    final signatureData = useState<String?>(null);

///////////////////////////  TextField Contrllers  ///////////////////////////////////////////////

    TextEditingController userIdController =
        TextEditingController(text: userData.value?.userUID ?? "");
    TextEditingController passwordController =
        TextEditingController(text: userData.value?.userPws ?? "");
    TextEditingController fullNameController =
        TextEditingController(text: userData.value?.userFullName ?? "");
    TextEditingController userDesignationController =
        TextEditingController(text: userData.value?.userDesignation ?? "");
    TextEditingController userMobileNoController =
        TextEditingController(text: userData.value?.userMobileNo ?? "");
    TextEditingController userEmailController =
        TextEditingController(text: userData.value?.userEmail ?? "");
    TextEditingController userDepartmentController =
        TextEditingController(text: userData.value?.userDepartment ?? "");
    TextEditingController userDepartmentCodeController =
        TextEditingController(text: userData.value?.userDepartmentCode ?? "");
    TextEditingController userBrnCodeController =
        TextEditingController(text: userData.value?.userBrnCode ?? "");
    TextEditingController userBrnNameController =
        TextEditingController(text: userData.value?.userBrnName ?? "");

///////////////////////////  TextField Contrllers  ///////////////////////////////////////////////

    Future<void> _submitPost() async {
      final url = Uri.parse('${apiAccess.apiBaseUrl}/UserInfo/Proc_SaveByApi');
      final headers = {"Content-Type": "application/json"};

      // Create the JSON payload
      final payload = json.encode({
        "UserTable": [
          {
            "user_ID": userData.value!.userID,
            "user_UID": userIdController.text,
            "user_Pws": passwordController.text,
            "user_FullName": fullNameController.text.isEmpty
                ? userData.value!.userFullName
                : fullNameController.text,
            "user_Department": userDepartmentController.text.isEmpty
                ? userData.value!.userDepartment
                : userDepartmentController.text,
            "user_DepartmentCode": userDepartmentCodeController.text.isEmpty
                ? userData.value!.userDepartmentCode
                : userDepartmentCodeController.text,
            "user_Designation": userDesignationController.text.isEmpty
                ? userData.value!.userDesignation
                : userDesignationController.text,
            "user_MobileNo": userMobileNoController.text.isEmpty
                ? userData.value!.userMobileNo
                : userMobileNoController.text,
            "user_Email": userEmailController.text.isEmpty
                ? userData.value!.userEmail
                : userEmailController.text,
            "user_BrnID": userData.value!.userBrnID,
            "user_BrnCode": userBrnCodeController.text.isEmpty
                ? userData.value!.userBrnCode
                : userBrnCodeController.text,
            "user_BrnName": userBrnNameController.text.isEmpty
                ? userData.value!.userBrnName
                : userBrnNameController.text,
            "user_imagePicture": snapData.value == null
                ? userData.value!.userImagePicture
                : snapData!.value ?? "",
            "user_imageSignature": signatureData.value == null
                ? userData.value!.userImageSignature
                : signatureData!.value ?? "",
            "user_MUID": userData.value!.muid,
            "user_ComID": userData?.value?.userComID,
            "user_ComCode": userData?.value?.userComCode,
          }
        ]
      });

      try {
        final response = await http.post(url, headers: headers, body: payload);
        if (response.statusCode == 200) {
          print('Data successfully posted.');
        } else {
          print('Failed to post data. Status code: ${response.statusCode}');
        }
      } catch (e) {
        print('Error posting data: $e');
      }
    }

    _fetchData() async {
      try {
        final url = Uri.parse(
            '${apiAccess.apiBaseUrl}/UserInfo/Proc_UserDisplayByApi/?user_UID=' +
                provider.user_id);

        final response = await http.get(url);

        final jsonData = json.decode(response.body);

        User user = parseUserFromJson(response.body);
        userData.value = user;
      } catch (e) {}
    }

    useEffect(() {
      _fetchData();
    }, []);

    File? image;
    File? imageSignature;
    // _pickSignature()

    Future _pickSignature() async {
      try {
        final image = await ImagePicker().pickImage(
            source: ImageSource.gallery, maxHeight: 100, maxWidth: 200);
        print(image?.name);
        if (image == null) return;

        final imageTemporary = File(image.path);

        File file = File(image.path);
        Uint8List bytes = file.readAsBytesSync();

        String base64Image = base64Encode(bytes);

        signatureData.value = base64Image;

        print(base64Image);

        print(imageTemporary);
      } on PlatformException catch (e) {
        print('Failed to pick image: $e');
      }
    }

    Future _pickImage() async {
      try {
        final image = await ImagePicker().pickImage(
            source: ImageSource.gallery, maxHeight: 200, maxWidth: 200);
        print(image?.name);
        if (image == null) return;

        final imageTemporary = File(image.path);

        File file = File(image.path);
        Uint8List bytes = file.readAsBytesSync();

        String base64Image = base64Encode(bytes);

        snapData.value = base64Image;

        print(base64Image);

        print(imageTemporary);
      } on PlatformException catch (e) {
        print('Failed to pick image: $e');
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'User Info Edit',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: Colors.greenAccent[400],
      ),
      body: SafeArea(
        child: Scrollbar(
          thumbVisibility: true,
          thickness: 15,
          interactive: true,
          radius: Radius.circular(20),
          child: Container(
            margin: EdgeInsets.only(top: 20.0, left: 15, right: 25),
            child: SingleChildScrollView(
              child: userData.value != null
                  ? Column(
                      children: [
                        Row(
                          children: [
                            Stack(
                              alignment: Alignment.bottomRight,
                              children:[ Container(
                                width: MediaQuery.of(context).size.width*.35,
                                height: MediaQuery.of(context).size.width * .35,
                                  margin: EdgeInsets.only(bottom: 15, right: 15),
                                  child: ClipOval(
                                    child: SizedBox.fromSize(
                                      size: Size.fromRadius(48),
                                      child: Image.memory(base64Decode(
                                          snapData.value == null
                                              ? userData.value!.userImagePicture
                                              : snapData!.value ?? ""),),
                                    ),
                                  )),
                                   Positioned(
                                right:15,
                                bottom:15,
                                child: Container(
                                  width: MediaQuery.of(context).size.width * .09,
                                  height: MediaQuery.of(context).size.width * .09,
                                  child: FloatingActionButton(
                                    onPressed: _pickImage,
                                    mini: true,
                                    child: Icon(Icons.camera_alt),
                                  ),
                                ),
                              ),
                            ]
                            ),

                          ],
                        ),
                        CustomTextFormField(
                            controller: userIdController,
                            hint: userData.value!.userUID ?? "",
                            title: "User Id"),
                        CustomTextFormField(
                            controller: passwordController,
                            hint: userData.value!.userPws ?? "",
                            title: "Password"),
                        CustomTextFormField(
                            controller: fullNameController,
                            hint: userData.value!.userFullName ?? "",
                            title: "Full Name"),
                        CustomTextFormField(
                            controller: userDesignationController,
                            hint: userData.value!.userDesignation ?? "",
                            title: "Designation"),
                        CustomTextFormField(
                            controller: userMobileNoController,
                            hint: userData.value!.userMobileNo ?? "",
                            title: "Mobile no."),
                        CustomTextFormField(
                            controller: userEmailController,
                            hint: userData.value!.userEmail ?? "",
                            title: "Email"),
                        CustomTextFormField(
                            controller: userDepartmentCodeController,
                            hint: userData.value!.userDepartmentCode ?? "",
                            title: "Department Code"),
                        CustomTextFormField(
                            controller: userDepartmentController,
                            hint: userData.value!.userDepartment ?? "",
                            title: "Department Name"),
                        CustomTextFormField(
                            controller: userBrnCodeController,
                            hint: userData.value!.userBrnCode ?? "",
                            title: "Branch Code"),
                        CustomTextFormField(
                            controller: userBrnNameController,
                            hint: userData.value!.userBrnName ?? "",
                            title: "Branch Name"),
                        CustomTextFormField(
                            controller: userBrnNameController,
                            hint: userData.value!.userBrnName ?? "",
                            title: "Branch Name"),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: SizedBox(
                                  width: MediaQuery.of(context).size.width * .3,
                                  child: Image.memory(base64Decode(
                                      signatureData.value == null
                                          ? userData.value!.userImageSignature
                                          : signatureData!.value ?? ""))),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                padding: EdgeInsets.all(10),
                                width: MediaQuery.of(context).size.width * .3,
                                child: ElevatedButton(
                                    onPressed: () {
                                      _pickSignature();
                                    },
                                    child: Text(
                                      'Upload Signature',
                                      textAlign: TextAlign.center,
                                    )),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                                margin: EdgeInsets.only(right: 10),
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green,
                                      elevation: 3,
                                      maximumSize: Size(150, 150),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            12), // <-- Radius
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 10),
                                    ),
                                    onPressed: () => {
                                          _submitPost(),
                                        },
                                    child: Text(
                                      'Submit',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w900,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .020),
                                    ))),
                            Container(
                              margin: EdgeInsets.all(10),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    elevation: 3,
                                    maximumSize: Size(150, 150),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          12), // <-- Radius
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                  ),
                                  onPressed: () =>
                                      {Navigator.pop(context, '/salesmgt')},
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w900,
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                .020),
                                  )),
                            ),
                          ],
                        )
                      ],
                    )
                  : Center(child: CircularProgressIndicator()),
            ),
          ),
        ),
      ),
    );
  }
}
