import 'package:flutter/material.dart';

class Customergroupsettingscreen extends StatefulWidget {
  const Customergroupsettingscreen({super.key});

  @override
  State<Customergroupsettingscreen> createState() =>
      _CustomergroupsettingscreenState();
}

class _CustomergroupsettingscreenState
    extends State<Customergroupsettingscreen> {
  List<Map> _books = [
    {'id': 01, 'title': 'Chemist', 'author': 'Customer'},
    {'id': 02, 'title': 'Doctor', 'author': 'Customer'},
    {'id': 03, 'title': 'Institution', 'author': 'Customer'},
    {'id': 04, 'title': 'Patient', 'author': 'Customer'},
  ];

  @override
  Widget build(BuildContext context) {
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
              DataCell(Text(book['id'].toString())),
              DataCell(Text(book['title'])),
              DataCell(Text(book['author']))
            ]))
        .toList();
  }
}
