import 'dart:async';
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
import '../model/terrytorydropdownModel.dart';

class Areasetting extends HookWidget {
  const Areasetting({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthProvider>(context, listen: false);
    final territoryData = useState<TerritoryModel?>(null);
    final dropdownvalue = useState<TerritoryDropDownlModel?>(null);
    final terryDropdown = useState<List<TerritoryDropDownlModel>>([]);

    // Controllers for the text fields
    final territoryCodeController = useTextEditingController();
    final territoryNameController = useTextEditingController();
    final areaCodeController = useTextEditingController();
    final areaNameController = useTextEditingController();
    final regionCodeController = useTextEditingController();
    final regionNameController = useTextEditingController();
    final depotCodeController = useTextEditingController();
    final depotNameController = useTextEditingController();
    final userIdController = useTextEditingController();

    Future<void> _fetchDropDownData() async {
      try {
        final url = Uri.parse(
            '${apiAccess.apiBaseUrl}/SalesMobile/Proc_UserAreaListSingleDepotForHelpByApi?vDepotCode=${territoryData.value!.teryDepotCode}');
        final response = await http.get(url);
        final jsonData = json.decode(response.body);
        List<dynamic> customerCategories = jsonData['Table'];
        List<TerritoryDropDownlModel> terrytoryDropdown = customerCategories
            .map((obj) => TerritoryDropDownlModel.fromJson(obj))
            .toList();

        terryDropdown.value = terrytoryDropdown;

        // Set the initial dropdown value to the current territory
        dropdownvalue.value = terrytoryDropdown.firstWhere(
            (item) => item.teryCode == territoryData.value!.teryCode,
            orElse: () => terrytoryDropdown[0]);
      } catch (e) {
        print('Error fetching dropdown data: $e');
      }
    }

    Future<void> _fetchData() async {
      try {
        final url = Uri.parse(
            '${apiAccess.apiBaseUrl}/SalesMobile/Proc_UserAreaInfoByApi?tery_UserId=${provider.user_id}');
        final response = await http.get(url);
        TerritoryModel terrytory = parseTerritoryFromJson(response.body);
        territoryData.value = terrytory;
        await _fetchDropDownData();

        // Set the initial values for the text controllers
        territoryCodeController.text = terrytory.teryCode;
        territoryNameController.text = terrytory.teryName;
        areaCodeController.text = terrytory.teryAreaCode;
        areaNameController.text = terrytory.teryAreaName;
        regionCodeController.text = terrytory.teryRegionCode;
        regionNameController.text = terrytory.teryRegionName;
        depotCodeController.text = terrytory.teryDepotCode;
        depotNameController.text = terrytory.teryDepotName;
        userIdController.text = terrytory.userUID;
      } catch (e) {
        print('Error fetching data: $e');
      }
    }

    Future<void> _submitPost() async {
      final url = Uri.parse(
          '${apiAccess.apiBaseUrl}/SalesMobile/Proc_SaveUserAreaByApi');
      final headers = {"Content-Type": "application/json"};
      final payload = json.encode({
        "Table": [
          {
            "user_SysId": territoryData.value!.userSysId,
            "user_UID": territoryData.value!.userUID,
            "tery_Code": dropdownvalue.value?.teryCode,
            "tery_Status": 'True',
            "user_CUID": territoryData.value!.userCUID,
            "user_MUID": territoryData.value!.muid,
            "user_ComID": territoryData.value!.userComID,
            "user_ComCode": territoryData.value!.userComCode,
            "user_ComName": territoryData.value!.userComName,
          }
        ]
      });

      try {
        final response = await http.post(url, headers: headers, body: payload);
        if (response.statusCode == 200) {
          print('Data successfully posted.');
          await _fetchData(); // Reload data after save
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Data successfully saved')),
          );
        } else {
          print('Failed to post data. Status code: ${response.statusCode}');
        }
      } catch (e) {
        print('Error posting data: $e');
      }
    }

    useEffect(() {
      _fetchData();
      return null;
    }, []);

    Future<void> _showDropdownDialog(BuildContext context) async {
      final selectedValue = await showModalBottomSheet<TerritoryDropDownlModel>(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.8,
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                AppBar(
                  title: Text('Select Territory'),
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
                          DataColumn(label: Text('Parent Code')),
                          DataColumn(
                              label: Text(
                                  'Territory Code')), // Corrected label name
                        ],
                        rows: terryDropdown.value.map((item) {
                          return DataRow(
                            cells: [
                              DataCell(Text(item.teryName), onTap: () {
                                Navigator.pop(context, item);
                              }),
                              DataCell(Text(item.teryParentCode), onTap: () {
                                Navigator.pop(context, item);
                              }),
                              DataCell(Text(item.teryCode), onTap: () {
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
        dropdownvalue.value = selectedValue;
        territoryCodeController.text = selectedValue.teryCode;
        territoryNameController.text = selectedValue.teryName;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'User-wise Area Settings',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
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
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  'Find',
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: InkWell(
                                  onTap: () => _showDropdownDialog(context),
                                  child: InputDecorator(
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      border: UnderlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                    child: Text(
                                      dropdownvalue.value != null
                                          ? '${dropdownvalue.value!.teryName} (${dropdownvalue.value!.teryParentCode})'
                                          : 'Select Territory',
                                      style: TextStyle(
                                        color: dropdownvalue.value != null
                                            ? Colors.black
                                            : Colors.grey.shade700,
                                        fontWeight: dropdownvalue.value != null
                                            ? FontWeight.w600
                                            : FontWeight.w400,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        CustomTextFormFieldAreaSetting(
                          controller: territoryCodeController,
                          hint: 'Territory Code',
                          title: "Territory Code",
                          isEnable: false,
                        ),
                        CustomTextFormFieldAreaSetting(
                          controller: territoryNameController,
                          hint: 'Territory Name',
                          title: "Territory Name",
                          isEnable: false,
                        ),
                        CustomTextFormFieldAreaSetting(
                          controller: areaCodeController,
                          hint: 'Area Code',
                          title: "Area Code",
                          isEnable: false,
                        ),
                        CustomTextFormFieldAreaSetting(
                          controller: areaNameController,
                          hint: 'Area Name',
                          title: "Area Name",
                          isEnable: false,
                        ),
                        CustomTextFormFieldAreaSetting(
                          controller: regionCodeController,
                          hint: "Region Code",
                          title: "Region Code",
                          isEnable: false,
                        ),
                        CustomTextFormFieldAreaSetting(
                          controller: regionNameController,
                          hint: "Region Name",
                          title: "Region Name",
                          isEnable: false,
                        ),
                        CustomTextFormFieldAreaSetting(
                          controller: depotCodeController,
                          hint: "Depot Code",
                          title: "Depot Code",
                          isEnable: false,
                        ),
                        CustomTextFormFieldAreaSetting(
                          controller: depotNameController,
                          hint: "Depot Name",
                          title: "Depot Name",
                          isEnable: false,
                        ),
                        CustomTextFormFieldAreaSetting(
                          controller: userIdController,
                          hint: "User Id",
                          title: "User Id",
                          isEnable: false,
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
                                onPressed: () => _submitPost(),
                                child: Text(
                                  'Save',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900,
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              .020),
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
                                  'Close',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900,
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              .020),
                                ),
                              ),
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
