import 'package:app_ziskapharma/model/CustomerSettingScreenArgs.dart';
import 'package:app_ziskapharma/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:app_ziskapharma/model/SalesInvoice.dart';
import 'package:app_ziskapharma/model/UserPreferences.dart';
import 'package:app_ziskapharma/dataaccess/apiAccess.dart' as apiAccess;

import 'package:provider/provider.dart';

class SalesInvoiceScreen extends HookWidget {
  const SalesInvoiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Hook for managing the search controller
    final searchController = useTextEditingController();
    final filteredInvoices = useState<List<SalesInvoiceList>>([]);

    UserPreferences? userPreferences =
        context.watch<AuthProvider>().userPreferences;

    // Hook for managing the future of sales invoices
    final futureSalesInvoices = useMemoized(
        () => _initializeSalesInvoices(userPreferences!.teryDepotCode!), []);

    useEffect(() {
      // Listener to filter invoices based on search query
      void _filterInvoices() {
        final query = searchController.text.toLowerCase();
        futureSalesInvoices.then((invoices) {
          filteredInvoices.value = invoices
              .where((invoice) =>
                  invoice.invoiceNo.toLowerCase().contains(query) ||
                  invoice.invoiceDate.toLowerCase().contains(query) ||
                  invoice.customerName.toLowerCase().contains(query) ||
                  invoice.totalBillAmount
                      .toString()
                      .toLowerCase()
                      .contains(query))
              .toList();
        }).catchError((error) {
          print('Error filtering invoices: $error');
        });
      }

      searchController.addListener(_filterInvoices);
      return () => searchController.removeListener(_filterInvoices);
    }, [searchController, futureSalesInvoices]);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sales Invoice',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: Colors.greenAccent[400],
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(10),
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: 'Search ... ',
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
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
                  minimumSize: Size(
                    MediaQuery.of(context).size.width * .2,
                    MediaQuery.of(context).size.height * .055,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.all(15),
            child: Text(
              'Press on invoice no. for details',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<SalesInvoiceList>>(
              future: futureSalesInvoices,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No data found'));
                } else {
                  final invoices = filteredInvoices.value.isNotEmpty
                      ? filteredInvoices.value
                      : snapshot.data!;
                  return Scrollbar(
                    radius: Radius.circular(20),
                    thickness: 5,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: _createColumns(),
                        rows: _createRows(context, invoices),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<List<SalesInvoiceList>> _initializeSalesInvoices(
      String depotCode) async {
    // String depotCode = "DHK";

    try {
      return await fetchSalesInvoiceList(depotCode);
    } catch (e) {
      print('Error initializing sales invoices: $e');
      throw Exception('Failed to load sales invoices');
    }
  }

  Future<List<SalesInvoiceList>> fetchSalesInvoiceList(
      String vDepotCode) async {
    final url = Uri.parse(
        '${apiAccess.apiBaseUrl}/SalesMobile/Proc_SalesInvoiceListByApi?vDepotCode=$vDepotCode');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body) as Map<String, dynamic>;
      final data = jsonResponse['Table'] as List<dynamic>;
      return data.map((json) => SalesInvoiceList.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load sales invoices');
    }
  }

  List<DataColumn> _createColumns() {
    return [
      DataColumn(label: Text('Invoice No.')),
      DataColumn(label: Text('Date')),
      DataColumn(label: Text('Customer Name')),
      DataColumn(label: Text('Bill Amount')),
    ];
  }

  List<DataRow> _createRows(
      BuildContext context, List<SalesInvoiceList> invoices) {
    return invoices.map((invoice) {
      return DataRow(cells: [
        DataCell(
          TextButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/slsinvapprvl',
                arguments: new CustomerSettingScreenArgs(
                    invoice.invoiceNo, '', ''),
              );
            },
            child: Text(invoice.invoiceNo),
          ),
        ),
        DataCell(Text(invoice.invoiceDate)),
        DataCell(Text(invoice.customerName)),
        DataCell(Text(invoice.totalBillAmount.toString())),
      ]);
    }).toList();
  }
}
