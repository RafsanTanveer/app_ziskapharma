import 'package:app_ziskapharma/custom_widgets/textFormField.dart';
import 'package:app_ziskapharma/model/territoryInfoModel.dart';
import 'package:app_ziskapharma/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import '../dataaccess/apiAccess.dart' as apiAccess;
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/territoryInfoModel.dart';

class Areasetting extends HookWidget {
  const Areasetting({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthProvider>(context, listen: false);
    final territoryData = useState<TerritoryModel?>(null);

    final dropdownvalue = useState<String?>('Item 1');

    // List of items in our dropdown menu
    var items = [
      'Item 1',
      'Item 2',
      'Item 3',
      'Item 4',
      'Item 5',
    ];

    Future<void> _submitPost() async {
      final url = Uri.parse('${apiAccess.apiBaseUrl}/UserInfo/Proc_SaveByApi');
      final headers = {"Content-Type": "application/json"};

      // Create the JSON payload
      final payload = json.encode({
        "UserTable": [
          {
            "user_UID":  territoryData.value!.userUID,
            //  "tery_Code": territoryCodeController.text.isEmpty ? territoryData.value!.teryCode : territoryCodeController.text,
            // "tery_Name": "",
            // "tery_AreaCode": areaNameController.text.isEmpty
            //     ? territoryData.value!.teryAreaCode
            //     : areaNameController.text,
            // "tery_AreaName": userDepartmentController.text.isEmpty
            //     ? userData.value!.userDepartment
            //     : userDepartmentController.text,
            // "tery_RegionCode": userDepartmentCodeController.text.isEmpty
            //     ? userData.value!.userDepartmentCode
            //     : userDepartmentCodeController.text,
            // "tery_RegionName": userDesignationController.text.isEmpty
            //     ? userData.value!.userDesignation
            //     : userDesignationController.text,
            // "tery_DepotCode": userMobileNoController.text.isEmpty
            //     ? userData.value!.userMobileNo
            //     : userMobileNoController.text,
            // "tery_DepotName": userEmailController.text.isEmpty
            //     ? userData.value!.userEmail
            //     : userEmailController.text,
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
        //SalesMobile/Proc_UserAreaInfoByApi?tery_UserId=admin
        //http://localhost:65143/api/SalesMobile/Proc_UserAreaInfoByApi?tery_UserId=admin
        final url = Uri.parse(
            '${apiAccess.apiBaseUrl}/SalesMobile/Proc_UserAreaInfoByApi?tery_UserId=' +
                provider.user_id);
        print(url);
        final response = await http.get(url);

        final jsonData = json.decode(response.body);
        print(
            'ffffffffffffffffffffffff-------------------------------------------');
        //print(jsonData['Table']);

        TerritoryModel terrytory = parseTerritoryFromJson(response.body);
        print(terrytory.teryCode);
        territoryData.value = terrytory;
        print(territoryData.value?.teryCode ?? "not available");
      } catch (e) {}
    }

    _fetchDropDownData() async {
      try {
        //SalesMobile/Proc_UserAreaInfoByApi?tery_UserId=admin
        //http://localhost:65143/api/SalesMobile/Proc_UserAreaInfoByApi?tery_UserId=admin
        http: //localhost:65143/api/SalesMobile/Proc_UserAreaListSingleDepotForHelpByApi?vDepotCode=DHK
        final url = Uri.parse(
            '${apiAccess.apiBaseUrl}/SalesMobile/Proc_UserAreaInfoByApi?tery_UserId=' +
                provider.user_id);
        print(url);
        final response = await http.get(url);

        final jsonData = json.decode(response.body);
        print(
            'ffffffffffffffffffffffff-------------------------------------------');
        //print(jsonData['Table']);

        TerritoryModel terrytory = parseTerritoryFromJson(response.body);
        print(terrytory.teryCode);
        territoryData.value = terrytory;
        print(territoryData.value?.teryCode ?? "not available");
      } catch (e) {}
    }

    useEffect(() {
      _fetchData();
      _fetchDropDownData();
    }, []);

//////////////////////////// controllers ///////////////////////////////////////////////
    TextEditingController territoryCodeController =
        TextEditingController(text: territoryData.value?.teryCode ?? "");
    TextEditingController territoryNameController =
        TextEditingController(text: territoryData.value?.teryName ?? "");
    TextEditingController areaCodeController =
        TextEditingController(text: territoryData.value?.teryAreaCode ?? "");
    TextEditingController areaNameController =
        TextEditingController(text: territoryData.value?.teryAreaName ?? "");
    TextEditingController regionCodeController =
        TextEditingController(text: territoryData.value?.teryRegionCode ?? "");
    TextEditingController regionNameController =
        TextEditingController(text: territoryData.value?.teryRegionName ?? "");
    TextEditingController depotCodeController =
        TextEditingController(text: territoryData.value?.teryDepotCode ?? "");
    TextEditingController depotNameController =
        TextEditingController(text: territoryData.value?.teryDepotName ?? "");
    TextEditingController userIdController =
        TextEditingController(text: territoryData.value?.userUID ?? "");
//////////////////////////// controllers ///////////////////////////////////////////////

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'User-wise Area Settings',
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
              child: territoryData.value != null
                  ? Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text('Find', style: TextStyle(fontWeight: FontWeight.w700),)),
                            Expanded(
                              flex: 3,
                              child: DropdownButton<String>(
                                  value: dropdownvalue.value,
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  items: items.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    dropdownvalue.value = newValue!;
                                  }),
                            ),
                          ],
                        ),
                        CustomTextFormField(
                            controller: territoryCodeController,
                            hint: 'hint',
                            title: "Territory Code"),
                        CustomTextFormField(
                            controller: territoryNameController,
                            hint: 'hint',
                            title: "Territory Name"),
                        CustomTextFormField(
                            controller: areaCodeController,
                            hint: 'hint',
                            title: "Area Code"),
                        CustomTextFormField(
                            controller: areaNameController,
                            hint: 'hint',
                            title: "Area Name"),
                        CustomTextFormField(
                            controller: regionCodeController,
                            hint: "Region Code",
                            title: "Region Code"),
                        CustomTextFormField(
                            controller: regionNameController,
                            hint: "Region Name",
                            title: "Region Name"),
                        CustomTextFormField(
                            controller: depotCodeController,
                            hint: "Depot Code",
                            title: "Depot Code"),
                        CustomTextFormField(
                            controller: depotNameController,
                            hint: "Depot Name",
                            title: "Depot Name"),
                        CustomTextFormField(
                            controller: userIdController,
                            hint: "User Id",
                            title: "User Id"),
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
                                    onPressed: () => {},
                                    child: Text(
                                      'Save',
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
                                    'Close',
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
