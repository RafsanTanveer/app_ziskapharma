import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:app_ziskapharma/model/UserPreferences.dart';
import 'package:app_ziskapharma/model/doctorListModel2.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:app_ziskapharma/custom_widgets/textFormField.dart';
import 'package:app_ziskapharma/model/CustomerSettingScreenArgs.dart';
import 'package:app_ziskapharma/model/UserModel.dart';
import 'package:app_ziskapharma/model/customerCategoryModel.dart';
import 'package:app_ziskapharma/model/customerTypeInfo.dart';
import 'package:app_ziskapharma/model/salesRule.dart';
import 'package:app_ziskapharma/model/territoryInfoModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/retry.dart';
import 'package:image_picker/image_picker.dart';
import '../dataaccess/apiAccess.dart' as apiAccess;
import '../model/DoctorListModel.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:app_ziskapharma/provider/auth_provider.dart';

class CustomerSettingScreen extends HookWidget {
  //final provider = Provider.of<AuthProvider>(context, listen: false);

  @override
  Widget build(BuildContext context) {
    final CustomerSettingScreenArgs args =
        ModalRoute.of(context)!.settings.arguments as CustomerSettingScreenArgs;

    final provider = Provider.of<AuthProvider>(context, listen: false);

    UserModel? user = context.watch<AuthProvider>().user;
    UserPreferences? userPreferences =
        context.watch<AuthProvider>().userPreferences;

    final customerTypeDropdownvalue = useState<CustomerTypeInfo?>(null);
    final customerTypeDropdown = useState<List<CustomerTypeInfo>>([]);

    final doctorDropdown = useState<List<DoctorListModel2>>([]);
    final doctorDropdownvalue = useState<DoctorListModel2?>(null);

    final territoryData = useState<TerritoryModel?>(null);

    final customerCategoryDropDown = useState<List<CustomerCategory>>([]);
    final customerCategoryDropDownValue = useState<CustomerCategory?>(null);

    final salesRuleDropDown = useState<List<SalesRule>>([]);
    final salesRuleDropDownValue = useState<SalesRule?>(null);

    final snapData = useState<String>('');

    final isCash = useState<String>('True');
    final isCredit = useState<String>('false');

    final _groupValue = useState<String>("Cash");

    final searchControllerCat = useTextEditingController();
    final searchControllerRef = useTextEditingController();
    final searchControllerRule = useTextEditingController();

    TextEditingController _creditLimitController = TextEditingController();
    TextEditingController typeNameController =
        TextEditingController(text: args.cpName);
    TextEditingController territoryCodeController =
        TextEditingController(text: territoryData.value?.teryCode);
    TextEditingController territoryNameController =
        TextEditingController(text: territoryData.value?.teryName);
    TextEditingController territoryController = TextEditingController(
        text:
            '${territoryData.value?.teryName} (${territoryData.value?.teryCode})');

    TextEditingController customerNameController = useTextEditingController();
    TextEditingController addressController = useTextEditingController();
    TextEditingController mobileController = useTextEditingController();
    TextEditingController contactPersonController = useTextEditingController();
    TextEditingController categoryCodeController = useTextEditingController();
    TextEditingController categoryNameController = useTextEditingController();
    TextEditingController refCodeController = useTextEditingController();
    TextEditingController refNameController = useTextEditingController();
    TextEditingController rulesNoController = useTextEditingController();
    TextEditingController rulesNameController = useTextEditingController();

    Future<void> _fetchData() async {
      try {
        final url = Uri.parse(
            '${apiAccess.apiBaseUrl}/SalesMobile/Proc_UserAreaInfoByApi?tery_UserId=${provider.user_id}');
        final response = await http.get(url);
        TerritoryModel terrytory = parseTerritoryFromJson(response.body);
        territoryData.value = terrytory;
      } catch (e) {}
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

          List<CustomerTypeInfo> listCustomer =
              table.map((item) => CustomerTypeInfo.fromJson(item)).toList();

          customerTypeDropdown.value = listCustomer;

          categoryCodeController.text = customerTypeDropdown.value.first.cpCode;
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

        customerCategoryDropDown.value = data;
      } else {
        throw Exception('Failed to load data');
      }
    }

