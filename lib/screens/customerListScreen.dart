import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../dataaccess/apiAccess.dart' as apiAccess;
import '../model/customerListModel.dart';
import '../model/DoctorListModel2.dart';
import 'package:app_ziskapharma/provider/auth_provider.dart';
import 'package:app_ziskapharma/model/CustomerSettingScreenArgs.dart';
import 'package:app_ziskapharma/model/UserPreferences.dart';

Future<List<dynamic>> fetchCustomerLists(String vCustomerTypeCode,
    String userId, String custName, String teryDepotCode) async {
  final url = custName.toLowerCase().contains('doctor')
      ? Uri.parse(
          '${apiAccess.apiBaseUrl}/DoctorSettings/Proc_DoctorListByApi?SearchBy=&tery_DepotCode=${teryDepotCode}')
      : Uri.parse(
          '${apiAccess.apiBaseUrl}/CustomerSettings/Proc_SingleTypeCustomerListByApi?tery_UserId=${userId}&vCustomerTypeCode=$vCustomerTypeCode');

  final response = await http.get(url);

  if (response.statusCode == 200) {
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    List<dynamic> customerLists = jsonResponse['Table'];
    return custName.toLowerCase().contains('doctor')
        ? customerLists.map((obj) => DoctorListModel2.fromJson(obj)).toList()
        : customerLists.map((obj) => CustomerListModel.fromJson(obj)).toList();
  } else {
    throw Exception('Failed to load data');
  }
}

class CustomerListScreen extends HookWidget {
  const CustomerListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments
        as CustomerSettingScreenArgs?;
    if (args == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Customer List'),
          backgroundColor: Colors.greenAccent[400],
        ),
        body: Center(
          child: Text('Error: No arguments passed to this screen'),
        ),
      );
    }

    UserPreferences? userPreferences =
        context.watch<AuthProvider>().userPreferences;

    if (userPreferences == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Customer List'),
          backgroundColor: Colors.greenAccent[400],
        ),
        body: Center(
          child: Text('Error: User preferences not found'),
        ),
      );
    }

    final provider = Provider.of<AuthProvider>(context);
    final userId = provider.user_id ?? '';
    final customerListsFuture = useState<Future<List<dynamic>>?>(null);
    final allCustomers = useState<List<dynamic>>([]);
    final filteredCustomers = useState<List<dynamic>>([]);
    final searchController = useTextEditingController();

    useEffect(() {
      customerListsFuture.value = fetchCustomerLists(
          args.cpCode, userId, args.cpName, userPreferences.teryDepotCode);
      customerListsFuture.value!.then((value) {
        allCustomers.value = value;
        filteredCustomers.value = value;
      }).catchError((e) {
        print('Error fetching customer lists: $e');
      });

      searchController.addListener(() {
        String query = searchController.text.toLowerCase();
        filteredCustomers.value = allCustomers.value.where((customer) {
          if (customer is CustomerListModel) {
            return customer.customerName.toLowerCase().contains(query) ||
                customer.custNumber.toLowerCase().contains(query) ||
                customer.custMobile.toLowerCase().contains(query) ||
                customer.custAddress.toLowerCase().contains(query);
          } else if (customer is DoctorListModel2) {
            return customer.custName.toLowerCase().contains(query) ||
                customer.custNumber.toLowerCase().contains(query) ||
                customer.custMobile.toLowerCase().contains(query) ||
                customer.custAddress.toLowerCase().contains(query);
          }
          return false;
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
            child: FutureBuilder<List<dynamic>>(
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
            Navigator.pop(context, '/customergrouplist');
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

  Widget _buildDataTable(List<dynamic> filteredCustomers) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: DataTable(
          columns: _createColumns(filteredCustomers),
          rows: _createRows(filteredCustomers),
        ),
      ),
    );
  }

  List<DataColumn> _createColumns(List<dynamic> customers) {
    if (customers.isNotEmpty && customers.first is DoctorListModel2) {
      return [
        DataColumn(label: Text('Code')),
        DataColumn(label: Expanded(child: Text('Name'))),
        DataColumn(label: Expanded(child: Text('Mobile'))),
        DataColumn(label: Expanded(child: Text('Address'))),
        DataColumn(label: Expanded(child: Text('Territory'))),
        DataColumn(label: Expanded(child: Text('Depot'))),
      ];
    } else {
      return [
        DataColumn(label: Text('Code')),
        DataColumn(label: Expanded(child: Text('Name'))),
        DataColumn(label: Expanded(child: Text('Mobile'))),
        DataColumn(label: Expanded(child: Text('Address'))),
      ];
    }
  }

  List<DataRow> _createRows(List<dynamic> customers) {
    return customers.map((customer) {
      if (customer is CustomerListModel) {
        return DataRow(cells: [
          DataCell(Text(customer.custNumber)),
          DataCell(Text(customer.customerName)),
          DataCell(Text(customer.custMobile)),
          DataCell(Text(customer.custAddress)),
        ]);
      } else if (customer is DoctorListModel2) {
        return DataRow(cells: [
          DataCell(Text(customer.custNumber)),
          DataCell(Text(customer.custName)),
          DataCell(Text(customer.custMobile)),
          DataCell(Text(customer.custAddress)),
          DataCell(Text(customer.teryCode)),
          DataCell(Text(customer.teryDepotName)),
        ]);
      }
      return DataRow(cells: []);
    }).toList();
  }
}
