import 'package:flutter/material.dart';

class CustomerSettingScreen extends StatelessWidget {
  const CustomerSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Customer Information Settings',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: MediaQuery.of(context).size.height*.022
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

                  textFeild("Type Name", "Type Name"),
                  textFeild("Territory Code", "Territory Code"),
                  textFeild("Territory Name", "Territory Name"),
                  textFeild("Customer Name", "Customer Name *"),
                  textFeild("Address", "Address *"),
                  textFeild("Mobile", "Mobile *"),
                  textFeild("Mobile", "Mobile *"),
                  textFeild("Category Code", "Category Code"),
                  textFeild("Category Name", "Category Name"),
                  textFeild("Ref. Code", "Ref. Code"),
                  textFeild("Ref. Name", "Ref. Name"),
                  textFeild("Rules No.", "Rules No."),
                  textFeild("Rules Name.", "Rules Name."),
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
                              onPressed: () => {},
                              child: Text(
                                'SENT',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            .020),
                              ))),
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
                              'BAC',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: MediaQuery.of(context).size.height *
                                      .020),
                            )),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget textFeild(String hint, String title) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 12),
          child: TextFormField(
            decoration: InputDecoration(
                hintText: hint, enabledBorder: const OutlineInputBorder()),
          ),
        ),
      ],
    );
  }
}
