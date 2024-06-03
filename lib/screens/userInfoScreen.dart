import 'package:app_ziskapharma/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'dart:convert';
import '../model/sample.dart';

import '../dataaccess/apiAccess.dart' as apiAccess;

class Userinfoscreen extends HookWidget {
  const Userinfoscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthProvider>(context, listen: false);
    final userData = useState<User?>(null);

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
            "user_imagePicture": userData.value!.userImagePicture,
            "user_imageSignature": userData.value!.userImageSignature,
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
                            Container(
                                margin: EdgeInsets.only(bottom: 15),
                                child: Image.memory(base64Decode(
                                    userData.value!.userImagePicture)))
                          ],
                        ),
                        textFeild(userData.value!.userUID ?? "", "User Id",
                            userIdController),
                        textFeild(userData.value!.userPws ?? "", "Password",
                            passwordController),
                        textFeild(userData.value!.userFullName ?? "",
                            "Full Name", fullNameController),
                        textFeild(userData.value!.userDesignation ?? "",
                            "Designation", userDesignationController),
                        textFeild(userData.value!.userMobileNo ?? "",
                            "Mobile no.", userMobileNoController),
                        textFeild(userData.value!.userEmail ?? "", "Email",
                            userEmailController),
                        textFeild(userData.value!.userDepartmentCode ?? "",
                            "Department Code", userDepartmentCodeController),
                        textFeild(userData.value!.userDepartment ?? "",
                            "Department Name", userDepartmentController),
                        textFeild(userData.value!.userBrnCode ?? "",
                            "Branch Code", userBrnCodeController),
                        textFeild(userData.value!.userBrnName ?? "",
                            "Branch Name", userBrnNameController),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * .3,
                            child: Image.memory(base64Decode(
                                userData.value!.userImageSignature))),
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

  Widget textFeild(String hint, String title, TextEditingController? control) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 12),
          child: TextFormField(
            controller: control,
            onChanged: (text) {
              // Update the text in the controller when the text field changes
              control?.text = text;
              print(text);
            },
            decoration: InputDecoration(
                hintText: hint, enabledBorder: const OutlineInputBorder()),
          ),
        ),
      ],
    );
  }
}
