import 'package:app_ziskapharma/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'dart:convert';
import '../model/sample.dart';

class Userinfoscreen extends HookWidget {
  const Userinfoscreen({super.key});

  Future<void> _submitHandler(BuildContext context, User? userData) async {
    final url = Uri.parse(
        'http://192.168.0.106:45455/api/UserInfo/Proc_UserUpdateByApi');
    final headers = {"Content-Type": "application/json"};
    final body = json.encode({
      "userId": userData?.userUID,
      "userPass": userData?.userPws,
      "userFullName": userData?.userFullName,
      "userDesignation": userData?.userDesignation,
      "userMobileNo": userData?.userMobileNo,
      "userEmail": userData?.userEmail,
      "userDepartment": userData?.userDepartment,
      "userBrnCode": userData?.userBrnCode,
      "userBrnName": userData?.userBrnName,
      "userImageSignature": userData?.userImageSignature,
      // Add other fields as needed
    });

    print(body);

    // try {
    //   final response = await http.post(url, headers: headers, body: body);
    //   if (response.statusCode == 200) {
    //     print('Data successfully posted.');
    //   } else {
    //     print('Failed to post data. Status code: ${response.statusCode}');
    //   }
    // } catch (e) {
    //   print('Error posting data: $e');
    // }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthProvider>(context, listen: false);
    final userData = useState<User?>(null);
    var dataUser;

////////////////////////////////////////////////////////////////////////////////////
    ///
    TextEditingController userIdController =
        TextEditingController(text: userData.value?.userUID ?? "");
    TextEditingController passwordController = TextEditingController(text: userData.value?.userPws ?? "");
    TextEditingController fullNameController = TextEditingController(text: userData.value?.userFullName ?? "");
    TextEditingController userDesignationController = TextEditingController(text: userData.value?.userDesignation ?? "");
    TextEditingController userMobileNoController = TextEditingController(text: userData.value?.userMobileNo ?? "");
    TextEditingController userEmailController = TextEditingController(text: userData.value?.userEmail ?? "");
    TextEditingController userDepartmentController = TextEditingController(text: userData.value?.userDepartment ?? "");
    TextEditingController userDepartmentCodeController =
        TextEditingController(text: userData.value?.userDepartmentCode ?? "");
    TextEditingController userBrnCodeController = TextEditingController(text: userData.value?.userBrnCode ?? "");
    TextEditingController userBrnNameController = TextEditingController(text: userData.value?.userBrnName ?? "");

// Create controllers for other fields as needed

///////////////////////////////////////////////////////////////////////////////////////
    ///
    ///
    ///

    Future<void> _submitPost() async {
      final url =
          Uri.parse('http://192.168.0.106:45455/api/UserInfo/Proc_SaveByApi');
      final headers = {"Content-Type": "application/json"};

      // Create the JSON payload
      final payload = json.encode({
        "UserTable": [
          {
            "user_ID": userIdController.text ?? userData.value!.userID,
            "user_UID": userIdController.text,
            "user_Pws": passwordController.text,
            "user_FullName": fullNameController,
            "user_Department": userDepartmentController,
            "user_DepartmentCode": userDepartmentCodeController,
            "user_Designation": userDesignationController,
            "user_MobileNo": userMobileNoController,
            "user_Email": userEmailController,
            "user_BrnID": userData.value!.userBrnID,
            "user_BrnCode": userBrnCodeController,
            "user_BrnName": userBrnNameController,
            "user_imagePicture": userData.value!.userImagePicture,
            "user_imageSignature": userData.value!.userImageSignature,
          }
        ]
      });

      print(payload);

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

    _printValue() {
      print(userData.value);
    }

    _fetchData() async {
      try {
        final url = Uri.parse(
            'http://192.168.0.106:45455/api/UserInfo/Proc_UserDisplayByApi/?user_UID=' +
                provider.user_id);

        final response = await http.get(url);

        // print(response.body[0]);

        final jsonData = json.decode(response.body);
        // dataUser = jsonData;
        // print(dataUser);
        // userData.value = jsonData;
        // print(userData.value);
        // print(jsonData['Table'][0]['user_OID']);
        // print(jsonData['Table'][0]['user_imagePicture']);

        User user = parseUserFromJson(response.body);
        userData.value = user;
        // dataUser = user;
        // print(dataUser.userFullName);
        // print("Hello");
        // print(user.userFullName);
        // print(user.userOID);
        // print(user.userImagePicture);
      } catch (e) {}
    }

    useEffect(() {
      print('fffffffffffffffffffffffffffffffffffffffffffffff');

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
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                          margin: EdgeInsets.only(bottom: 15),
                          child: Image.memory(
                              base64Decode(userData.value!.userImagePicture)))
                    ],
                  ),
                  textFeild(userData.value!.userUID ?? "", "User Id",
                      userIdController),
                  textFeild(userData.value!.userPws ?? "", "Password",
                      passwordController),
                  textFeild(userData.value!.userFullName ?? "", "Full Name",
                      fullNameController),
                  textFeild(userData.value!.userDesignation ?? "",
                      "Designation", userDesignationController),
                  textFeild(userData.value!.userMobileNo ?? "", "Mobile no.",
                      userMobileNoController),
                  textFeild(userData.value!.userEmail ?? "", "Email",
                      userEmailController),
                  textFeild(userData.value!.userDepartmentCode ?? "",
                      "Department Code", userDepartmentCodeController),
                  textFeild(userData.value!.userDepartment ?? "",
                      "Department Name", userDepartmentController),
                  textFeild(userData.value!.userBrnCode ?? "", "Branch Code",
                      userBrnCodeController),
                  textFeild(userData.value!.userBrnName ?? "", "Branch Name",
                      userBrnNameController),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * .3,
                      child: Image.memory(
                          base64Decode(userData.value!.userImageSignature))),
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
                                  borderRadius:
                                      BorderRadius.circular(12), // <-- Radius
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
                                    fontSize:
                                        MediaQuery.of(context).size.height *
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
                                borderRadius:
                                    BorderRadius.circular(12), // <-- Radius
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
                                  fontSize: MediaQuery.of(context).size.height *
                                      .020),
                            )),
                      ),
                    ],
                  )
                ],
              ),
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