    Future<void> fetchSalesRulesHelpListByApi() async {
      final url = Uri.parse(
          '${apiAccess.apiBaseUrl}/CustomerSettings/Proc_SalesRulesHelpListByApi');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final List<dynamic> table = jsonResponse['Table'];
        List<SalesRule> data =
            table.map((item) => SalesRule.fromJson(item)).toList();

        salesRuleDropDown.value = data;
      } else {
        throw Exception('Failed to load data');
      }
    }

    fetchDoctorsTypeInfo(String cpCode, String tery_depotCode) async {
      try {
        // CustomerSettings/Proc_CustomerDoctorHelpListByApi?tery_UserId=1
        final url = Uri.parse(
            '${apiAccess.apiBaseUrl}/DoctorSettings/Proc_DoctorListByApi?SearchBy=&tery_DepotCode=${tery_depotCode}');

        final response = await http.get(url);

        if (response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);

          final List<dynamic> table = jsonResponse['Table'];

          List<DoctorListModel2> listDoctor =
              table.map((item) => DoctorListModel2.fromJson(item)).toList();

          doctorDropdown.value = listDoctor;
        } else {
          throw Exception('Failed to load data');
        }
      } catch (e) {}
    }

    Future<void> _showDropdownDialogDoctorsTypeInfo(
        BuildContext context) async {
      await fetchDoctorsTypeInfo(args.cpCode, userPreferences!.teryDepotCode);
      searchControllerRef.text = '';
      final selectedValue = await showModalBottomSheet<DoctorListModel2>(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              List<DoctorListModel2> filteredList =
                  doctorDropdown.value.where((item) {
                final query = searchControllerRef.text.toLowerCase();
                return item.custName.toLowerCase().contains(query) ||
                    item.custNumber.toLowerCase().contains(query) ||
                    item.custAddress.toLowerCase().contains(query);
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
                              DataColumn(label: Text('Code')),
                              DataColumn(label: Text('Mobile')),
                              DataColumn(label: Text('Address')),
                              DataColumn(label: Text('Territory')),
                              DataColumn(label: Text('Depot')),
                            ],
                            rows: filteredList.map((item) {
                              return DataRow(
                                cells: [
                                  DataCell(Text(item.custName), onTap: () {
                                    Navigator.pop(context, item);
                                  }),
                                  DataCell(Text(item.custNumber), onTap: () {
                                    Navigator.pop(context, item);
                                  }),
                                  DataCell(Text(item.custMobile), onTap: () {
                                    Navigator.pop(context, item);
                                  }),
                                  DataCell(Text(item.custAddress), onTap: () {
                                    Navigator.pop(context, item);
                                  }),
                                  DataCell(Text(item.teryCode), onTap: () {
                                    Navigator.pop(context, item);
                                  }),
                                  DataCell(Text(item.teryDepotName), onTap: () {
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
        refNameController.text = selectedValue.custName;
        refCodeController.text = selectedValue.custNumber;
        // territoryNameController.text = selectedValue.teryName;
      }
    }

    Future<void> _showDropdownDialogCustomerTypeInfo(
        BuildContext context) async {
      await fetchCustomerCategoryHelpListByApi();
      searchControllerCat.text = '';
      final selectedValue = await showModalBottomSheet<CustomerCategory>(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              List<CustomerCategory> filteredList =
                  customerCategoryDropDown.value.where((item) {
                final queryCat = searchControllerCat.text.toLowerCase();
                return item.cpCode.toLowerCase().contains(queryCat) ||
                    item.cpName.toLowerCase().contains(queryCat);
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
                              DataColumn(label: Text('Code')),
                              DataColumn(label: Text('Name')),
                              //  DataColumn(label: Text('Id')),
                            ],
                            rows: filteredList.map((item) {
                              return DataRow(
                                cells: [
                                  DataCell(Text(item.cpCode), onTap: () {
                                    Navigator.pop(context, item);
                                  }),
                                  DataCell(Text(item.cpName), onTap: () {
                                    Navigator.pop(context, item);
                                  }),
                                  // DataCell(Text(item.cpID.toString()),
                                  //     onTap: () {
                                  //   Navigator.pop(context, item);
                                  // }),
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
        customerCategoryDropDownValue.value = selectedValue;
        await fetchSingleCustomerTypeInfo(selectedValue.cpCode);

        categoryCodeController.text =
            customerTypeDropdown.value.first.cpCode.toString();
        categoryNameController.text =
            customerTypeDropdown.value.first.cpName.toString();
      }
    }

    Future<void> _showDropdownDialogSalesRules(BuildContext context) async {
      await fetchSalesRulesHelpListByApi();
      searchControllerRule.text = '';
      final selectedValue = await showModalBottomSheet<SalesRule>(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              List<SalesRule> filteredList =
                  salesRuleDropDown.value.where((item) {
                final query = searchControllerRule.text.toLowerCase();
                return item.pbRulesNo.toLowerCase().contains(query) ||
                    item.pbRulesTypeName.toLowerCase().contains(query);
              }).toList();
              return Container(
                height: MediaQuery.of(context).size.height * 0.8,
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    AppBar(
                      title: Text('Select Sales Rule'),
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
                      controller: searchControllerRule,
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
                                DataColumn(label: Text('Rule No.')),
                                DataColumn(label: Text('Rule Type')),
                                DataColumn(label: Text('Rule ID')),
                              ],
                              rows: filteredList.map((item) {
                                return DataRow(
                                  cells: [
                                    DataCell(Text(item.pbRulesNo), onTap: () {
                                      Navigator.pop(context, item);
                                    }),
                                    DataCell(Text(item.pbRulesTypeName),
                                        onTap: () {
                                      Navigator.pop(context, item);
                                    }),
                                    DataCell(Text(item.pbID.toString()),
                                        onTap: () {
                                      Navigator.pop(context, item);
                                    }),
                                  ],
                                );
                              }).toList()),
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
        salesRuleDropDownValue.value = selectedValue;
        rulesNameController.text = selectedValue.pbRulesTypeName;
        rulesNoController.text = selectedValue.pbRulesNo;
        // Any additional updates you need to perform with the selected value
      }
    }

    Future<void> _pickImage() async {
      try {
        final pickedImage = await ImagePicker().pickImage(
            source: ImageSource.camera, maxHeight: 200, maxWidth: 200);
        if (pickedImage == null) return;

        final imageTemporary = File(pickedImage.path);
        Uint8List bytes = imageTemporary.readAsBytesSync();
        String base64Image = base64Encode(bytes);
        snapData.value = base64Image;
      } on PlatformException catch (e) {}
    }

    Future<void> _submitPost() async {
      final url = Uri.parse(
          '${apiAccess.apiBaseUrl}/CustomerSettings/Proc_SaveCustomerSettingsByApi');

      final headers = {"Content-Type": "application/json"};
      if (args.cpName.toLowerCase() != "doctor") {
        if (refCodeController.text != '') {
          if (isCredit.value == "true" &&
              (_creditLimitController.text == '' ||
                  _creditLimitController.text == 0)) {
            Fluttertoast.showToast(
              msg: 'Credit limit should not be 0',
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 18.0,
            );
          } else {
            final payload = json.encode({
              "Table": [
                {
                  'cust_ID': 0,
                  'cust_Number': "",
                  'cust_Name': customerNameController.text,
                  'cust_Address': addressController.text,
                  'cust_RefID': '',
                  'cust_RefCode': refCodeController.text,
                  'cust_RefName': refNameController.text,
                  'cust_ContractPerson': contactPersonController.text,
                  'cust_Mobile': mobileController.text,
                  'cust_BillingTypeCash': isCash.value.toString(),
                  'cust_BillingTypeCredit': isCredit.value.toString(),
                  'cust_BillingCreditLimit': _creditLimitController.text == ''
                      ? '0'
                      : _creditLimitController.text.trim(),
                  'cust_MultipleProjectYn': 'False',
                  'cust_SingleProjectYn': 'True',
                  'cust_TypeCode': args.cpCode,
                  'cust_TypeName': args.cpName,
                  'cust_CategoryCode': categoryCodeController
                      .text, //customerTypeDropdown.value.first.cpCode.toString(),
                  'cust_CategoryName': categoryNameController
                      .text, //customerTypeDropdown.value.first.cpName.toString(),
                  'tery_Code': territoryCodeController.text,
                  'tery_Name': territoryNameController.text,
                  'tery_DepotCode': territoryData.value?.teryDepotCode,
                  'cust_ReferenceYesNo':
                      customerTypeDropdownvalue.value!.cpReferenceYes != ''
                          ? 'True'
                          : 'False',
                  'pb_RulesNo': rulesNoController.text,
                  'cust_image': snapData.value,
                  'cust_CUID': provider.user_id,
                  'cust_MUID': provider.user_id,
                  'cust_ComID': user?.comID,
                  'cust_ComCode': user?.comCode,
                  'cust_ComName': user?.comName,
                }
              ]
            });
            try {
              final response =
                  await http.post(url, headers: headers, body: payload);
              if (response.statusCode == 200) {
                Fluttertoast.showToast(
                  msg: 'Customer Data Save Successfully',
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 18.0,
                );
                Navigator.pop(context);
              } else {}
            } catch (e) {}
          }
        } else {
          Fluttertoast.showToast(
            msg: 'Please set reference',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 18.0,
          );
        }
      } else {
        final payload = json.encode({
          "Table": [
            {
              'cust_ID': 0,
              'cust_Number': "",
              'cust_Name': customerNameController
                  .text, // doctorDropdownvalue.value?.custName,
              'cust_Address': addressController.text,
              'cust_RefID': '',
              'cust_RefCode': refCodeController.text,
              'cust_RefName': refNameController.text,
              'cust_ContractPerson': contactPersonController.text,
              'cust_Mobile': mobileController.text,
              'cust_BillingTypeCash': isCash.value.toString(),
              'cust_BillingTypeCredit': isCredit.value.toString(),
              'cust_BillingCreditLimit': _creditLimitController.text == ''
                  ? '0'
                  : _creditLimitController.text.trim(),
              'cust_MultipleProjectYn': 'False',
              'cust_SingleProjectYn': 'True',
              'cust_TypeCode': args.cpCode,
              'cust_TypeName': args.cpName,
              'cust_CategoryCode': categoryCodeController
                  .text, // customerTypeDropdown.value.first.cpCode.toString(),
              'cust_CategoryName': categoryNameController
                  .text, // customerTypeDropdown.value.first.cpName.toString(),
              'tery_Code': territoryCodeController.text,
              'tery_Name': territoryNameController.text,
              'tery_DepotCode': territoryData.value?.teryDepotCode,
              'cust_ReferenceYesNo':
                  customerTypeDropdownvalue.value!.cpReferenceYes != ''
                      ? 'Yes'
                      : 'No',
              'pb_RulesNo': rulesNoController.text,
              'cust_CUID': provider.user_id,
              'cust_MUID': provider.user_id,
              'cust_ComID': user?.comID,
              'cust_ComCode': user?.comCode,
              'cust_ComName': user?.comName,
            }
          ]
        });

        try {
          final response =
              await http.post(url, headers: headers, body: payload);
          if (response.statusCode == 200) {
            Fluttertoast.showToast(
              msg: 'Customer Data Save Successfully',
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 18.0,
            );
            Navigator.pop(context);
          } else {}
        } catch (e) {}
      }
    }

    useEffect(() {
      _fetchData();
      // fetchSingleCustomerTypeInfo(args.cpCode);
      fetchCustomerTypeInfo(args.cpCode);
    }, []);

    return SafeArea(
      child: Scaffold(
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
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * .35,
                          height: MediaQuery.of(context).size.width * .35,
                          margin: EdgeInsets.only(bottom: 15, right: 15),
                          child: ClipOval(
                            child: SizedBox.fromSize(
                              size: Size.fromRadius(48),
                              child: snapData.value != ''
                                  ? Image.memory(base64Decode(snapData.value))
                                  : Image.asset('assets/images/person.png'),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 15,
                          bottom: 15,
                          child: Container(
                            width: MediaQuery.of(context).size.width * .09,
                            height: MediaQuery.of(context).size.width * .09,
                            child: FloatingActionButton(
                              onPressed: _pickImage,
                              mini: true,
                              child: Icon(Icons.camera_alt),
                            ),
                          ),
                        ),
                      ],
                    ),
                    CustomTextFormFieldAreaSetting(
                      controller: typeNameController,
                      hint: "Type Name",
                      title: "Type Name",
                      isEnable: false,
                    ),
                    CustomTextFormFieldAreaSetting(
                      controller: territoryController,
                      hint: "Territory ",
                      title: "Territory",
                      isEnable: false,
                    ),
                    CustomTextFormFieldAreaSetting(
                      controller: territoryCodeController,
                      hint: 'Territory Code',
                      title: "Territory Code",
                      isEnable: false,
                      visibility: false,
                    ),
                    CustomTextFormFieldAreaSetting(
                      controller: territoryNameController,
                      hint: "Territory Name",
                      title: "Territory Name",
                      isEnable: false,
                      visibility: false,
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
                    CustomTextFormFieldWithFormatter(
                      controller: mobileController,
                      hint: 'Mobile',
                      title: "Mobile *",
                      keyboardType: TextInputType.phone,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                    CustomTextFormField(
                      controller: contactPersonController,
                      hint: 'Contact Person',
                      title: "Contact Person",
                    ),
                    TextFeildWithSearchBtn(
                      controller: categoryCodeController,
                      hint: 'Category Code',
                      title: "Category Code",
                      onPressed: () =>
                          _showDropdownDialogCustomerTypeInfo(context),
                      isEnable: false,
                    ),
                    CustomTextFormFieldAreaSetting(
                      controller: categoryNameController,
                      hint: 'Category Name',
                      title: "Category Name",
                      isEnable: false,
                    ),
                    TextFeildWithSearchBtn(
                      controller: refCodeController,
                      hint: 'Ref. Code',
                      title: "Ref. Code",
                      onPressed: () =>
                          _showDropdownDialogDoctorsTypeInfo(context),
                      isEnable: false,
                    ),
                    CustomTextFormField(
                      controller: refNameController,
                      hint: 'Ref. Name',
                      title: "Ref. Name",
                    ),
                    TextFeildWithSearchBtn(
                      controller: rulesNoController,
                      hint: 'Rules No.',
                      title: "Rules No.",
                      onPressed: () => _showDropdownDialogSalesRules(context),
                      isEnable: false,
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
                              Text("Cash :",
                                  style: TextStyle(color: Colors.black)),
                              Radio(
                                value: "Cash",
                                groupValue: _groupValue.value,
                                onChanged: (value) {
                                  _groupValue.value = value!;
                                  isCredit.value = "false";
                                  isCash.value = "true";
                                },
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Row(
                            children: [
                              Text("Credit :",
                                  style: TextStyle(color: Colors.black)),
                              Radio(
                                value: "Credit",
                                groupValue: _groupValue.value,
                                onChanged: (value) {
                                  _groupValue.value = value!;
                                  isCredit.value = "true";
                                  isCash.value = "false";
                                },
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 3,
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
                            onPressed: () => {_submitPost()},
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
      ),
    );
  }
}
