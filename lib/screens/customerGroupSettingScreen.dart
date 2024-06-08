import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../model/customerCategoryModel.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../dataaccess/apiAccess.dart' as apiAccess;

class Customergroupsettingscreen extends HookWidget {
    List<Map> _books = [];

  @override
  Widget build(BuildContext context) {
    final customerCategory = useState(null);
    final customerList = useState<List<Map>?>(null);

    Future<List<CustomerCategory>> fetchCustomerCategory() async {
      final url = Uri.parse(
          '${apiAccess.apiBaseUrl}/CustomerSettings/Proc_sal_SalesCustomerTypeListByApi');
      final response = await http.get(url);

      print(
          'object____________________________________________________________________________lllllllll');
      print(url);
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        // Assuming the list you need is under a key 'data' or similar
        List<dynamic> customerCategories = jsonResponse['Table'];
        print(
            'ffffffffffff((((((((((((((((((((((((((((((((((((()))))))))))))))))))))))))))))))))))))');
        print(customerCategories);
        List<Map> tempObj = [];
        for (var item in customerCategories) {
          print('::::::::::::::::::::::::::::::::::::::');
          var obj = {
            'code': item['cp_Code'],
            'name': item['cp_Name'],
            'new': 'Customer'
          };
          tempObj.add(obj);
          // print(obj);
          print('::::::::::::::::::::::::::::::::::::::');
        }

        customerList.value = tempObj;
        print('+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++');
        print(customerList);
        print('+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++');

        dynamic customerCategoryList = customerCategories
            .map((obj) => CustomerCategory.fromJson(obj))
            .toList();
        print(
            'ffffffffffff{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}');
        print(customerCategoryList);

        return customerCategoryList;
      } else {
        throw Exception('Failed to load data');
      }
    }

    useEffect(() {
      fetchCustomerCategory();
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sales Customer Settings',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: Colors.greenAccent[400],
      ),
      body: ListView(
        children: [
          Row(
            children: [
              Container(
                  width: MediaQuery.of(context).size.width * .7,
                  margin: EdgeInsets.all(10),
                  child: SearchBar(
                    hintText: 'Search ... ',
                    leading: IconButton(
                        onPressed: () => {}, icon: const Icon(Icons.search)),
                  )),
              ElevatedButton(
                onPressed: () => {Navigator.pop(context, '/salesmgt')},
                child: Text(
                  'Close',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: MediaQuery.of(context).size.width * .040),
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
              )
            ],
          ),
          _createDataTable()
        ],
      ),
    );
  }

  DataTable _createDataTable() {
    return DataTable(columns: _createColumns(), rows: _createRows());
  }

  List<DataColumn> _createColumns() {
    return [
      DataColumn(label: Text('Code')),
      DataColumn(label: Text('Name')),
      DataColumn(label: Text('New Customer'))
    ];
  }

  List<DataRow> _createRows() {
    return _books
        .map((book) => DataRow(cells: [
              DataCell(Text(book['code'].toString())),
              DataCell(Text(book['name'])),
              DataCell(Text(book['new']))
            ]))
        .toList();
  }
}
