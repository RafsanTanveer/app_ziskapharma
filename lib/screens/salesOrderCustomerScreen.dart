import 'dart:convert';
import 'package:app_ziskapharma/model/CustomerSettingScreenArgs.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../dataaccess/apiAccess.dart' as apiAccess;
import '../model/customerListModel.dart';
import 'package:provider/provider.dart';
import 'package:app_ziskapharma/provider/auth_provider.dart';

Future<List<CustomerListModel>> fetchCustomerLists(
    String vCustomerTypeCode, String user_id) async {
  final url = Uri.parse(
      '${apiAccess.apiBaseUrl}/CustomerSettings/Proc_SingleTypeCustomerListByApi?tery_UserId=${user_id}&vCustomerTypeCode=$vCustomerTypeCode');

  print('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
  print(vCustomerTypeCode);
  final response = await http.get(url);

  if (response.statusCode == 200) {
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    List<dynamic> customerLists = jsonResponse['Table'];
    return customerLists.map((obj) => CustomerListModel.fromJson(obj)).toList();
  } else {
    throw Exception('Failed to load data');
  }
}

class SalesOrderCustomerScreen extends StatefulWidget {
  final String vCustomerTypeCode;

  const SalesOrderCustomerScreen({super.key, required this.vCustomerTypeCode});

  @override
  State<SalesOrderCustomerScreen> createState() =>
      _SalesOrderCustomerScreenState();
}

class _SalesOrderCustomerScreenState extends State<SalesOrderCustomerScreen> {
  late Future<List<CustomerListModel>> _customerLists;
  List<CustomerListModel> _allCustomers = [];
  List<CustomerListModel> _filteredCustomers = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    final provider = Provider.of<AuthProvider>(context, listen: false);



    super.initState();
    _customerLists =
        fetchCustomerLists(widget.vCustomerTypeCode, provider.user_id);
    _customerLists.then((value) {
      setState(() {
        _allCustomers = value;
        _filteredCustomers = value;
      });
    });

    _searchController.addListener(_filterCustomers);
  }

  void _filterCustomers() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredCustomers = _allCustomers.where((customer) {
        return customer.custNumber.toLowerCase().contains(query) ||
            customer.customerName.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
      body: Column(
        children: [
          _buildSearchBar(context),
          Expanded(
            child: FutureBuilder<List<CustomerListModel>>(
              future: _customerLists,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No data found'));
                } else {
                  return _buildDataTable();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * .7,
          margin: EdgeInsets.all(10),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search ... ',
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context, '/cutomergrouplistforsales');
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

  Widget _buildDataTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: _createColumns(),
        rows: _createRows(_filteredCustomers),
      ),
    );
  }

  List<DataColumn> _createColumns() {
    return [
      DataColumn(label: Text('Code')),
      DataColumn(label: Expanded(child: Text('Name'))),
      DataColumn(label: Text('Sales Order')),
    ];
  }

  List<DataRow> _createRows(List<CustomerListModel> customers) {
    return customers.map((customer) {
      return DataRow(cells: [
        DataCell(Text(customer.custNumber)),
        DataCell(
          Container(
            width: 100, // Adjust the width as needed
            child: Text(
              customer.customerName,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        DataCell(
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                '/salesOrder',
                arguments:new CustomerSettingScreenArgs( widget.vCustomerTypeCode, customer.customerName, customer.custNumber)

              );
            },
            child: Text(
              'Sales Order',
              style: TextStyle(
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
      ]);
    }).toList();
  }
}
