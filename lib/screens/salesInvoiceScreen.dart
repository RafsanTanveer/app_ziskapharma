import 'package:flutter/material.dart';

class Salesinvoicescreen extends StatefulWidget {
  const Salesinvoicescreen({super.key});

  @override
  State<Salesinvoicescreen> createState() => _SalesinvoicescreenState();
}

class _SalesinvoicescreenState extends State<Salesinvoicescreen> {
  List<Map> _books = [
    {'id': 01, 'title': 'Chemist', 'author': 'Customer', 'bill': '2'},
    {'id': 02, 'title': 'Doctor', 'author': 'Customer', 'bill': '3'},
    {'id': 03, 'title': 'Institution', 'author': 'Customer', 'bill': '4'},
    {'id': 04, 'title': 'Patient', 'author': 'Customer', 'bill': '9'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sales Invoice Approval',
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
          Container(
              margin: EdgeInsets.all(15),
              child: Text('Press on invoice no. for details', style: TextStyle(fontWeight: FontWeight.w700),)),
          Scrollbar(
              thumbVisibility: true,
              thickness: 5,
              interactive: true,
              radius: Radius.circular(20), child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: _createDataTable()))
        ],
      ),
    );
  }

  DataTable _createDataTable() {
    return DataTable(columns: _createColumns(), rows: _createRows());
  }

  List<DataColumn> _createColumns() {
    return [
      DataColumn(label: Text('Invoice No.')),
      DataColumn(label: Text('Date')),
      DataColumn(label: Text('Customer Name')),
      DataColumn(label: Text('Bill Amount')),
    ];
  }

  List<DataRow> _createRows() {
    return _books
        .map((book) => DataRow(cells: [
              DataCell(TextButton(
                  onPressed: () =>
                      {Navigator.pushNamed(context, '/slsinvview')},
                  child: Text(book['id'].toString()))),
              DataCell(Text(book['title'])),
              DataCell(Text(book['author'])),
              DataCell(Text(book['bill'].toString())),
            ]))
        .toList();
  }
}
