import 'dart:convert';

import 'package:app_ziskapharma/custom_widgets/textFormField.dart';
import 'package:app_ziskapharma/model/CustomerSettingScreenArgs.dart';
import 'package:app_ziskapharma/model/DoctorListModel.dart';
import 'package:app_ziskapharma/model/UserModel.dart';
import 'package:app_ziskapharma/model/UserPreferences.dart';
import 'package:app_ziskapharma/model/branchModel.dart';
import 'package:app_ziskapharma/model/customerCategoryModel.dart';
import 'package:app_ziskapharma/model/customerListModel.dart';
import 'package:app_ziskapharma/model/productModel.dart';
import 'package:app_ziskapharma/model/territoryInfoModel.dart';
import 'package:app_ziskapharma/model/terrytorydropdownModel.dart';
import 'package:app_ziskapharma/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../dataaccess/apiAccess.dart' as apiAccess;
import 'package:http/http.dart' as http;

class SalesOrderScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final CustomerSettingScreenArgs args =
        ModalRoute.of(context)!.settings.arguments as CustomerSettingScreenArgs;

    UserModel? user = context.watch<AuthProvider>().user;
    UserPreferences? userPreferences =
        context.watch<AuthProvider>().userPreferences;

    final provider = Provider.of<AuthProvider>(context, listen: false);
    final territoryData = useState<TerritoryModel?>(null);
    final dropdownvalue = useState<TerritoryDropDownlModel?>(null);
    final terryDropdown = useState<List<TerritoryDropDownlModel>>([]);

    final doctorDropdown = useState<List<DoctorListModel>>([]);
    final doctorDropdownvalue = useState<DoctorListModel?>(null);

    final customerListDropDown = useState<List<CustomerListModel>>([]);
    final customerListDropDownValue = useState<CustomerListModel?>(null);

    final branchValue = useState<Branch?>(null);
    final branchDropdown = useState<List<Branch>>([]);
    final filteredBranches = useState<List<Branch>>([]);

    final productValue = useState<Product?>(null);
    final productDropdown = useState<List<Product>>([]);
    final filteredProduct = useState<List<Product>>([]);

    final searchControllerRef = useTextEditingController();
    final searchControllerCat = useTextEditingController();
    final searchController = useTextEditingController();

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

    final slNo = useState<int>(0);

    final productFields = [
      useTextEditingController(),
      useTextEditingController(),
      useTextEditingController(),
      useTextEditingController(),
      useTextEditingController(),
    ];
    final products = useState<List<Map<String, String>>>([]);

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

