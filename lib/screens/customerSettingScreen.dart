import 'package:app_ziskapharma/custom_widgets/textFormField.dart';
import 'package:app_ziskapharma/model/customerCategoryModel.dart';
import 'package:app_ziskapharma/model/customerTypeInfo.dart';
import 'package:app_ziskapharma/model/salesRule.dart';
import 'package:app_ziskapharma/model/territoryInfoModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../dataaccess/apiAccess.dart' as apiAccess;
import '../model/DoctorListModel.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:app_ziskapharma/provider/auth_provider.dart';

class CustomerSettingScreen extends HookWidget {
  const CustomerSettingScreen({required this.param_cpCode});

  final String param_cpCode;

  //final provider = Provider.of<AuthProvider>(context, listen: false);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthProvider>(context, listen: false);

    final customerTypeDropdownvalue = useState<CustomerTypeInfo?>(null);
    final doctorDropdown = useState<List<DoctorListModel>>([]);
    final doctorDropdownvalue = useState<DoctorListModel?>(null);


    Future<void> _fetchData() async {
      try {
        final url = Uri.parse(
            '${apiAccess.apiBaseUrl}/SalesMobile/Proc_UserAreaInfoByApi?tery_UserId=${provider.user_id}');
        final response = await http.get(url);
        TerritoryModel terrytory = parseTerritoryFromJson(response.body);
        // territoryData.value = terrytory;
        // await _fetchDropDownData();

        // Set the initial values for the text controllers

      } catch (e) {
        print('Error fetching data: $e');
      }
    }


    fetchCustomerTypeInfo(String cpCode) async {
      try {
        final url = Uri.parse(
            '${apiAccess.apiBaseUrl}/CustomerSettings/Proc_DisplaySingleCustomerTypeInfoByApi?cp_Code=$cpCode');
        final response = await http.get(url);

        if (response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          final List<dynamic> table = jsonResponse['Table'];
          final Map<String, dynamic> data = table.first;
          customerTypeDropdownvalue.value = CustomerTypeInfo.fromJson(data);
        } else {
          throw Exception('Failed to load data');
        }
      } catch (e) {}
    }

     fetchSingleCustomerTypeInfo(String cpCode) async {
      try {
        final url = Uri.parse(
            '${apiAccess.apiBaseUrl}/CustomerSettings/Proc_CustomerCategoryInfoByApi?cp_Code=$cpCode');
        final response = await http.get(url);

        if (response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          final List<dynamic> table = jsonResponse['Table'];
          final Map<String, dynamic> data = table.first;
          customerTypeDropdownvalue.value = CustomerTypeInfo.fromJson(data);
        } else {
          throw Exception('Failed to load data');
        }
      } catch (e) {}
    }


Future<void> fetchCustomerCategoryHelpListByApi() async {
      final url = Uri.parse(
          '${apiAccess.apiBaseUrl}/CustomerSettings/Proc_CustomerCategoryHelpListByApi');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final List<dynamic> table = jsonResponse['Table'];
        List<CustomerCategory> data =
            table.map((item) => CustomerCategory.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load data');
      }
    }

    // Future<void> fetchSalesRulesHelpListByApi() async {
    //   final url = Uri.parse(
    //       '${apiAccess.apiBaseUrl}/CustomerSettings/Proc_SalesRulesHelpListByApi');
    //   final response = await http.get(url);

    //   if (response.statusCode == 200) {
    //     final jsonResponse = json.decode(response.body);
    //     final List<dynamic> table = jsonResponse['Table'];
    //     List<SalesRule> data =
    //         table.map((item) => SalesRule.fromJson(item)).toList();
    //   } else {
    //     throw Exception('Failed to load data');
    //   }
    // }


    fetchDoctorsTypeInfo(String cpCode) async {
      print(
          'cpCode cpCode     cpCode cpCode=====================================');
      print(cpCode);
      try {
        // CustomerSettings/Proc_CustomerDoctorHelpListByApi?tery_UserId=1
        final url = Uri.parse(
            '${apiAccess.apiBaseUrl}/CustomerSettings/Proc_CustomerDoctorHelpListByApi?tery_UserId=${provider.user_id}');

        print(url);
        final response = await http.get(url);

        if (response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          print(
              'cpCode cpCode     cpCode cpCode=====================================');
          print(response.body);
          final List<dynamic> table = jsonResponse['Table'];
          print('fffffffffffffffffffffffffffffffffffffffffffff');
          print(table.first);
          List<DoctorListModel> listDoctor =
              table.map((item) => DoctorListModel.fromJson(item)).toList();
          print('fffffffffffffffffffffffffffffffffffffffffffff');
          print(listDoctor);

          doctorDropdown.value = listDoctor;
          print(doctorDropdown.value);
        } else {
          throw Exception('Failed to load data');
        }
      } catch (e) {}
    }

