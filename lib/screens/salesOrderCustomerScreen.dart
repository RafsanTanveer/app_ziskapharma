import 'dart:convert';
import 'package:app_ziskapharma/model/CustomerSettingScreenArgs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;
import '../dataaccess/apiAccess.dart' as apiAccess;
import '../model/customerListModel.dart';
import 'package:provider/provider.dart';
import 'package:app_ziskapharma/provider/auth_provider.dart';

Future<List<CustomerListModel>> fetchCustomerLists(
    String vCustomerTypeCode, String user_id) async {
  final url = Uri.parse(
      '${apiAccess.apiBaseUrl}/CustomerSettings/Proc_SingleTypeCustomerListByApi?tery_UserId=${user_id}&vCustomerTypeCode=$vCustomerTypeCode');

  final response = await http.get(url);

  if (response.statusCode == 200) {
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    List<dynamic> customerLists = jsonResponse['Table'];
    return customerLists.map((obj) => CustomerListModel.fromJson(obj)).toList();
  } else {
    throw Exception('Failed to load data');
  }
}

class SalesOrderCustomerScreen extends HookWidget {
  final String vCustomerTypeCode;

  const SalesOrderCustomerScreen({super.key, required this.vCustomerTypeCode});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthProvider>(context, listen: false);
    final customerListsFuture = useMemoized(
      () => fetchCustomerLists(vCustomerTypeCode, provider.user_id),
      [vCustomerTypeCode, provider.user_id],
    );
    final snapshot = useFuture(customerListsFuture);
    final searchController = useTextEditingController();
    final allCustomers = useState<List<CustomerListModel>>([]);
    final filteredCustomers = useState<List<CustomerListModel>>([]);

    useEffect(() {
      if (snapshot.connectionState == ConnectionState.done &&
          snapshot.hasData) {
        allCustomers.value = snapshot.data!;
        filteredCustomers.value = snapshot.data!;
      }
    }, [snapshot]);

    useEffect(() {
      void filterCustomers() {
        String query = searchController.text.toLowerCase();
        filteredCustomers.value = allCustomers.value.where((customer) {
          return customer.custNumber.toLowerCase().contains(query) ||
              customer.customerName.toLowerCase().contains(query);
        }).toList();
      }

      searchController.addListener(filterCustomers);
      return () => searchController.removeListener(filterCustomers);
    }, [searchController, allCustomers]);

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
          _buildSearchBar(context, searchController),
          Expanded(
            child: snapshot.connectionState == ConnectionState.waiting
                ? Center(child: CircularProgressIndicator())
                : snapshot.hasError
                    ? Center(child: Text('Error: ${snapshot.error}'))
                    : snapshot.hasData && snapshot.data!.isEmpty
                        ? Center(child: Text('No data found'))
                        : _buildDataTable(filteredCustomers.value, context),
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
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDataTable(
      List<CustomerListModel> customers, BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: DataTable(
          columns: _createColumns(),
          rows: _createRows(customers, context),
        ),
      ),
    );
  }

  List<DataColumn> _createColumns() {
    return [
       DataColumn(label: Text('Sales Order')),
      DataColumn(label: Text('Code')),
      DataColumn(label: Expanded(child: Text('Name'))),
       DataColumn(label: Expanded(child: Text('Address'))),
       DataColumn(label: Expanded(child: Text('Mobile'))),

    ];
  }

  List<DataRow> _createRows(
      List<CustomerListModel> customers, BuildContext context) {
    return customers.map((customer) {
      return DataRow(cells: [
        DataCell(
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                '/salesOrder',
                arguments: CustomerSettingScreenArgs(vCustomerTypeCode,
                    customer.customerName, customer.custNumber),
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
        DataCell(Text(customer.custNumber)),
        DataCell(Text(customer.custAddress)),
        DataCell(Text(customer.custMobile)),
        DataCell(
          Container(
            width: 100,
            child: Text(
              customer.customerName,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),

      ]);
    }).toList();
  }
}
