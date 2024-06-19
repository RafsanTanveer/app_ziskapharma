import 'dart:convert';

import 'package:app_ziskapharma/custom_widgets/textFormField.dart';
import 'package:app_ziskapharma/model/CustomerSettingScreenArgs.dart';
import 'package:app_ziskapharma/model/DoctorListModel.dart';
import 'package:app_ziskapharma/model/UserModel.dart';
import 'package:app_ziskapharma/model/territoryInfoModel.dart';
import 'package:app_ziskapharma/model/terrytorydropdownModel.dart';
import 'package:app_ziskapharma/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import '../dataaccess/apiAccess.dart' as apiAccess;
import 'package:http/http.dart' as http;

class SalesOrderScreen extends HookWidget {


  @override
  Widget build(BuildContext context) {


    final CustomerSettingScreenArgs args =
        ModalRoute.of(context)!.settings.arguments as CustomerSettingScreenArgs;

    UserModel? user = context.watch<AuthProvider>().user;

    final provider = Provider.of<AuthProvider>(context, listen: false);
    final territoryData = useState<TerritoryModel?>(null);
    final dropdownvalue = useState<TerritoryDropDownlModel?>(null);
    final terryDropdown = useState<List<TerritoryDropDownlModel>>([]);

    final doctorDropdown = useState<List<DoctorListModel>>([]);
    final doctorDropdownvalue = useState<DoctorListModel?>(null);

    final searchControllerRef = useTextEditingController();

    final depoNameController = useTextEditingController();
    final depoCodeController = useTextEditingController();
    final orderDateController = useTextEditingController();
    final deliveryDateController = useTextEditingController();
    final orderNoController = useTextEditingController();
    final customerCodeController = useTextEditingController();
    final customerNameController = useTextEditingController();
    final deliveryDepotCodeController = useTextEditingController();
    final deliveryDepotNameController = useTextEditingController();
    final refCodeController = useTextEditingController();
    final refNameController = useTextEditingController();

    fetchDoctorsTypeInfo(String cpCode) async {
      print(cpCode);
      try {
        // CustomerSettings/Proc_CustomerDoctorHelpListByApi?tery_UserId=1
        final url = Uri.parse(
            '${apiAccess.apiBaseUrl}/CustomerSettings/Proc_CustomerDoctorHelpListByApi?tery_UserId=${provider.user_id}');

        print(url);
        final response = await http.get(url);

        if (response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);

          print(response.body);
          final List<dynamic> table = jsonResponse['Table'];

          print(table.first);
          List<DoctorListModel> listDoctor =
              table.map((item) => DoctorListModel.fromJson(item)).toList();

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
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              List<DoctorListModel> filteredList =
                  doctorDropdown.value.where((item) {
                final query = searchControllerRef.text.toLowerCase();
                return item.custName.toLowerCase().contains(query) ||
                    item.custRefCode.toLowerCase().contains(query) ||
                    item.custRefCode.toLowerCase().contains(query);
              }).toList();

              return Container(
                height: MediaQuery.of(context).size.height * 0.8,
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    AppBar(
                      title: Text('Select Doctor'),
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
                    TextField(
                      controller: searchControllerRef,
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        prefixIcon: Icon(Icons.search),
                      ),
                      onChanged: (text) {
                        setState(() {});
                      },
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
                                label: Text('Territory Code'),
                              ),
                            ],
                            rows: filteredList.map((item) {
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
        },
      );

      // Ensure that the UI is updated after receiving the selected value
      if (selectedValue != null) {
        doctorDropdownvalue.value = selectedValue;
        refNameController.text = selectedValue.custRefName;
        refCodeController.text = selectedValue.custRefCode;
        // territoryNameController.text = selectedValue.teryName;
      }
    }

    Future<void> _fetchDepotData() async {
      try {
        final url = Uri.parse(
            '${apiAccess.apiBaseUrl}/SalesMobile/Proc_UserAreaInfoByApi?tery_UserId=${provider.user_id}');
        final response = await http.get(url);
        TerritoryModel terrytory = parseTerritoryFromJson(response.body);
        territoryData.value = terrytory;
        // await _fetchDropDownData();

        // Set the initial values for the text controllers

        depoNameController.text = territoryData.value!.teryDepotName;
        depoCodeController.text = territoryData.value!.teryDepotCode;
      } catch (e) {
        print('Error fetching data: $e');
      }
    }

    useEffect(() {
      _fetchDepotData();
       fetchDoctorsTypeInfo(args!.cpCode);
    }, []);

    final productFields = [
      useTextEditingController(),
      useTextEditingController(),
      useTextEditingController(),
      useTextEditingController(),
      useTextEditingController(),
    ];
    final products = useState<List<Map<String, String>>>([]);

    Future<void> _selectDate(
        BuildContext context, TextEditingController controller) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
      );
      if (picked != null) {
        controller.text = "${picked.toLocal()}".split(' ')[0];
      }
    }

