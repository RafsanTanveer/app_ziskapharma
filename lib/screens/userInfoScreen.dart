import 'dart:typed_data';
import 'package:app_ziskapharma/model/branchModel.dart';
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
    final branchValue = useState<Branch?>(null);
    final branchDropdown = useState<List<Branch>>([]);

    void setControllerText(TextEditingController controller, String text) {
      controller.text = text;
    }

    TextEditingController userIdController = useTextEditingController();
    TextEditingController passwordController = useTextEditingController();
    TextEditingController fullNameController = useTextEditingController();
    TextEditingController userDesignationController =
        useTextEditingController();
    TextEditingController userMobileNoController = useTextEditingController();
    TextEditingController userEmailController = useTextEditingController();
    TextEditingController userDepartmentController = useTextEditingController();
    TextEditingController userDepartmentCodeController =
        useTextEditingController();
    TextEditingController userBrnCodeController = useTextEditingController();
    TextEditingController userBrnNameController = useTextEditingController();

    Future<void> _submitPost() async {
      final url = Uri.parse('${apiAccess.apiBaseUrl}/UserInfo/Proc_SaveByApi');
      final headers = {"Content-Type": "application/json"};

      final payload = json.encode({
        "UserTable": [
          {
            "user_ID": userData.value!.userID,
            "user_UID": userIdController.text,
            "user_Pws": passwordController.text,
            "user_FullName": fullNameController.text,
            "user_Department": userDepartmentController.text,
            "user_DepartmentCode": userDepartmentCodeController.text,
            "user_Designation": userDesignationController.text,
            "user_MobileNo": userMobileNoController.text,
            "user_Email": userEmailController.text,
            "user_BrnID": userData.value!.userBrnID,
            "user_BrnCode": userBrnCodeController.text,
            "user_BrnName": userBrnNameController.text,
            "user_imagePicture":
                snapData.value ?? userData.value!.userImagePicture,
            "user_imageSignature":
                signatureData.value ?? userData.value!.userImageSignature,
            "user_MUID": userData.value!.muid,
            "user_ComID": userData.value?.userComID,
            "user_ComCode": userData.value?.userComCode,
          }
        ]
      });

      try {
        final response = await http.post(url, headers: headers, body: payload);
        if (response.statusCode == 200) {
          print('Data successfully posted.');
          Navigator.pop(context);
        } else {
          print('Failed to post data. Status code: ${response.statusCode}');
        }
      } catch (e) {
        print('Error posting data: $e');
      }
    }

    Future<void> _showDropdownDialog(BuildContext context) async {
      final selectedValue = await showModalBottomSheet<Branch>(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.8,
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                AppBar(
                  title: Text('Select Branch'),
                  automaticallyImplyLeading: false,
                  actions: [
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Text('Name')),
                          DataColumn(label: Text('Code')),
                          DataColumn(
                              label: Text(
                                  'Branch Address')), // Corrected label name
                        ],
                        rows: branchDropdown.value.map((item) {
                          return DataRow(
                            cells: [
                              DataCell(Text(item.brnName.toString()),
                                  onTap: () {
                                Navigator.pop(context, item);
                              }),
                              DataCell(Text(item.brnComCode.toString()),
                                  onTap: () {
                                Navigator.pop(context, item);
                              }),
                              DataCell(Text(item.brnAddress1.toString()),
                                  onTap: () {
                                Navigator.pop(context, item);
                              }),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );

      // Ensure that the UI is updated after receiving the selected value
      if (selectedValue != null) {
        branchValue.value = selectedValue;
        userBrnCodeController.text = selectedValue.brnCode.toString();
        userBrnNameController.text = selectedValue.brnName.toString();
      }
    }

    Future<void> _fetchBranch() async {
      final url =
          Uri.parse('${apiAccess.apiBaseUrl}/UserInfo/Proc_BranchListByApi');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        List<dynamic> branches = jsonResponse['Table'];
        List<Branch> branch =
            branches.map((obj) => Branch.fromJson(obj)).toList();

        branchDropdown.value = branch;
      } else {
        throw Exception('Failed to load data');
      }
    }

    Future<void> _fetchData() async {
      try {
        final url = Uri.parse(
            '${apiAccess.apiBaseUrl}/UserInfo/Proc_UserDisplayByApi/?user_UID=' +
                provider.user_id);
        final response = await http.get(url);
        final jsonData = json.decode(response.body);
        User user = parseUserFromJson(response.body);
        userData.value = user;
        await _fetchBranch();
        setControllerText(userIdController, user.userUID);
        setControllerText(passwordController, user.userPws);
        setControllerText(fullNameController, user.userFullName);
        setControllerText(userDesignationController, user.userDesignation);
        setControllerText(userMobileNoController, user.userMobileNo);
        setControllerText(userEmailController, user.userEmail);
        setControllerText(userDepartmentController, user.userDepartment);
        setControllerText(
            userDepartmentCodeController, user.userDepartmentCode);
        setControllerText(userBrnCodeController, user.userBrnCode);
        setControllerText(userBrnNameController, user.userBrnName);
      } catch (e) {
        print('Error fetching data: $e');
      }
    }

    useEffect(() {
      _fetchData();
    }, []);

    Future<void> _pickImage() async {
      try {
        final pickedImage = await ImagePicker().pickImage(
            source: ImageSource.gallery, maxHeight: 200, maxWidth: 200);
        if (pickedImage == null) return;

        final imageTemporary = File(pickedImage.path);
        Uint8List bytes = imageTemporary.readAsBytesSync();
        String base64Image = base64Encode(bytes);
        snapData.value = base64Image;
      } on PlatformException catch (e) {
        print('Failed to pick image: $e');
      }
    }

    Future<void> _pickSignature() async {
      try {
        final pickedSignature = await ImagePicker().pickImage(
            source: ImageSource.gallery, maxHeight: 100, maxWidth: 200);
        if (pickedSignature == null) return;

        final signatureTemporary = File(pickedSignature.path);
        Uint8List bytes = signatureTemporary.readAsBytesSync();
        String base64Signature = base64Encode(bytes);
        signatureData.value = base64Signature;
      } on PlatformException catch (e) {
        print('Failed to pick signature: $e');
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
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * .35,
                                  height:
                                      MediaQuery.of(context).size.width * .35,
                                  margin:
                                      EdgeInsets.only(bottom: 15, right: 15),
                                  child: ClipOval(
                                    child: SizedBox.fromSize(
                                      size: Size.fromRadius(48),
                                      child: Image.memory(
                                        base64Decode(snapData.value ??
                                            userData.value!.userImagePicture),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 15,
                                  bottom: 15,
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * .09,
                                    height:
                                        MediaQuery.of(context).size.width * .09,
                                    child: FloatingActionButton(
                                      onPressed: _pickImage,
                                      mini: true,
                                      child: Icon(Icons.camera_alt),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * .25,
                                  height:
                                      MediaQuery.of(context).size.width * .25,
                                  margin: EdgeInsets.only(
                                      bottom: 15,
                                      right: 15,
                                      left: 15,
                                      top: MediaQuery.of(context).size.width *
                                          .1),
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * .2,
                                    child: Image.memory(base64Decode(
                                        signatureData.value ??
                                            userData
                                                .value!.userImageSignature)),
                                  ),
                                ),
                                Positioned(
                                  right: 15,
                                  bottom: 15,
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * .09,
                                    height:
                                        MediaQuery.of(context).size.width * .09,
                                    child: FloatingActionButton(
                                      onPressed: _pickSignature,
                                      mini: true,
                                      child: Icon(Icons.camera_alt),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        CustomTextFormField(
                          controller: userIdController,
                          hint: userData.value!.userUID ?? "",
                          title: "User Id",
                        ),
                        CustomTextFormField(
                          controller: passwordController,
                          hint: userData.value!.userPws ?? "",
                          title: "Password",
                        ),
                        CustomTextFormField(
                          controller: fullNameController,
                          hint: userData.value!.userFullName ?? "",
                          title: "Full Name",
                        ),
                        CustomTextFormField(
                          controller: userDesignationController,
                          hint: userData.value!.userDesignation ?? "",
                          title: "Designation",
                        ),
                        CustomTextFormField(
                          controller: userMobileNoController,
                          hint: userData.value!.userMobileNo ?? "",
                          title: "Mobile no.",
                        ),
                        CustomTextFormField(
                          controller: userEmailController,
                          hint: userData.value!.userEmail ?? "",
                          title: "Email",
                        ),
                        CustomTextFormField(
                          controller: userDepartmentCodeController,
                          hint: userData.value!.userDepartmentCode ?? "",
                          title: "Department Code",
                        ),
                        CustomTextFormField(
                          controller: userDepartmentController,
                          hint: userData.value!.userDepartment ?? "",
                          title: "Department Name",
                        ),
                        TextFeildWithSearchBtn(
                            controller: userBrnCodeController,
                            hint: userData.value!.userBrnCode ?? "",
                            title: "Branch Code",
                            onPressed: () => _showDropdownDialog(context)),
                        CustomTextFormField(
                          controller: userBrnNameController,
                          hint: userData.value!.userBrnName ?? "",
                          title: "Branch Name",
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
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                ),
                                onPressed: _submitPost,
                                child: Text(
                                  'Submit',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            .020,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  elevation: 3,
                                  maximumSize: Size(150, 150),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                ),
                                onPressed: () =>
                                    Navigator.pop(context, '/salesmgt'),
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            .020,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
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
