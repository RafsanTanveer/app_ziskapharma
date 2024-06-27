import 'dart:convert';
import 'package:app_ziskapharma/model/CustomerSettingScreenArgs.dart';
import 'package:app_ziskapharma/model/UserPreferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../dataaccess/apiAccess.dart' as apiAccess;
import '../model/customerListModel.dart';
import 'package:app_ziskapharma/provider/auth_provider.dart';

Future<List<CustomerListModel>> fetchCustomerLists(String vCustomerTypeCode,
    String user_id, String custName, String tery_depotCode) async {
  if (custName.toLowerCase().contains('doctor')) {
    final url = Uri.parse(
        '${apiAccess.apiBaseUrl}/DoctorSettings/Proc_DoctorListByApi?SearchBy=&tery_DepotCode=${tery_depotCode}');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      List<dynamic> customerLists = jsonResponse['Table'];
      return customerLists
          .map((obj) => CustomerListModel.fromJson(obj))
          .toList();
    } else {
      throw Exception('Failed to load data');
    }
  } else {
    final url = Uri.parse(
        '${apiAccess.apiBaseUrl}/CustomerSettings/Proc_SingleTypeCustomerListByApi?tery_UserId=${user_id}&vCustomerTypeCode=$vCustomerTypeCode');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      List<dynamic> customerLists = jsonResponse['Table'];
      return customerLists
          .map((obj) => CustomerListModel.fromJson(obj))
          .toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
}

class CustomerListScreen extends HookWidget {
  // final String vCustomerTypeCode;

  const CustomerListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomerSettingScreenArgs args =
        ModalRoute.of(context)!.settings.arguments as CustomerSettingScreenArgs;

    UserPreferences? userPreferences =
        context.watch<AuthProvider>().userPreferences;

    final provider = Provider.of<AuthProvider>(context);
    final user_id = provider.user_id;
    final customerListsFuture =
        useState<Future<List<CustomerListModel>>?>(null);
    final custList = useState<List<CustomerListModel>>([]);
    final allCustomers = useState<List<CustomerListModel>>([]);
    final filteredCustomers = useState<List<CustomerListModel>>([]);
    final searchController = useTextEditingController();

    useEffect(() {
      customerListsFuture.value = fetchCustomerLists(
          args.cpCode, user_id, args.cpName, userPreferences!.teryDepotCode);
      customerListsFuture.value!.then((value) {
        allCustomers.value = value;
        filteredCustomers.value = value;
      });

      searchController.addListener(() {
        String query = searchController.text.toLowerCase();
        filteredCustomers.value = allCustomers.value.where((customer) {
          return customer.customerName.toLowerCase().contains(query) ||
              customer.custNumber.toLowerCase().contains(query) ||
              customer.custMobile.toLowerCase().contains(query) ||
              customer.custAddress.toLowerCase().contains(query);
        }).toList();
      });

      return null;
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Customer List',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: Colors.greenAccent[400],
      ),
      body: Column(
        children: [
          _buildSearchBar(context, searchController),
          Expanded(
            child: FutureBuilder<List<CustomerListModel>>(
              future: customerListsFuture.value,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No data found'));
                } else {
                  return _buildDataTable(filteredCustomers.value);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(
      BuildContext context, TextEditingController searchController) {
    return Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * .7,
          margin: EdgeInsets.all(10),
          child: TextField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: 'Search ... ',
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context, '/cutomergrouplist');
          },
          child: Text(
            'Close',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: MediaQuery.of(context).size.width * .040,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            elevation: 10,
            minimumSize: Size(MediaQuery.of(context).size.width * .2,
                MediaQuery.of(context).size.height * .055),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // <-- Radius
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDataTable(List<CustomerListModel> filteredCustomers) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: _createColumns(),
        rows: _createRows(filteredCustomers),
      ),
    );
  }

  List<DataColumn> _createColumns() {
    return [
      DataColumn(label: Text('Code')),
      DataColumn(label: Expanded(child: Text('Name'))),
      DataColumn(label: Expanded(child: Text('Mobile'))),
      DataColumn(label: Expanded(child: Text('Address'))),
    ];
  }

  List<DataRow> _createRows(List<CustomerListModel> customers) {
    return customers.map((customer) {
      return DataRow(cells: [
        DataCell(Text(customer.custNumber)),
        DataCell(Text(customer.customerName)),
        DataCell(Text(customer.custMobile)),
        DataCell(Text(customer.custAddress)),
      ]);
    }).toList();
  }
}
