import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../dataaccess/apiAccess.dart' as apiAccess;
import '../model/customerCategoryModel.dart';

Future<List<CustomerCategory>> fetchCustomerCategory() async {
  final url = Uri.parse(
      '${apiAccess.apiBaseUrl}/CustomerSettings/Proc_sal_SalesCustomerTypeListByApi');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    List<dynamic> customerCategories = jsonResponse['Table'];

    return customerCategories
        .map((obj) => CustomerCategory.fromJson(obj))
        .toList();
  } else {
    throw Exception('Failed to load data');
  }
}

class CustomerGroupListSalesOrderScreen extends StatefulWidget {
  const CustomerGroupListSalesOrderScreen({super.key});

  @override
  State<CustomerGroupListSalesOrderScreen> createState() =>
      _CustomerGroupListSalesOrderScreenState();
}

class _CustomerGroupListSalesOrderScreenState
    extends State<CustomerGroupListSalesOrderScreen> {
  late Future<List<CustomerCategory>> _customerCategory;
  List<CustomerCategory> _allCategories = [];
  List<CustomerCategory> _filteredCategories = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _customerCategory = fetchCustomerCategory();
    _customerCategory.then((value) {
      setState(() {
        _allCategories = value;
        _filteredCategories = value;
      });
    });

    _searchController.addListener(_filterCustomerCategories);
  }

  void _filterCustomerCategories() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredCategories = _allCategories.where((category) {
        return category.cpCode.toLowerCase().contains(query) ||
            category.cpName.toLowerCase().contains(query);
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
          'Customer Group Sales Order',
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
            child: FutureBuilder<List<CustomerCategory>>(
              future: _customerCategory,
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
            Navigator.pop(context, '/salesmgt');
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
              borderRadius: BorderRadius.circular(12),
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
        rows: _createRows(_filteredCategories),
      ),
    );
  }

  List<DataColumn> _createColumns() {
    return [
      DataColumn(label: Text('Code')),
      DataColumn(label: Text('Name')),
      DataColumn(label: Text('New Customer')),
    ];
  }

  List<DataRow> _createRows(List<CustomerCategory> categories) {
    var filtered = categories
        .where((category) => !category.cpName.toLowerCase().contains("doctor"))
        .toList();
    return filtered.map((category) {
      return DataRow(cells: [
        DataCell(Text(category.cpCode)),
        DataCell(Text(category.cpName)),
        DataCell(
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                '/salesOrderCustomerlist',
                arguments: category.cpCode.toString(),
              );
            },
            child: Text(
              'Customer Name',
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