//////////////////////////////////Customer List/////////////////////////////////////////////////
    fetchCustomerLists(String vCustomerTypeCode, String user_id) async {
      final url = Uri.parse(
          '${apiAccess.apiBaseUrl}/CustomerSettings/Proc_SingleTypeCustomerListByApi?tery_UserId=${user_id}&vCustomerTypeCode=$vCustomerTypeCode');

      print('&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&');
      print(url);
      print(vCustomerTypeCode);
      final response = await http.get(url);

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        List<dynamic> customerLists = jsonResponse['Table'];
        customerListDropDown.value = customerLists
            .map((obj) => CustomerListModel.fromJson(obj))
            .toList();
      } else {
        throw Exception('Failed to load data');
      }
    }

    Future<void> _showDropdownDialogCustomerTypeInfo(
        BuildContext context) async {
      final selectedValue = await showModalBottomSheet<CustomerListModel>(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              List<CustomerListModel> filteredList =
                  customerListDropDown.value.where((item) {
                final queryCat = searchControllerCat.text.toLowerCase();
                return item.customerName.toLowerCase().contains(queryCat) ||
                    item.custID.toString().toLowerCase().contains(queryCat);
              }).toList();

              return Container(
                height: MediaQuery.of(context).size.height * 0.8,
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    AppBar(
                      title: Text('Select Category'),
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
                      controller: searchControllerCat,
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
                              DataColumn(label: Text('Customer Id')),
                            ],
                            rows: filteredList.map((item) {
                              return DataRow(
                                cells: [
                                  DataCell(Text(item.customerName), onTap: () {
                                    Navigator.pop(context, item);
                                  }),
                                  DataCell(Text(item.custNumber), onTap: () {
                                    Navigator.pop(context, item);
                                  }),
                                  DataCell(Text(item.custID.toString()),
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
        },
      );
      if (selectedValue != null) {
        customerListDropDownValue.value = selectedValue;
        // await fetchSingleCustomerTypeInfo(selectedValue.cpCode);

        customerCodeController.text =
            customerListDropDownValue.value!.custID.toString();

        customerNameController.text =
            customerListDropDownValue.value!.customerName;

        // categoryCodeController.text =
        //     customerTypeDropdown.value.first.cpCode.toString();
        // categoryNameController.text =
        //     customerTypeDropdown.value.first.cpName.toString();
      }
    }

//////////////////////////////////Customer List/////////////////////////////////////////////////

//////////////////////////////////Depo List/////////////////////////////////////////////////
    Future<void> _showDepoDropdownDialog(BuildContext context) async {
      final selectedValue = await showModalBottomSheet<Branch>(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              final query = searchController.text.toLowerCase();
              List<Branch> filteredList = branchDropdown.value
                  .where((branch) =>
                      branch.brnName!
                          .toLowerCase()
                          .contains(query.toLowerCase()) ||
                      branch.brnCode!
                          .toLowerCase()
                          .contains(query.toLowerCase()))
                  .toList();
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          labelText: 'Search Branch',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          setState(() {});
                        },
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: ValueListenableBuilder<List<Branch>>(
                            valueListenable: filteredBranches,
                            builder: (context, branches, child) {
                              return DataTable(
                                columns: const [
                                  DataColumn(label: Text('Name')),
                                  DataColumn(label: Text('Code')),
                                  DataColumn(label: Text('Branch Address')),
                                ],
                                rows: filteredList.map((item) {
                                  return DataRow(
                                    cells: [
                                      DataCell(Text(item.brnName.toString()),
                                          onTap: () {
                                        Navigator.pop(context, item);
                                      }),
                                      DataCell(Text(item.brnCode.toString()),
                                          onTap: () {
                                        Navigator.pop(context, item);
                                      }),
                                      DataCell(
                                          Text(item.brnAddress1.toString()),
                                          onTap: () {
                                        Navigator.pop(context, item);
                                      }),
                                    ],
                                  );
                                }).toList(),
                              );
                            },
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

      if (selectedValue != null) {
        branchValue.value = selectedValue;
        deliveryDepotCodeController.text = selectedValue.brnCode.toString();
        deliveryDepotNameController.text = selectedValue.brnName.toString();

        //deliveryDepotCodeController
// deliveryDepotNameController
      }
    }

    Future<void> _fetchDepo() async {
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

//////////////////////////////////Depo List/////////////////////////////////////////////////

//////////////////////////////////Depo List/////////////////////////////////////////////////
    Future<void> _showProductDropdownDialog(BuildContext context) async {
      final selectedValue = await showModalBottomSheet<Product>(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              final query = searchController.text.toLowerCase();
              List<Product> filteredList = productDropdown.value
                  .where((product) =>
                      product.finPrdName!
                          .toLowerCase()
                          .contains(query.toLowerCase()) ||
                      product.finPrdCode!
                          .toLowerCase()
                          .contains(query.toLowerCase()))
                  .toList();
              return Container(
                height: MediaQuery.of(context).size.height * 0.8,
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    AppBar(
                      title: Text('Select Product'),
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          labelText: 'Search Product',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          setState(() {});
                        },
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: ValueListenableBuilder<List<Product>>(
                            valueListenable: filteredProduct,
                            builder: (context, branches, child) {
                              return DataTable(
                                columns: const [
                                  DataColumn(label: Text('Name')),
                                  DataColumn(label: Text('Code')),
                                  DataColumn(label: Text('Pack Size')),
                                  DataColumn(label: Text('Quantity')),
                                ],
                                rows: filteredList.map((item) {
                                  return DataRow(
                                    cells: [
                                      DataCell(Text(item.finPrdName.toString()),
                                          onTap: () {
                                        Navigator.pop(context, item);
                                      }),
                                      DataCell(Text(item.finPrdCode.toString()),
                                          onTap: () {
                                        Navigator.pop(context, item);
                                      }),
                                      DataCell(Text(item.finPrdPackSize),
                                          onTap: () {
                                        Navigator.pop(context, item);
                                      }),
                                      DataCell(Text(item.orderQnty.toString()),
                                          onTap: () {
                                        Navigator.pop(context, item);
                                      }),
                                    ],
                                  );
                                }).toList(),
                              );
                            },
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

      if (selectedValue != null) {
        productValue.value = selectedValue;

        final product = {
          'field1': '',
          'Code': productValue.value!.finPrdCode,
          'Name': productValue.value!.finPrdName,
          'PackSize': productValue.value!.finPrdPackSize,
          'Quantity': '1' //productValue.value!.orderQnty.toString(),
        };
        products.value = [...products.value, product];
      }
    }

    Future<void> _fetchProduct() async {
      final url = Uri.parse(
          '${apiAccess.apiBaseUrl}/SalesOrder/Proc_ProductListSingleMarketByApi?sd_MarketTypeCode=${userPreferences?.teryMarketTypeCode}');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        List<dynamic> products = jsonResponse['Table'];
        List<Product> product =
            products.map((obj) => Product.fromJson(obj)).toList();

        productDropdown.value = product;
      } else {
        throw Exception('Failed to load data');
      }
    }

//////////////////////////////////Product List/////////////////////////////////////////////////

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

    Future<void> _saveSalesOrder() async {
      print('7777777777777777777777777777777');
      if (products.value.length == 0) {
        Fluttertoast.showToast(
          msg: 'Please select at least 1 product',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          // backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 18.0,
        );
      }
      else
      {
final url = Uri.parse(
            '${apiAccess.apiBaseUrl}/SalesOrder/Proc_SaveSalesOrderByApi');
        final headers = {"Content-Type": "application/json"};

        final mainOrderData = {
          "StoreMain_ID": 0,
          "StoreMain_OrderDate": orderDateController.text,
          "StoreMain_DeliveryDate": deliveryDateController.text,
          "StoreMain_OrderNo": "",
          "StoreMain_CustomerCode": customerCodeController.text.trim(),
          "StoreMain_InputPlace": "Mobile SALES ORDER",
          "StoreMain_RefCode": refCodeController.text.trim(),
          "tery_DepotCode": depoCodeController.text,
          "StoreMain_BrCode": userPreferences?.userBrnCode ?? '',
          "StoreMain_CUID": userPreferences?.userUID ?? '',
          "StoreMain_MUID": userPreferences?.userUID ?? '',
          "StoreMain_ComID": user?.comID ?? '',
          "StoreMain_ComCode": user?.comCode ?? '',
          "StoreMain_ComName": user?.comName ?? ''
        };

        final productDetails = products.value.asMap().entries.map((entry) {
          return {
            "Prd_slDetails": entry.key + 1,
            "Prd_Code": entry.value['Code']!,
            "Prd_Name": entry.value['Name']!,
            "Prd_PackSize": entry.value['PackSize']!,
            "Prd_Quantity": entry.value['Quantity']!
          };
        }).toList();

        final payload = {
          "Table": [mainOrderData],
          "Details": productDetails
        };

        final payloadJson = json.encode(payload);

        try {
          final response = await http.post(
            url,
            headers: headers,
            body: payloadJson,
          );

          if (response.statusCode == 200) {
            final result = json.decode(response.body);
            if (result.toString().toUpperCase() == "TRUE") {
              print("Successfully saved the sales order.");

              Navigator.pop(context);

              Fluttertoast.showToast(
                msg: 'Order successfully saved',
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                // backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 18.0,
              );
            } else {
              print("Failed to save the sales order: $result");
            }
          } else {
            print(
                "Failed to save the sales order. HTTP Status: ${response.statusCode}");
          }
        } catch (e) {
          print("Failed to save the sales order. Error: $e");
        }
      }
      // Define the URL and headers

    }

    useEffect(() {
      _fetchDepotData();
      fetchDoctorsTypeInfo(args!.cpCode);
      fetchCustomerLists(args!.cpCode, provider.user_id);
      _fetchDepo();
      _fetchProduct();
    }, []);

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
                    'Code': productFields[1].text,
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
                onPressed: () => {_showDropdownDialogCustomerTypeInfo(context)},
                isEnable: false,
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
                onPressed: () => {_showDepoDropdownDialog(context)},
                isEnable: false,
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
                isEnable: false,
              ),
              CustomTextFormFieldAreaSetting(
                controller: refNameController,
                hint: "Ref Name",
                title: "Ref Name",
                isEnable: false,
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 3,
                  maximumSize: Size(150, 150),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                ),
                onPressed: () => _showProductDropdownDialog(context),
                child: Text('Add Product'),
              ),
              SizedBox(height: 16.0),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: DataTable(
                    columns: [
                      DataColumn(label: Text('SL')),
                      DataColumn(label: Text('Code')),
                      DataColumn(label: Text('Name')),
                      DataColumn(label: Text('Pack Size')),
                      DataColumn(label: Text('Quantity')),
                      DataColumn(label: Text('Actions')),
                    ],
                    rows: products.value
                        .asMap()
                        .entries
                        .map(
                          (entry) => DataRow(
                            cells: [
                              DataCell(Text((entry.key + 1).toString())),
                              DataCell(Text(entry.value['Code']!)),
                              DataCell(Text(entry.value['Name']!)),
                              DataCell(Text(entry.value['PackSize']!)),
                              DataCell(TextField(
                                controller: TextEditingController(
                                    text: entry.value['Quantity']!),
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  if ((double.tryParse(
                                          entry.value['Quantity']!)!) >
                                      1.0) {
                                    entry.value['Quantity'] = value;
                                  } else {
                                    Fluttertoast.showToast(
                                      msg: 'Quantity must be greater than 0',
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      // backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 18.0,
                                    );
                                  }
                                },
                              )),
                              DataCell(
                                Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.delete),
                                      onPressed: () =>
                                          _deleteProduct(entry.key),
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
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(right: 10),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        elevation: 3,
                        maximumSize: Size(150, 150),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => _saveSalesOrder(),
                    child: Text(
                      'Save',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      elevation: 3,
                      maximumSize: Size(150, 150),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
