import 'package:app_ziskapharma/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'dart:convert';
import '../model/sample.dart';

class Userinfoscreen extends HookWidget {
  const Userinfoscreen({super.key});

  Future<void> _submitHandler(BuildContext context, String userId,
      String userPass, User? userData) async {
    final url = Uri.parse(
        'http://192.168.0.106:45455/api/UserInfo/Proc_UserUpdateByApi');
    final headers = {"Content-Type": "application/json"};
    final body = json.encode({
      "userId": userId,
      "userPass": userPass,
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

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        print('Data successfully posted.');
      } else {
        print('Failed to post data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error posting data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthProvider>(context, listen: false);
    final userData = useState<User?>(null);
    final userId = useState<String>('');
    final userPass = useState<String>('');

    _printValue() {
      print(userData.value);
    }

    _fetchData() async {
      try {
        final url = Uri.parse(
            'http://192.168.0.106:45455/api/UserInfo/Proc_UserDisplayByApi/?user_UID=admin');

        final response = await http.get(url);
        final jsonData = json.decode(response.body);
        User user = parseUserFromJson(response.body);
        userData.value = user;
      } catch (e) {
        print(e);
      }
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
              child: Column(
                children: [
                  if (userData.value != null) ...[
                    Row(
                      children: [
                        Container(
                            margin: EdgeInsets.only(bottom: 15),
                            child: Image.memory(
                                base64Decode(userData.value!.userImagePicture)))
                      ],
                    ),
                    textFeild('User Id', ""),
                    textFeild('Password', ""),
                    textFeild('Full Name', userData.value!.userFullName),
                    textFeild('Designation', userData.value!.userDesignation),
                    textFeild('Mobile no.', userData.value!.userMobileNo),
                    textFeild('Email', userData.value!.userEmail),
                    textFeild(
                        'Department Code', userData.value!.userDepartment),
                    textFeild(
                        'Department Name', userData.value!.userDepartment),
                    textFeild('Branch Code', userData.value!.userBrnCode),
                    textFeild('Branch Name', userData.value!.userBrnName),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * .3,
                        child: Image.memory(
                            base64Decode(userData.value!.userImageSignature))),
                  ],
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
                              onPressed: () => _submitHandler(context,
                                  userId.value, userPass.value, userData.value),
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

  Widget textFeild(String title,
      [String? hint, ValueChanged<String>? onChanged]) {
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
            initialValue: hint,
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: hint,
              enabledBorder: const OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }
}