    void _openProductModal() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Add Product'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (int i = 0; i < productFields.length; i++)
                  CustomTextFormFieldAreaSetting(
                    controller: productFields[i],
                    hint: 'Field ${i + 1}',
                    title: 'Field ${i + 1}',
                    isEnable: true,
                  ),
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  final product = {
                    'field1': productFields[0].text,
                    'field2': productFields[1].text,
                    'field3': productFields[2].text,
                    'field4': productFields[3].text,
                    'field5': productFields[4].text,
                  };
                  products.value = [...products.value, product];
                  for (var controller in productFields) {
                    controller.clear();
                  }
                  Navigator.of(context).pop();
                },
                child: Text('Add'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Close'),
              ),
            ],
          );
        },
      );
    }

    void _editProduct(int index) {
      final product = products.value[index];
      for (int i = 0; i < productFields.length; i++) {
        productFields[i].text = product['field${i + 1}']!;
      }
      products.value = [
        ...products.value..removeAt(index),
      ];
      _openProductModal();
    }

    void _deleteProduct(int index) {
      products.value = [
        ...products.value..removeAt(index),
      ];
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sales Order',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: Colors.greenAccent[400],
      ),
      body: Scrollbar(
        thumbVisibility: true,
        thickness: 15,
        interactive: true,
        radius: Radius.circular(20),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextFormFieldAreaSetting(
                controller: depoNameController,
                hint: "Depot Name",
                title: "Depot Name",
                isEnable: false,
              ),
              CustomTextFormFieldAreaSetting(
                controller: depoCodeController,
                hint: "Depot Code",
                title: "Depot Code",
                isEnable: false,
              ),
              SizedBox(height: 16.0),
              GestureDetector(
                onTap: () => _selectDate(context, orderDateController),
                child: AbsorbPointer(
                  child: CustomTextFormFieldAreaSetting(
                    controller: orderDateController,
                    hint: "Select Date",
                    title: "Order Date",
                    isEnable: true,
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              GestureDetector(
                onTap: () => _selectDate(context, deliveryDateController),
                child: AbsorbPointer(
                  child: CustomTextFormFieldAreaSetting(
                    controller: deliveryDateController,
                    hint: "Delivery Date",
                    title: "Delivery Date",
                    isEnable: true,
                  ),
                ),
              ),
              CustomTextFormFieldAreaSetting(
                controller: orderNoController,
                hint: "Order No",
                title: "Order No",
                isEnable: false,
              ),
              TextFeildWithSearchBtn(
                controller: customerCodeController,
                hint: "Customer Code",
                title: "Customer Code",
                onPressed: () => {},
              ),
              CustomTextFormFieldAreaSetting(
                controller: customerNameController,
                hint: "Customer Name",
                title: "Customer Name",
                isEnable: false,
              ),
              TextFeildWithSearchBtn(
                controller: deliveryDepotCodeController,
                hint: "Delivery Depot Code",
                title: "Delivery Depot Code",
                onPressed: () => {},
              ),
              CustomTextFormFieldAreaSetting(
                controller: deliveryDepotNameController,
                hint: "Delivery Depot Name",
                title: "Delivery Depot Name",
                isEnable: false,
              ),
              TextFeildWithSearchBtn(
                controller: refCodeController,
                hint: "Ref Code",
                title: "Ref Code",
                onPressed: () => {_showDropdownDialogDoctorsTypeInfo(context)},
              ),
              CustomTextFormFieldAreaSetting(
                controller: refNameController,
                hint: "Ref Name",
                title: "Ref Name",
                isEnable: false,
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _openProductModal,
                child: Text('Add Product'),
              ),
              SizedBox(height: 16.0),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: DataTable(
                    columns: [
                      DataColumn(label: Text('Field 1')),
                      DataColumn(label: Text('Field 2')),
                      DataColumn(label: Text('Field 3')),
                      DataColumn(label: Text('Field 4')),
                      DataColumn(label: Text('Field 5')),
                      DataColumn(label: Text('Actions')),
                    ],
                    rows: products.value
                        .asMap()
                        .entries
                        .map(
                          (entry) => DataRow(
                            cells: [
                              DataCell(Text(entry.value['field1']!)),
                              DataCell(Text(entry.value['field2']!)),
                              DataCell(Text(entry.value['field3']!)),
                              DataCell(Text(entry.value['field4']!)),
                              DataCell(Text(entry.value['field5']!)),
                              DataCell(
                                Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.edit),
                                      onPressed: () => _editProduct(entry.key),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.delete),
                                      onPressed: () => _deleteProduct(entry.key),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