    Future<void> _showDropdownDialogDoctorsTypeInfo(
        BuildContext context) async {
      final selectedValue = await showModalBottomSheet<DoctorListModel>(
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
                        rows: doctorDropdown.value.map((item) {
                          return DataRow(
                            cells: [
                              DataCell(Text(item.custName), onTap: () {
                                Navigator.pop(context, item);
                              }),
                              DataCell(Text(item.custRefCode), onTap: () {
                                Navigator.pop(context, item);
                              }),
                              DataCell(Text(item.custRefCode), onTap: () {
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
        doctorDropdownvalue.value = selectedValue;
        // territoryCodeController.text = selectedValue.teryCode;
        // territoryNameController.text = selectedValue.teryName;
      }
    }

    Future<void> _showDropdownDialogCustomerTypeInfo(
        BuildContext context) async {}

    useEffect(() {
      fetchDoctorsTypeInfo(param_cpCode);
      fetchCustomerTypeInfo(param_cpCode);
    }, []);

    TextEditingController _creditLimitController = TextEditingController();
    TextEditingController typeNameController = TextEditingController();
    TextEditingController territoryCodeController = TextEditingController();
    TextEditingController territoryNameController = TextEditingController();
    TextEditingController customerNameController = TextEditingController();
    TextEditingController addressController = TextEditingController();
    TextEditingController mobileController = TextEditingController();
    TextEditingController categoryCodeController = TextEditingController();
    TextEditingController categoryNameController = TextEditingController();
    TextEditingController refCodeController = TextEditingController();
    TextEditingController refNameController = TextEditingController();
    TextEditingController rulesNoController = TextEditingController();
    TextEditingController rulesNameController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Customer Information Settings',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: MediaQuery.of(context).size.height * .022,
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
                  CustomTextFormField(
                    controller: typeNameController,
                    hint: "Type Name",
                    title: "Type Name",
                  ),
                  CustomTextFormField(
                    controller: territoryCodeController,
                    hint: 'Territory Code',
                    title: "Territory Code",
                  ),
                  CustomTextFormField(
                    controller: territoryNameController,
                    hint: "Territory Name",
                    title: "Territory Name",
                  ),
                  CustomTextFormField(
                    controller: customerNameController,
                    hint: "Customer Name",
                    title: "Customer Name",
                  ),
                  CustomTextFormField(
                    controller: addressController,
                    hint: 'Address',
                    title: "Address *",
                  ),
                  CustomTextFormField(
                    controller: mobileController,
                    hint: 'Mobile',
                    title: "Mobile *",
                  ),

                  TextFeildWithSearchBtn(
                    controller: categoryCodeController,
                    hint: 'Category Code',
                    title: "Category Code",
                    onPressed: () =>
                        _showDropdownDialogCustomerTypeInfo(context),
                  ),
                  CustomTextFormField(
                    controller: categoryNameController,
                    hint: 'Category Name',
                    title: "Category Name",
                  ),
                  TextFeildWithSearchBtn(
                    controller: refCodeController,
                    hint: 'Ref. Code',
                    title: "Ref. Code",
                    onPressed: () =>
                        _showDropdownDialogDoctorsTypeInfo(context),
                  ),
                  CustomTextFormField(
                    controller: refNameController,
                    hint: 'hint',
                    title: "Ref. Name",
                  ),
                  // TextFeildWithSearchBtn(
                  //   controller: rulesNoController,
                  //   hint: 'hint',
                  //   title: "Rules No.",
                  // ),
                  CustomTextFormField(
                    controller: rulesNameController,
                    hint: 'Rules Name.',
                    title: "Rules Name.",
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Row(
                          children: [
                            Text("Cash", style: TextStyle(color: Colors.black)),
                            Text(":", style: TextStyle(color: Colors.black)),
                            Radio(
                              value: true,
                              groupValue: 1,
                              //_paymentType,
                              onChanged: (value) {
                                // setState(() {
                                //   _paymentType = value;
                                // });
                              },
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Row(
                          children: [
                            Text("Credit",
                                style: TextStyle(color: Colors.black)),
                            Text(":", style: TextStyle(color: Colors.black)),
                            Radio(
                              value: false,
                              groupValue: 1,
                              onChanged: (value) {
                                // setState(() {
                                //   _paymentType = value;
                                // });
                              },
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Row(
                          children: [
                            Text("Limit ",
                                style: TextStyle(color: Colors.black)),
                            Text(":", style: TextStyle(color: Colors.black)),
                            Container(
                              width: 100,
                              child: TextField(
                                controller: _creditLimitController,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.0,
                                ),
                                decoration: InputDecoration(
                                  hintText: "0.00",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  suffixIcon: IconButton(
                                    icon: Icon(Icons.clear),
                                    onPressed: () {
                                      _creditLimitController.clear();
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
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
                              borderRadius:
                                  BorderRadius.circular(12), // <-- Radius
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                          ),
                          onPressed: () => {},
                          child: Text(
                            'SENT',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              fontSize:
                                  MediaQuery.of(context).size.height * .020,
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
                              borderRadius:
                                  BorderRadius.circular(12), // <-- Radius
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                          ),
                          onPressed: () =>
                              {Navigator.pop(context, '/salesmgt')},
                          child: Text(
                            'BACK',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              fontSize:
                                  MediaQuery.of(context).size.height * .020,
                            ),
                          ),
                        ),
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
}
