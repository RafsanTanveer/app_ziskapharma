import 'package:app_ziskapharma/custom_widgets/textFormField.dart';
import 'package:app_ziskapharma/model/customerTypeInfo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../dataaccess/apiAccess.dart' as apiAccess;
import '../model/DoctorListModel.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<CustomerTypeInfo> fetchCustomerTypeInfo(String cpCode) async {
  final url = Uri.parse(
      '${apiAccess.apiBaseUrl}/CustomerSettings/Proc_DisplaySingleCustomerTypeInfoByApi?cp_Code=$cpCode');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    final List<dynamic> table = jsonResponse['Table'];
    final Map<String, dynamic> data = table.first;
    return CustomerTypeInfo.fromJson(data);
  } else {
    throw Exception('Failed to load data');
  }
}

Future<DoctorListModel> fetchDoctorsTypeInfo(String cpCode) async {
  final url = Uri.parse(
      '${apiAccess.apiBaseUrl}/CustomerSettings/Proc_DisplaySingleCustomerTypeInfoByApi?cp_Code=$cpCode');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    final List<dynamic> table = jsonResponse['Table'];
    final Map<String, dynamic> data = table.first;
    return DoctorListModel.fromJson(data);
  } else {
    throw Exception('Failed to load data');
  }
}

class CustomerSettingScreen extends HookWidget {
  const CustomerSettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  CustomTextFormField(
                    controller: categoryCodeController,
                    hint: 'Category Code',
                    title: "Category Code",
                  ),
                  CustomTextFormField(
                    controller: categoryNameController,
                    hint: 'Category Name',
                    title: "Category Name",
                  ),
                  CustomTextFormField(
                    controller: refCodeController,
                    hint: 'Ref. Code',
                    title: "Ref. Code",
                  ),
                  CustomTextFormField(
                    controller: refNameController,
                    hint: 'hint',
                    title: "Ref. Name",
                  ),
                  CustomTextFormField(
                    controller: rulesNoController,
                    hint: 'hint',
                    title: "Rules No.",
                  ),
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
